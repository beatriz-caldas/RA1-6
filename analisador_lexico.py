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

        estadoAtual = estadoInicial
        indice = 0

        while estadoAtual is not None:
            estadoAtual, indice = estadoAtual(indice)

        if parenteses_abertos != 0:
            raise ValueError("Parênteses desbalanceados na expressão")