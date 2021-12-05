%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ITELIGÊNCIA ARTIFICIAL - MiEI/LEI/3

:- set_prolog_flag(discontiguous_warnings, off).
:- set_prolog_flag(single_var_warnings, off).
:- set_prolog_flag(unkown, fail).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic filho/2.
:- dynamic pai/2.
:- dynamic idade/2.
:- dynamic avo/2.
:- dynamic neto/2.
:- dynamic descendente/3.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento com informacao genealogica.

filho(joao, jose).
filho(jose, manuel).
filho(carlos, jose).
:-discontiguous filho/2.

pai(paulo, filipe).
pai(paulo, maria).
:-discontiguous pai/2.

avo(antonio, nadia).
:-discontiguous avo/2.

neto(nuno, ana).
:-discontiguous neto/2.

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
% Extensao do predicado descendente: Descendente,Ascendente,Grau -> {V,F}

descendente(D, A, 1):- filho(D, A).
descendente(D, A, G):- filho(D, X), descendente(X, A, N), G is N+1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% i) Não pode existir mais do que uma ocorrência da mesma evidência na relação filho/2

+filho(Filho, Pai)::(findall((Filho, Pai), filho(Filho, Pai), Lista), length(Lista, N), N== 0).
-filho(Filho, Pai)::(findall((Filho, Pai), filho(Filho, Pai), Lista), length(Lista, N), N== 1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ii) Não pode existir mais do que uma ocorrência da mesma evidência na relação pai/2

+pai(Pai, Filho)::(findall((Pai, Filho), pai(Pai, Filho), Lista), length(Lista, N), N== 0).
-pai(Pai, Filho)::(findall((Pai, Filho), pai(Pai, Filho), Lista), length(Lista, N), N== 1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% iii) Não pode existir mais do que uma ocorrência da mesma evidência na relação neto/2;

+neto(Neto, Avo)::(findall((Neto, Avo), neto(Neto, Avo), Lista), length(Lista, N), N== 0).
-neto(Neto, Avo)::(findall((Neto, Avo), neto(Neto, Avo), Lista), length(Lista, N), N== 1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% iv) Não pode existir mais do que uma ocorrência da mesma evidência na relação avô/2

+avo(Avo, Neto)::(findall((Avo, Neto), avo(Avo, Neto), Lista), length(Lista, N), N== 0).
-avo(Avo, Neto)::(findall((Avo, Neto), avo(Avo, Neto), Lista), length(Lista, N), N== 1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% v) Não pode existir mais do que uma ocorrência da mesma evidência na relação descendente/3

+descendente(D, A, G)::(findall((D, A, G), descendente(D, A, G), Lista), length(Lista, N), N== 0).
-descendente(D, A, G)::(findall((D, A, G), descendente(D, A, G), Lista), length(Lista, N), N== 1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% vi) Não podem existir mais do que 2 progenitores para um dado indivíduo, na relação filho/2

+filho(Filho, Pai)::(findall(P, filho(Filho, P), Lista), length(Lista, N), N< 2).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% vii) Não podem existir mais do que 2 progenitores para um dado indivíduo, na relação pai/2

+pai(Pai, Filho)::(findall(P, pai(P, Filho), Lista), length(Lista, N), N< 2). 

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% viii) Não podem existir mais do que 4 indivíduos identificados como avô na relação neto/2

+neto(Neto, Avo)::(findall(A, neto(Neto, A), Lista), length(Lista, N), N< 4).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ix) Não podem existir mais do que 4 indivíduos identificados como avô na relação avô/2

+avo(Avo, Neto)::(findall(A, avo(A, Neto), Lista), length(Lista, N), N< 4).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Definição de invariantes

% Invariante que permite acrescentar conhecimento (de forma controlada)
evolucao(Termo):- findall(Invariante, +Termo::Invariante, Lista), teste(Lista), insercao(Termo).

insercao(Termo):- assert(Termo).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariante que permite remover conhecimento (de forma controlada)

involucao(Termo):- findall(Invariante, -Termo::Invariante, Lista), teste(Lista), remocao(Termo).

remocao(Termo):- retract(Termo).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

teste([]).
teste([R|RL]):- R, teste(RL).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
