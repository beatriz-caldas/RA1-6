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

            if c in "+-*%^":
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
            e reais com ponto decimal.
            """
            lexema = ""
            tem_ponto = False

            while i < n and (linha[i].isdigit() or linha[i] == "."):
                if linha[i] == ".":
                    if tem_ponto:
                        raise ValueError(
                            f"Número malformado: múltiplos pontos em '{lexema + linha[i]}'"
                        )
                    tem_ponto = True

                lexema += linha[i]
                i += 1

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
        Recebe tokens de parseExpressao e atualisa resultados e MEM

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
                        pilha.append(float(int(a) // int(b)))
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
