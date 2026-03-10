# Beatriz Caldas | beatriz-caldas
# Eduardo Pianovski | DuduPNetto
# Lucas Gasperin | Lucas-PG
# Lucas Sotomaior | LucasSotomaiorAPereira

import sys


class AnalisadorLexico:

    def parseExpressao(self, linha: str, tokens: list) -> None:
        n = len(linha)
        parenteses_abertos = 0

        def estadoInicial(i: int):
            if i >= n:
                return None, i
            return None, i

        estadoAtual = estadoInicial
        indice = 0

        while estadoAtual is not None:
            estadoAtual, indice = estadoAtual(indice)