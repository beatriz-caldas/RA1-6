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

            if c == '(' or c == ')':
                return estadoParenteses, i

            if c in "+-*%^":
                return estadoOperador, i

            if c == '/':
                return estadoBarra, i

            if c.isdigit():
                return estadoNumero, i

            if c.isupper():
                return estadoIdentificador, i

            if c == '.':
                raise ValueError("Número malformado: número não pode começar com ponto")

            if c.isalpha():
                raise ValueError(f"Identificador inválido: '{c}'. Use apenas letras maiúsculas")

            raise ValueError(f"Caractere léxico inválido: {c}")

        def estadoParenteses(i: int):
            """
            Estado responsável por reconhecer parênteses
            e controlar o balanceamento.
            """
            nonlocal parenteses_abertos

            c = linha[i]

            if c == '(':
                parenteses_abertos += 1
                tokens.append(("AP", "("))

            elif c == ')':
                parenteses_abertos -= 1

                if parenteses_abertos < 0:
                    raise ValueError("Parênteses desbalanceados: ')' sem '(' correspondente")

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
            if i + 1 < n and linha[i + 1] == '/':
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

            while i < n and (linha[i].isdigit() or linha[i] == '.'):
                if linha[i] == '.':
                    if tem_ponto:
                        raise ValueError(f"Número malformado: múltiplos pontos em '{lexema + linha[i]}'")
                    tem_ponto = True

                lexema += linha[i]
                i += 1

            if lexema.endswith('.'):
                raise ValueError(f"Número malformado: {lexema}")

            if i < n and linha[i] == ',':
                raise ValueError(f"Número malformado: use ponto em vez de vírgula em '{lexema},'")

            if i < n and linha[i].isalpha():
                raise ValueError(f"Token inválido: número não pode ser seguido de letras em '{lexema + linha[i]}'")

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
                raise ValueError(f"Identificador inválido: '{lexema + linha[i]}'. Use apenas letras maiúsculas")

            if i < n and linha[i].isdigit():
                raise ValueError(f"Identificador inválido: '{lexema + linha[i]}'. Letras e números não podem ficar juntos")

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