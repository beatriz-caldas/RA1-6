# Beatriz Caldas | beatriz-caldas
# Eduardo Pianovski | DuduPNetto
# Lucas Gasperin | Lucas-PG
# Lucas Sotomaior | LucasSotomaiorAPereira
# GRUPO | RA1-6

import sys

# AP -> abre parentese
# FP -> fecha parentese
# NUM -> número
# OP -> operador
# CMD -> RES
# VAR -> memória/identificador em maiúsculas


class AnalisadorLexico:
    """Classe responsável pela análise léxica das expressões da linguagem."""

    def lerArquivo(self, nome_arquivo: str) -> list:
        """
        Lê um arquivo de expressões e retorna as linhas não vazias.

        Args:
            nome_arquivo (str): Nome do arquivo de entrada.

        Returns:
            list: Lista contendo as linhas válidas do arquivo.
        """
        linhas = []

        try:
            with open(nome_arquivo, "r", encoding="utf-8") as arquivo:
                for linha in arquivo:
                    linha_limpa = linha.strip()
                    if linha_limpa:
                        linhas.append(linha_limpa)

            return linhas

        except FileNotFoundError:
            print(f"Erro: Arquivo '{nome_arquivo}' não encontrado.")
            sys.exit(1)

    def parseExpressao(self, linha: str, tokens: list) -> None:
        """
        Analisa uma linha da linguagem e extrai seus tokens usando
        um Autômato Finito Determinístico com estados em funções.

        Args:
            linha (str): Linha da expressão a ser analisada.
            tokens (list): Lista onde os tokens reconhecidos serão armazenados.

        Returns:
            None
        """
        n = len(linha)
        parenteses_abertos = 0

        def inicia_numero_negativo(i: int) -> bool:
            """
            Verifica se o caractere '-' na posição atual deve ser
            interpretado como início de um número negativo.

            Args:
                i (int): Índice atual da linha.

            Returns:
                bool: True se o '-' iniciar um número negativo;
                False caso contrário.
            """
            if linha[i] != "-":
                return False

            if i + 1 >= n or not linha[i + 1].isdigit():
                return False

            if i == 0:
                return True

            if linha[i - 1].isspace() or linha[i - 1] == "(":
                return True

            return False

        def estadoInicial(i: int):
            """
            Estado inicial do autômato.
            Decide qual estado deve processar o caractere atual.
            """
            if i >= n:
                return None, i

            c = linha[i]

            if c.isspace():
                return estadoInicial, i + 1

            if c == "(" or c == ")":
                return estadoParenteses, i

            if c == "-":
                if inicia_numero_negativo(i):
                    return estadoNumero, i
                return estadoOperador, i

            if c in "+*%^":
                return estadoOperador, i

            if c == "/":
                return estadoBarra, i

            if c.isdigit():
                return estadoNumero, i

            if c.isupper():
                return estadoIdentificador, i

            if c == ".":
                raise ValueError("Número malformado: número não pode começar com ponto")

            if c.isalpha():
                raise ValueError(
                    f"Identificador inválido: '{c}'. Use apenas letras maiúsculas"
                )

            raise ValueError(f"Caractere léxico inválido: {c}")

        def estadoParenteses(i: int):
            """
            Estado responsável por reconhecer parênteses
            e controlar o balanceamento.
            """
            nonlocal parenteses_abertos

            c = linha[i]

            if c == "(":
                parenteses_abertos += 1
                tokens.append(("AP", "("))

            elif c == ")":
                parenteses_abertos -= 1

                if parenteses_abertos < 0:
                    raise ValueError(
                        "Parênteses desbalanceados: ')' sem '(' correspondente"
                    )

                tokens.append(("FP", ")"))

            return estadoInicial, i + 1

        def estadoOperador(i: int):
            """
            Estado responsável por reconhecer operadores simples.
            """
            c = linha[i]
            tokens.append(("OP", c))
            return estadoInicial, i + 1

        def estadoBarra(i: int):
            """
            Estado responsável por distinguir divisão real (/)
            de divisão inteira (//).
            """
            if i + 1 < n and linha[i + 1] == "/":
                tokens.append(("OP", "//"))
                return estadoInicial, i + 2

            tokens.append(("OP", "/"))
            return estadoInicial, i + 1

        def estadoNumero(i: int):
            """
            Estado responsável por reconhecer números inteiros
            e reais com ponto decimal, incluindo números negativos.
            """
            lexema = ""
            tem_ponto = False

            if linha[i] == "-":
                lexema += "-"
                i += 1

            while i < n and (linha[i].isdigit() or linha[i] == "."):
                if linha[i] == ".":
                    if tem_ponto:
                        raise ValueError(
                            f"Número malformado: múltiplos pontos em '{lexema + linha[i]}'"
                        )
                    tem_ponto = True

                lexema += linha[i]
                i += 1

            if lexema == "-":
                raise ValueError("Número malformado: '-' isolado não é número")

            if lexema.endswith("."):
                raise ValueError(f"Número malformado: {lexema}")

            if i < n and linha[i] == ",":
                raise ValueError(
                    f"Número malformado: use ponto em vez de vírgula em '{lexema},'"
                )

            if i < n and linha[i].isalpha():
                raise ValueError(
                    f"Token inválido: número não pode ser seguido de letras em '{lexema + linha[i]}'"
                )

            tokens.append(("NUM", lexema))
            return estadoInicial, i

        def estadoIdentificador(i: int):
            """
            Estado responsável por reconhecer identificadores
            e a palavra reservada RES.
            """
            lexema = ""

            while i < n and linha[i].isupper():
                lexema += linha[i]
                i += 1

            if i < n and linha[i].isalpha() and not linha[i].isupper():
                raise ValueError(
                    f"Identificador inválido: '{lexema + linha[i]}'. Use apenas letras maiúsculas"
                )

            if i < n and linha[i].isdigit():
                raise ValueError(
                    f"Identificador inválido: '{lexema + linha[i]}'. Letras e números não podem ficar juntos"
                )

            if lexema == "RES":
                tokens.append(("CMD", lexema))
            else:
                tokens.append(("VAR", lexema))

            return estadoInicial, i

        estadoAtual = estadoInicial
        indice = 0

        while estadoAtual is not None:
            estadoAtual, indice = estadoAtual(indice)

        if parenteses_abertos != 0:
            raise ValueError("Parênteses desbalanceados na expressão")


class CalcularExpressao:
    def __init__(self):
        self.MEM = {}
        self.resultados = []

    def executarExpressao(self, tokens: list) -> float:
        """
        Recebe tokens de parseExpressao e atualiza resultados e MEM

        Args:
            tokens (list): Lista de tokens de uma linha vindos de parseExpressao

        Returns:
            float: Resultado final das operações da linha
        """
        MEM = self.MEM
        resultados = self.resultados
        pilha = []

        for tipo, valor in tokens:
            if tipo == "AP":
                pilha.append("(")

            elif tipo == "FP":
                if not pilha:
                    raise ValueError("Parênteses desbalanceados, ) encontrado sem (.")
                res = pilha.pop()
                if not isinstance(res, float):
                    raise ValueError(
                        f"Expressão mal formada: esperado NUM, encontrado {res}"
                    )
                if not pilha or pilha[-1] != "(":
                    raise ValueError("Parênteses desbalanceados: ( não encontrada.")

                # Retirar ( correspondente
                pilha.pop()
                pilha.append(res)

            elif tipo == "VAR":
                if pilha and pilha[-1] == "(":
                    # Caso (MEM) puxa var
                    pilha.append(MEM.get(valor, 0.0))
                else:
                    # Caso (1.0 MEM) guarda var
                    v = pilha.pop()
                    MEM[valor] = v

                    # Coloca o valor guardado como resultado de operacao
                    # Pode nao ser o comportamento que esperamos, verificar
                    pilha.append(v)

            elif tipo == "CMD" and valor == "RES":
                if not pilha or not isinstance(pilha[-1], float):
                    raise ValueError("Falta argumento numérico para RES")

                n = pilha.pop()
                if not n.is_integer():
                    raise ValueError(f"RES inválido: N deve ser inteiro, recebeu {n}")

                if n <= 0 or n > len(resultados):
                    raise IndexError(
                        f"RES inválido, menos de {int(n)} resultados disponíveis"
                    )

                pilha.append(resultados[-int(n)])

            elif tipo == "NUM":
                try:
                    pilha.append(float(valor))
                except ValueError:
                    # Se nao for um numero
                    raise ValueError(f"Token NUM inválido: {valor}")

            elif tipo == "OP":
                if len(pilha) < 2:
                    raise IndexError(f"NUMS insuficientes para operação {valor}.")

                b = pilha.pop()
                a = pilha.pop()

                if not isinstance(a, float) or not isinstance(b, float):
                    raise ValueError(f"Operador {valor}: NUMS inválidos {a} e {b}.")

                match valor:
                    case "+":
                        pilha.append(float(a + b))
                    case "-":
                        pilha.append(float(a - b))
                    case "*":
                        pilha.append(float(a * b))
                    case "^":
                        if not b.is_integer() or b <= 0:
                            raise ValueError(f"Expoente inválido: {b}")
                        pilha.append(float(a ** int(b)))
                    case "%":
                        if b == 0:
                            raise ZeroDivisionError("Divisão por zero.")
                        pilha.append(float(int(a) % int(b)))
                    case "//":
                        if b == 0:
                            raise ZeroDivisionError("Divisão por zero.")
                        pilha.append(float(int(a / b)))
                    case "/":
                        if b == 0:
                            raise ZeroDivisionError("Divisão por zero.")
                        pilha.append(float(a / b))
                    case _:
                        raise ValueError(f"Operador inválido {valor}")

        if len(pilha) != 1 or not isinstance(pilha[0], float):
            # No fim do loop a pilha vai ter apenas um valor, o resultado
            raise ValueError("Expressão mal formada")

        resultado = pilha[0]
        resultados.append(resultado)
        return resultado


class GeradorAssembly:
    """Classe para gerar assembly a partir de uma lista de tokens."""

    def __init__(self) -> None:
        """
        Inicializa uma classe GeradorAssembly.

        Returns:
            None
        """
        self.asm_data = []
        self.asm_bss = set()
        self.contador_constantes = 0
        self.codigo_assembly = []
        self.contador_labels = 0
        self.contador_resultados = 0

    def gerarAssembly(self, tokens: list):
        """
        Traduz os tokens RPN para uma Máquina de Pilha em ARMv7.

        Args:
            tokens (list): A lista de tokens RPN.

        Returns:
            None
        """
        self.codigo_assembly.append("    @ NOVA EXPRESSAO RPN")
        prev_valor = None
        prev_tipo = None
        for tipo, valor in tokens:
            if tipo == "NUM":
                nome_constante = f"const_num_{self.contador_constantes}"
                self.contador_constantes += 1
                self.asm_data.append(f"{nome_constante}: .double {valor}")
                self.codigo_assembly.append(f"    LDR r0, ={nome_constante}")
                self.codigo_assembly.append("    VLDR.F64 d0, [r0]")
                self.codigo_assembly.append("    VPUSH {d0}")
            elif tipo == "OP":
                self.codigo_assembly.append("    VPOP {d1}")
                self.codigo_assembly.append("    VPOP {d0}")
                if valor == "+":
                    self.codigo_assembly.append("    VADD.F64 d2, d0, d1")
                elif valor == "-":
                    self.codigo_assembly.append("    VSUB.F64 d2, d0, d1")
                elif valor == "*":
                    self.codigo_assembly.append("    VMUL.F64 d2, d0, d1")
                elif valor == "/":
                    self.codigo_assembly.append("    VDIV.F64 d2, d0, d1")
                elif valor == "//":
                    self.codigo_assembly.append("    VDIV.F64 d2, d0, d1")
                    self.codigo_assembly.append("    VCVT.S32.F64 s0, d2")
                    self.codigo_assembly.append("    VCVT.F64.S32 d2, s0")
                elif valor == "%":
                    self.codigo_assembly.append("    VCVT.S32.F64 s0, d0")
                    self.codigo_assembly.append("    VCVT.S32.F64 s2, d1")
                    self.codigo_assembly.append("    VCVT.F64.S32 d0, s0")
                    self.codigo_assembly.append("    VCVT.F64.S32 d1, s2")
                    self.codigo_assembly.append("    VDIV.F64 d3, d0, d1")
                    self.codigo_assembly.append("    VCVT.S32.F64 s4, d3")
                    self.codigo_assembly.append("    VCVT.F64.S32 d3, s4")
                    self.codigo_assembly.append("    VMUL.F64 d3, d3, d1")
                    self.codigo_assembly.append("    VSUB.F64 d2, d0, d3")
                elif valor == "^":
                    label = f"pow_loop_{self.contador_labels}"
                    end = f"pow_end_{self.contador_labels}"
                    self.contador_labels += 1
                    self.codigo_assembly.append("    VMOV.F64 d2, d0")
                    self.codigo_assembly.append("    VCVT.S32.F64 s0, d1")
                    self.codigo_assembly.append("    VMOV r1, s0")
                    self.codigo_assembly.append(f"{label}:")
                    self.codigo_assembly.append("    SUB r1, r1, #1")
                    self.codigo_assembly.append("    CMP r1, #0")
                    self.codigo_assembly.append(f"    BEQ {end}")
                    self.codigo_assembly.append("    VMUL.F64 d2, d2, d0")
                    self.codigo_assembly.append(f"    B {label}")
                    self.codigo_assembly.append(f"{end}:")
                self.codigo_assembly.append("    VPUSH {d2}")
            elif tipo == "CMD":
                linha = (self.contador_resultados) - int(prev_valor)
                if linha < 0:
                    raise ValueError("RES referencia resultado inexistente")
                self.codigo_assembly.append(f"    LDR r0, =res_{linha}")
                self.codigo_assembly.append("    VLDR.F64 d0, [r0]")
                self.codigo_assembly.append("    VPUSH {d0}")
            elif tipo == "VAR":
                self.asm_bss.add(valor)
                if prev_tipo == "AP":
                    self.codigo_assembly.append(f"    LDR r0, =var_{valor}")
                    self.codigo_assembly.append("    VLDR.F64 d0, [r0]")
                    self.codigo_assembly.append("    VPUSH {d0}")
                else:
                    self.codigo_assembly.append("    VPOP {d0}")
                    self.codigo_assembly.append(f"    LDR r0, =var_{valor}")
                    self.codigo_assembly.append("    VSTR.F64 d0, [r0]")
                    self.codigo_assembly.append("    VPUSH {d0}")
            prev_valor = valor
            prev_tipo = tipo
        nome_res = f"res_{self.contador_resultados}"
        self.asm_bss.add(nome_res)
        self.codigo_assembly.append("    VPOP {d0}")
        self.codigo_assembly.append(f"    LDR r0, =res_{self.contador_resultados}")
        self.codigo_assembly.append("    VSTR.F64 d0, [r0]")
        self.codigo_assembly.append("    VCVT.S32.F64 s0, d0")
        self.codigo_assembly.append("    VMOV r1, s0")
        self.codigo_assembly.append("    CMP r1, #0")
        self.codigo_assembly.append("    RSBLT r1, r1, #0")
        self.codigo_assembly.append("    LDR r2, =0xFF200000")
        self.codigo_assembly.append("    STR r1, [r2]")
        nome_dez = f"const_num_{self.contador_constantes}"
        self.contador_constantes += 1
        self.asm_data.append(f"{nome_dez}: .double 10.0")
        self.codigo_assembly.append("    VCVT.S32.F64 s0, d0")
        self.codigo_assembly.append("    VMOV r11, s0")
        self.codigo_assembly.append(f"    LDR r0, =res_{self.contador_resultados}")
        self.codigo_assembly.append("    VLDR.F64 d0, [r0]")
        self.codigo_assembly.append(f"    LDR r0, ={nome_dez}")
        self.codigo_assembly.append("    VLDR.F64 d5, [r0]")
        self.codigo_assembly.append("    VMUL.F64 d5, d0, d5")
        self.codigo_assembly.append("    VCVT.S32.F64 s10, d5")
        self.codigo_assembly.append("    VMOV r10, s10")
        label_pos = f"pos_{self.contador_labels}"
        self.contador_labels += 1
        self.codigo_assembly.append("    MOV r4, #0")
        self.codigo_assembly.append("    CMP r11, #0")
        self.codigo_assembly.append(f"    BGE {label_pos}")
        self.codigo_assembly.append("    RSB r11, r11, #0")
        self.codigo_assembly.append("    RSB r10, r10, #0")
        self.codigo_assembly.append("    MOV r4, #1")
        self.codigo_assembly.append(f"{label_pos}:")
        label_mod = f"mod_dec_{self.contador_labels}"
        label_mod_end = f"mod_dec_end_{self.contador_labels}"
        self.contador_labels += 1
        self.codigo_assembly.append("    MOV r6, r10")
        self.codigo_assembly.append("    MOV r5, #0")
        self.codigo_assembly.append(f"{label_mod}:")
        self.codigo_assembly.append("    CMP r6, #10")
        self.codigo_assembly.append(f"    BLT {label_mod_end}")
        self.codigo_assembly.append("    SUB r6, r6, #10")
        self.codigo_assembly.append("    ADD r5, r5, #1")
        self.codigo_assembly.append(f"    B {label_mod}")
        self.codigo_assembly.append(f"{label_mod_end}:")
        self.codigo_assembly.append("    MOV r9, r6")
        self.codigo_assembly.append("    LDR r7, =tabela_7seg")
        self.codigo_assembly.append("    MOV r12, #0")
        self.codigo_assembly.append("    MOV r14, #0")
        self.codigo_assembly.append("    LDRB r8, [r7, r9]")
        self.codigo_assembly.append("    ORR r12, r12, r8")
        self.codigo_assembly.append("    MOV r8, #0x08")
        self.codigo_assembly.append("    LSL r8, r8, #8")
        self.codigo_assembly.append("    ORR r12, r12, r8")
        for i in range(3):
            label_div = f"div_loop_{self.contador_labels}"
            label_end = f"div_end_{self.contador_labels}"
            self.contador_labels += 1
            self.codigo_assembly.append("    MOV r5, #0")
            self.codigo_assembly.append("    MOV r6, r11")
            self.codigo_assembly.append(f"{label_div}:")
            self.codigo_assembly.append("    CMP r6, #10")
            self.codigo_assembly.append(f"    BLT {label_end}")
            self.codigo_assembly.append("    SUB r6, r6, #10")
            self.codigo_assembly.append("    ADD r5, r5, #1")
            self.codigo_assembly.append(f"    B {label_div}")
            self.codigo_assembly.append(f"{label_end}:")
            self.codigo_assembly.append("    LDRB r8, [r7, r6]")
            if i == 0:
                self.codigo_assembly.append("    LSL r8, r8, #16")
                self.codigo_assembly.append("    ORR r12, r12, r8")
            elif i == 1:
                self.codigo_assembly.append("    LSL r8, r8, #24")
                self.codigo_assembly.append("    ORR r12, r12, r8")
            else:
                self.codigo_assembly.append("    ORR r14, r14, r8")
            self.codigo_assembly.append("    MOV r11, r5")
        label_end_sign = f"end_sign_{self.contador_labels}"
        self.contador_labels += 1
        self.codigo_assembly.append("    CMP r4, #1")
        self.codigo_assembly.append(f"    BNE {label_end_sign}")
        self.codigo_assembly.append("    MOV r8, #0x40")
        self.codigo_assembly.append("    LSL r8, r8, #8")
        self.codigo_assembly.append("    ORR r14, r14, r8")
        self.codigo_assembly.append(f"{label_end_sign}:")
        self.codigo_assembly.append("    LDR r3, =0xFF200020")
        self.codigo_assembly.append("    STR r12, [r3]")
        self.codigo_assembly.append("    LDR r3, =0xFF200030")
        self.codigo_assembly.append("    STR r14, [r3]")
        skip_label = f"ltorg_skip_{self.contador_resultados}"
        self.codigo_assembly.append(f"    B {skip_label}")
        self.codigo_assembly.append(".ltorg")
        self.codigo_assembly.append(f"{skip_label}:")
        self.codigo_assembly.append("")
        self.contador_resultados += 1

    def exportarArquivoAssembly(self, nome_saida: str) -> None:
        """
        Exporta um código assembly gerado para um arquivo .s para execução.

        Args:
            nome_saida (str): O nome do arquivo de saída.

        Returns:
            None
        """
        asm_final = [
            "@ Beatriz Caldas",
            "@ Eduardo Pianovski",
            "@ Lucas Gasperin",
            "@ Lucas Sotomaior",
            "@ Grupo: RA1 6",
            "@ Link Repositorio: https://github.com/beatriz-caldas/RA1-6",
            "",
            ".text",
            ".global _start",
            "_start:",
        ]
        asm_final.extend(self.codigo_assembly)
        asm_final.extend([".ltorg", "fim:", "    B fim", ""])
        if self.asm_data:
            asm_final.append(".data")
            asm_final.extend(self.asm_data)
            asm_final.append("tabela_7seg:")
            asm_final.append("    .byte 0x3F")
            asm_final.append("    .byte 0x06")
            asm_final.append("    .byte 0x5B")
            asm_final.append("    .byte 0x4F")
            asm_final.append("    .byte 0x66")
            asm_final.append("    .byte 0x6D")
            asm_final.append("    .byte 0x7D")
            asm_final.append("    .byte 0x07")
            asm_final.append("    .byte 0x7F")
            asm_final.append("    .byte 0x6F")
            asm_final.append("")
        if self.asm_bss:
            asm_final.append(".bss")
            for var in self.asm_bss:
                if var.startswith("res_"):
                    asm_final.append(f"{var}: .space 8")
                else:
                    asm_final.append(f"var_{var}: .space 8")
        with open(nome_saida, "w", encoding="utf-8") as file:
            file.write("\n".join(asm_final))


def testar_fsm_lexico() -> None:
    """
    Testes unitários para validar o analisador léxico.
    """
    lex = AnalisadorLexico()

    casos_sucesso = [
        "(3.14 2.0 +)",
        "(3.14 2.0 -)",
        "(3.14 2.0 *)",
        "(7.0 2.0 /)",
        "(7.0 2.0 //)",
        "10 3 %",
        "(2.0 3.0 ^)",
        "(-3.14 2.0 +)",
        "((2.0 3.0 *) 4.0 +)",
        "(5.0 MEM)",
        "(MEM)",
        "(2 RES)",
        "RES 1 +",
        "VAR //",
    ]

    for caso in casos_sucesso:
        tokens = []
        try:
            lex.parseExpressao(caso, tokens)
            assert (
                len(tokens) > 0
            ), f"Falha: O FSM não gerou tokens para uma entrada válida: '{caso}'."
        except ValueError as e:
            print(f"Falha inesperada no teste de sucesso '{caso}': {e}")

    casos_erro = [
        (".5", "Número malformado: número não pode começar com ponto"),
        ("var", "Identificador inválido: 'v'. Use apenas letras maiúsculas"),
        ("3 @ 2", "Caractere léxico inválido: @"),
        ("3 2 + )", "Parênteses desbalanceados: ')' sem '(' correspondente"),
        ("3.14.15", "Número malformado: múltiplos pontos em '3.14.'"),
        ("3.", "Número malformado: 3."),
        ("3,14", "Número malformado: use ponto em vez de vírgula em '3,'"),
        ("3A", "Token inválido: número não pode ser seguido de letras em '3A'"),
        ("VAr", "Identificador inválido: 'VAr'. Use apenas letras maiúsculas"),
        (
            "VAR1",
            "Identificador inválido: 'VAR1'. Letras e números não podem ficar juntos",
        ),
        ("( 3 2 +", "Parênteses desbalanceados na expressão"),
    ]

    for caso, erro_esperado in casos_erro:
        tokens = []
        passou_sem_erro = False
        try:
            lex.parseExpressao(caso, tokens)
            passou_sem_erro = True
        except ValueError as e:
            assert (
                str(e) == erro_esperado
            ), f"Erro divergente para '{caso}'.\nEsperado: '{erro_esperado}'\nObtido: '{e}'"

        if passou_sem_erro:
            print(
                f"Falha no teste: A expressão '{caso}' deveria ter falhado, mas passou."
            )

    print("Testes unitários do Analisador Léxico concluídos com sucesso.\n")


def exibirResultados(resultados: list) -> None:
    """
    Exibe os resultados das expressões com uma casa decimal.
    """

    print("Resultados das Expressões")
    for i, res in resultados.items():
        if res != None:
            print(f"Linha {i}: {res:.1f}")


def main():
    if len(sys.argv) != 2:
        print(
            "Por favor, entre com o nome do arquivo de teste, e apenas o nome do arquivo de teste."
        )
        print("Ex.: python analisador_lexico.py teste1.txt")
        sys.exit(1)

    testar_fsm_lexico()

    nome_arquivo_input = sys.argv[1]

    lexico = AnalisadorLexico()
    calc = CalcularExpressao()
    gerador_asm = GeradorAssembly()

    linhas = lexico.lerArquivo(nome_arquivo_input)

    todos_os_tokens = []
    resultados = {}

    for i, linha in enumerate(linhas):
        tokens = []
        try:
            lexico.parseExpressao(linha, tokens)

            resultado = calc.executarExpressao(tokens)

            gerador_asm.gerarAssembly(tokens)

            todos_os_tokens.append(tokens)

            resultados[i + 1] = resultado

        except Exception as e:
            resultados[i + 1] = None
            print(f"Erro na linha {i+1}: {linha.strip()}\n  -> {e}\n")

    exibirResultados(resultados)

    if todos_os_tokens:
        with open("tokens_gerados.txt", "w", encoding="utf-8") as f:
            for idx, t_list in enumerate(todos_os_tokens):
                f.write(f"Linha {idx+1}: {t_list}\n")
        print("\nArquivo de tokens gerado com sucesso.")

        gerador_asm.exportarArquivoAssembly("saida.s")
        print("Arquivo Assembly 'saida.s' gerado com sucesso.")


if __name__ == "__main__":
    main()
