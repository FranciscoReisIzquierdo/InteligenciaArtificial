%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ITELIGÊNCIA ARTIFICIAL - MiEI/LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: definicoes iniciais

:- style_check(-singleton).
:- dynamic '-'/1.
:- dynamic mamifero/1.
:- dynamic morcego/1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% i) 
% Nota: Voa quem for ave e não existir uma exceção que diga que é ave que não voa (avestruz)

voa(X):- ave(X), not(excecao(voa(X))).

% Nota: Voa quem não for ave e existir uma exceção que diga que não é ave mas voa (morcego)

voa(X):- excecao(-voa(X)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ii)

% Nota: Não voa quem for mamífero e não exisitir uma exceção que diga que é mamífero e voa (morcego)

-voa(X):- mamifero(X), not(excecao(-voa(X))).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% iii)

-voa(tweety).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% iv)

ave(pitigui).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% v)

ave(X):- canario(X).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% vi)

ave(X):- periquito(X).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% vii)

periquito(faisca).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% viii)

canario(piupiu).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ix)

mamifero(silvestre).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% x)

mamifero(X):- cao(X).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xi)

mamifero(X):- gato(X).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xii)

gato(bichano).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xiii)

cao(boby).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xiv)

ave(X):- avestruz(X).

excecao(voa(X)):- avestruz(X).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xv)

ave(X):- pinguim(X).

excecao(voa(X)):- pinguim(X).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xvi)

avestruz(trux).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xvii)

pinguim(pingu).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xviii) 

mamifero(X):- morcego(X).

excecao(-voa(X)):- morcego(X).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% xix)

morcego(batman).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

si(Questao, verdadeiro):- Questao.
si(Questao, false):- -Questao.
si(Questao, desconhecido):- nao(Questao), nao(-Questao).


nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).
