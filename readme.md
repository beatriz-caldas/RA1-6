# Compilador de Expressões RPN para ARMv7

## Integrantes do Grupo (RA1-6)

* Beatriz Caldas (beatriz-caldas)
* Eduardo Pianovski (DuduPNetto)
* Lucas Gasperin (Lucas-PG)
* Lucas Sotomaior (LucasSotomaiorAPereira)

---

## Visão Geral

Este projeto implementa um compilador simples para uma linguagem de expressões aritméticas em **Notação Polonesa Reversa (RPN)**. O programa lê um arquivo de texto com expressões, analisa cada uma usando um analisador léxico baseado em Autômato Finito Determinístico (AFD) e gera código Assembly compatível com o emulador **CPUlator ARMv7 DE1-SoC**, que executa os cálculos diretamente no hardware simulado e exibe os resultados nos displays de 7 segmentos.

---

## Arquitetura do Sistema

O compilador é organizado em três etapas que trabalham em sequência: análise léxica, avaliação das expressões e geração de Assembly.

### Etapa 1 — Analisador Léxico (AFD)

A função `parseExpressao` converte cada linha de texto em uma lista de tokens usando um Autômato Finito Determinístico onde cada estado é uma função Python. O autômato começa em `estadoInicial` e transita entre os estados abaixo conforme os caracteres lidos:

| Estado | Comportamento | Token Gerado |
| :--- | :--- | :--- |
| `estadoInicial` | Ignora espaços. Direciona cada caractere para o estado correto. Levanta erro se o caractere for inválido (ex: `@`, letras minúsculas). | — |
| `estadoParenteses` | Registra `(` ou `)` e mantém um contador interno para verificar balanceamento. Ao final da linha, se o contador não for zero, levanta erro. | `AP` ou `FP` |
| `estadoNumero` | Lê dígitos e aceita um único ponto decimal. Absorve o sinal `-` como parte do número quando ele aparece no início da linha, após espaço ou após `(`. Rejeita formatos inválidos como `3.14.15`, `3.` ou `3,14`. | `NUM` |
| `estadoOperador` | Captura os operadores `+`, `-`, `*`, `%` e `^`. | `OP` |
| `estadoBarra` | Usa *lookahead* de um caractere para distinguir `/` (divisão real) de `//` (divisão inteira). | `OP` |
| `estadoIdentificador` | Lê sequências de letras **exclusivamente maiúsculas**. Rejeita misturas como `VAr` ou `VAR1`. Verifica se o lexema é a palavra reservada `RES`; caso contrário, trata como nome de variável. | `CMD` (para `RES`) ou `VAR` |

### Etapa 2 — Avaliador de Expressões (`executarExpressao`)

A avaliação usa uma pilha para processar os tokens em ordem. A lógica é:

- Ao encontrar `AP` (`(`), empilha o marcador `"("`.
- Ao encontrar `NUM`, converte para `float` e empilha.
- Ao encontrar `OP`, desempilha os dois valores do topo, aplica a operação e empilha o resultado.
- Ao encontrar `FP` (`)`), desempilha o resultado do topo, remove o marcador `"("` correspondente e reempilha o resultado — o que permite expressões aninhadas funcionarem naturalmente.
- Ao encontrar `VAR`, verifica o contexto: se o topo for `"("`, é uma leitura de variável; caso contrário, é um armazenamento.
- Ao encontrar `CMD` (`RES`), desempilha o número `N` e busca o resultado `N` posições atrás no histórico (índice `resultados[-N]`).

Ao final, a pilha deve conter exatamente um valor `float`; qualquer outra situação é tratada como expressão mal formada.

As operações suportadas são `+`, `-`, `*`, `/`, `//`, `%` e `^`. Divisão por zero é detectada em tempo de execução. Para `^`, o expoente deve ser um inteiro positivo.

### Etapa 3 — Gerador de Assembly (`gerarAssembly`)

A função `gerarAssembly` traduz os tokens diretamente para instruções ARMv7, usando a FPU (Unidade de Ponto Flutuante) para todos os cálculos.

**Cálculos numéricos:** constantes são armazenadas na seção `.data` como `.double` (IEEE 754, 64 bits) e carregadas nos registradores `d0`–`d5` via `VLDR.F64`. A pilha de operandos é gerenciada com `VPUSH` e `VPOP`.

**Variáveis e histórico:** variáveis nomeadas e resultados anteriores (acessados por `RES`) ficam na seção `.bss`. O índice de `RES` é resolvido em tempo de compilação — o gerador calcula qual `res_N` referenciar no momento em que gera o código, não em tempo de execução.

**Exibição via MMIO:** ao final de cada expressão, o resultado inteiro é decomposto dígito a dígito por subtração repetida por 10 (equivalente ao módulo), consultado em uma tabela de 7 segmentos (`tabela_7seg`) e enviado para os registradores de display:

| Endereço | Dispositivo |
| :--- | :--- |
| `0xFF200020` | Display HEX0–HEX3 (dígitos + separador decimal) |
| `0xFF200030` | Display HEX4–HEX5 (dígitos mais significativos e sinal) |
| `0xFF200000` | LEDs vermelhos (recebem o valor inteiro absoluto do resultado) |

---

## Testes do Analisador Léxico

A função `testar_fsm_lexico()` é executada automaticamente toda vez que o programa roda. Ela cobre casos válidos e inválidos para garantir que o AFD está se comportando corretamente.

**Entradas válidas testadas:**

```
(3.14 2.0 +)
RES 1 +
VAR //
10 3 %
```

**Entradas inválidas testadas** (cada uma deve levantar o erro exato esperado):

| Entrada | Erro Esperado |
| :--- | :--- |
| `.5` | Número não pode começar com ponto |
| `var` | Identificador deve ser em maiúsculas |
| `3 @ 2` | Caractere léxico inválido |
| `3 2 + )` | `)` sem `(` correspondente |
| `3.14.15` | Múltiplos pontos no número |
| `3.` | Número não pode terminar em ponto |
| `3,14` | Vírgula não é separador decimal |
| `3A` | Número não pode ser seguido de letras |
| `VAr` | Identificador com letra minúscula |
| `VAR1` | Identificador com dígito |
| `( 3 2 +` | Parênteses desbalanceados (falta fechar) |

Se todos os testes passarem, o programa imprime no terminal:

```
Testes unitários do Analisador Léxico concluídos com sucesso.
```

---

## Pré-requisitos

- **Python 3.10 ou superior** — o código usa a sintaxe `match/case`, disponível a partir dessa versão.
- Nenhuma biblioteca externa é necessária.

---

## Como Executar

### Passo 1 — Gerar os arquivos

No terminal, execute o programa passando o arquivo de teste como argumento:

```bash
python analisador_lexico.py teste1.txt
```

A saída esperada no terminal é:

```
Testes unitários do Analisador Léxico concluídos com sucesso.

Resultados das Expressões
Linha 1: 5.1
Linha 2: 5.0
...

Arquivo de tokens gerado com sucesso.
Arquivo Assembly 'saida.s' gerado com sucesso.
```

Se alguma linha do arquivo contiver uma expressão inválida, o programa exibe o erro daquela linha específica, ignora ela e continua processando as demais.

Dois arquivos são gerados na mesma pasta:

- `tokens_gerados.txt` — lista de tokens extraídos de cada linha.
- `saida.s` — código Assembly pronto para rodar no CPUlator.

### Passo 2 — Executar no CPUlator

1. Abra o arquivo `saida.s` recém-gerado e copie todo o seu conteúdo.
2. Acesse o emulador: [CPUlator ARMv7 DE1-SoC](https://cpulator.01xz.net/?sys=arm-de1soc).
3. Cole o código no painel **Editor**.
4. Clique em **Compile and Load** (F5).
5. Clique em **Continue** (F3) para executar.
6. Observe os displays HEX no painel **Devices** mostrando os resultados.

---

## Interpretando os Resultados

Os displays de 7 segmentos não têm um ponto decimal nativo, então o programa usa o segmento `g` (traço do meio, código `0x08`) como separador visual. Por exemplo, o valor `8.8` aparece nos displays como `8_8`.

Se o resultado for negativo, o segmento de sinal de menos (`-`, código `0x40`) é aceso no display mais à esquerda. Por exemplo, `-8.8` seria exibido como `-008_8`. Os LEDs vermelhos recebem o valor inteiro absoluto do resultado via MMIO.

---

## Exemplos Práticos

### Entrada

```
(3.14 2.0 +)
```

### Tokens gerados (`tokens_gerados.txt`)

```
Linha 1: [('AP', '('), ('NUM', '3.14'), ('NUM', '2.0'), ('OP', '+'), ('FP', ')')]
```

### Trecho do Assembly gerado (`saida.s`)

```asm
    @ NOVA EXPRESSAO RPN
    LDR r0, =const_num_0        @ Endereço da constante 3.14
    VLDR.F64 d0, [r0]           @ Carrega 3.14 em d0
    VPUSH {d0}                  @ Empilha

    LDR r0, =const_num_1        @ Endereço da constante 2.0
    VLDR.F64 d0, [r0]           @ Carrega 2.0 em d0
    VPUSH {d0}                  @ Empilha

    VPOP {d1}                   @ Desempilha 2.0 → d1
    VPOP {d0}                   @ Desempilha 3.14 → d0
    VADD.F64 d2, d0, d1         @ d2 = d0 + d1 (5.14)
    VPUSH {d2}                  @ Empilha resultado

    VPOP {d0}                   @ Resultado final
    LDR r0, =res_0
    VSTR.F64 d0, [r0]           @ Salva em memória (.bss)
```

---

## Resolução de Ambiguidades da Linguagem

### Sinal negativo vs. operador de subtração

O caractere `-` é interpretado como início de número negativo **apenas se** for imediatamente seguido por um dígito **e** ocorrer em uma dessas posições: início da linha, após espaço em branco, ou após `(`. Em qualquer outro contexto, é tratado como operador `OP`.

### Divisão real (`/`) vs. divisão inteira (`//`)

O estado `estadoBarra` usa *lookahead* para verificar se o próximo caractere também é `/`. Se sim, gera o token `OP //`; caso contrário, gera `OP /`.

- `/` → `VDIV.F64 d2, d0, d1` (resultado em ponto flutuante)
- `//` → divisão real seguida de `VCVT.S32.F64` + `VCVT.F64.S32` (trunca a parte fracionária)

### Comando `RES N`

`N` indica quantos resultados anteriores retroceder: `(1 RES)` retorna o último resultado, `(2 RES)` o penúltimo, e assim por diante. Em Python, isso é implementado como `resultados[-N]`. No Assembly gerado, o índice é calculado em tempo de compilação — o gerador resolve qual label `res_N` usar no momento da tradução.

### Variáveis de memória

Qualquer sequência de letras maiúsculas (ex: `MEM`, `VAR`, `X`) funciona como nome de variável. A sintaxe `(10.5 MEM)` armazena o valor; `(MEM)` recupera. Se uma variável for lida antes de ser inicializada, o valor retornado é `0.0`. Cada arquivo de texto representa um escopo de memória independente.
