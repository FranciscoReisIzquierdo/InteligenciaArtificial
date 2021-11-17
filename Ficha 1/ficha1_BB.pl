%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Inteligência Artificial MIEI /3  LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento com informacao genealogica.

filho(joao, jose).
filho(jose, manuel).
filho(carlos, jose).
:-discontiguous filho/2.

pai(paulo, filipe).
pai(paulo, maria).
:-discontiguous pai/2.

avo(antonio, nádia).
:-discontiguous avo/2.

neto(nuno, ana).
:-discontiguous neto/2.

masculino(joão).
masculino(josé).

feminino(maria).
feminino(joana).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado filho: Filho,Pai -> {V,F}

filho(F, P).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pai: Pai,Filho -> {V,F}

pai(P, F) :- filho(F, P).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado avo: Avo,Neto -> {V,F}

avo(A, N) :- filho(X, A), filho(N, X).

avoDesc(A, N):- descendente(A, N, 2).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado neto: Avó,Neto -> {V,F}

neto(N, A):- avo(A, N).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado bisavo: Bisavo,Bisneto -> {V,F}

bisavo( A, B):- descendente(A, B, 3).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente -> {V,F}


descendente(D, A):- filho(D, A).
descendente(D, A):- filho(D, X), descendente( X, A).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente,Grau -> {V,F}

descendente(D, A, 1):- filho(D, A).
descendente(D, A, G):- filho(D, X), descendente(X, A, N), G is N+1.



