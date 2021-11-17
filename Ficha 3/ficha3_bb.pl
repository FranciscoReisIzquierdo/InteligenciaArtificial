%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% inteligência Artificial - MiEI/3 LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Operacoes sobre listas.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pertence: Elemento,Lista -> {V,F}
pertence(X, [X|T]).
pertence(X, [Y|T]):- pertence(X, T).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado comprimento: Lista,Comprimento -> {V,F}
comprimento([], 0).
comprimento([X|T], N):- comprimento(T, N1), N is N1+1. 

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado quantos: Lista,Comprimento -> {V,F}
diferentes([], 0).
diferentes([H|T], Dif):- pertence(H, T), diferentes(T, Dif).
diferentes([H|T], Dif):- not(pertence(H, T)), diferentes(T, N1), Dif is N1+1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apagar: Elemento,Lista,Resultado -> {V,F}
apaga1(X,[], []).
apaga1(X, [X|T], T).
apaga1(X, [H|T], [H|L]):- X \= H, apaga1(X, T, L).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apagatudo: Elemento,Lista,Resultado -> {V,F}
apagatudo(X, [], []).
apagatudo(X, [X|T], L):- apagatudo(X, T, L).
apagatudo(X, [H|T], [H|L]):- X \= H, apagatudo(X, T, L).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado adicionar: Elemento,Lista,Resultado -> {V,F}
adicionar(X, L, [X|L]):- not(pertence(X, L)).
adicionar(X, L, L):- pertence(X, L).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado concatenar: Lista1,Lista2,Resultado -> {V,F}
concatenar(L1, [], L1).
concatenar([], L2, L2).
concatenar([H|T], L2, [H|L1]):- concatenar(T, L2, L1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado inverter: Lista,Resultado -> {V,F}
inverter([], []).
inverter([H|T], L3):- inverter(T, L2), concatenar(L2, [H], L3).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado sublista: SubLista,Lista -> {V,F}

prefixo([], L2).
prefixo([H1|L1], [H1|L2]):- sublista(L1, L2).

sublista(L1, L2):- prefixo(L1, L2).
sublista(L1, [_|L2]):- sublista(L1, L2).
 





