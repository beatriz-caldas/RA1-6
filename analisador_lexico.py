# Beatriz Caldas | beatriz-caldas
# Eduardo Pianovski | DuduPNetto
# Lucas Gasperin | Lucas-PG
# Lucas Sotomaior | LucasSotomaiorAPereira
# GRUPO | RA1-6

import sys


class AnalisadorLexico:

    def parseExpressao(self, linha: str, tokens: list) -> None:
        n = len(linha)
        parenteses_abertos = 0

        def estadoInicial(i: int):
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

            if c.isdigit() or c == '.':
                return estadoNumero, i

            return None, i

        def estadoParenteses(i: int):
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
            c = linha[i]
            tokens.append(("OP", c))
            return estadoInicial, i + 1

        def estadoBarra(i: int):
            if i + 1 < n and linha[i + 1] == '/':
                tokens.append(("OP", "//"))
                return estadoInicial, i + 2

            tokens.append(("OP", "/"))
            return estadoInicial, i + 1

        def estadoNumero(i: int):
            lexema = ""

            while i < n and (linha[i].isdigit() or linha[i] == '.'):
                lexema += linha[i]
                i += 1

            tokens.append(("NUM", lexema))
            return estadoInicial, i

        estadoAtual = estadoInicial
        indice = 0

        while estadoAtual is not None:
            estadoAtual, indice = estadoAtual(indice)

        if parenteses_abertos != 0:
            raise ValueError("Parênteses desbalanceados na expressão")