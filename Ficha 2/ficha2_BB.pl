%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Inteligência Artificial - MiEI/3 LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Operacoes aritmeticas.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado soma: X,Y,Soma -> {V,F}

soma(X, Y, Soma):-
    Soma is X+Y.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado soma: X,Y,Z,Soma -> {V,F}

soma(X, Y, Z, Soma):- Soma is X+Y+Z.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado operação aritmética: X,Y,Op -> {V,F}

operacao(X, Y, +, Op):- Op is X+Y.
operacao(X, Y, -, Op):- Op is X-Y.
operacao(X, Y, *, Op):- Op is X*Y.
operacao(X, Y, /, Op):- Op is X/Y.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado maior entre dois valores: X,Y,Maior -> {V,F}

maior(X, Y, Maior):- Maior is max(X, Y).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado maior entre tres valores: X,Y,Z,Maior -> {V,F}

maior(X, Y, Z, Maior):- Maior is max(X, max(Y, Z)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado menor entre dois valores: X,Y,Menor -> {V,F}

menor(X, Y, Menor):- Menor is min(X, Y).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado menor entre tres valores: X,Y,Z,Menor -> {V,F}

menor(X, Y, Z, Menor):- Menor is min(X, min(Y, Z)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado para números pares X -> {V,F}

par(X):- mod(X, 2) =:= 0.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado para números ímpares X -> {V,F}

impar(X):- mod(X, 2) =:= 1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado para máximo divisor comum para 2 números X, Y, MDC -> {V,F}

mdc(X, X, X).
mdc(X, Y, MDC):- X < Y, NEW is Y-X, mdc(X, NEW, MDC).
mdc(X, Y, MDC):- X > Y, mdc(Y, X, MDC).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado para mínimo múltiplo comum X, Y, MMC -> {V,F}

mmc(X, Y, MMC):- mdc(X,Y,MDC), MMC is X * Y / MDC.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

















