
:- op(500, xfy, '::').
% :- dynamic '-'/1.
:- dynamic '+'/1.
:- dynamic jogo/3.
:- discontiguous jogo/3.

-jogo(IdJogo, Arbitro, AC):-
	not(jogo(IdJogo, Arbitro, AC)),
	not(excecao(jogo(IdJogo, Arbitro, AC))).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Pergunta 1:
% Conhecimento Perfeito

jogo(1, almeida_antunes, 500).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Pergunta 2:

% Conhecimento Imperfeito -> Conhecimento Incerto

jogo(2, baltazar_borges, valor_incerto).
excecao(jogo(IdJogo, Arbitro, AC)):- jogo(IdJogo, Arbitro, valor_incerto).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Pergunta 3:

% Conhecimento Imperfeito -> Conhecimento Impreciso

excecao(jogo(3, costa_carvalho, 500)).
excecao(jogo(3, costa_carvalho, 2500)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Pergunta 4:

% Conhecimento Imperfeito -> Conhecimento Impreciso

excecao(jogo(4, duarte_durao, Ac)):- Ac >= 250, Ac =< 750;

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Pergunta 5:

% Conhecimento Imperfeito -> Conhecimento Interdito

jogo(5, edgar_esteves, valor).
excecao(jogo(IdJogo, Arbitro, Ac)):- jogo(IdJogo, Arbitro, valor).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Pergunta 6:

% Conhecimento Imperfeito -> Conhecimento Impreciso

jogo(6, francisco_franca, 250).
excecao(jogo(6, francisco_franca, Ac)):- Ac =< 5000.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Pergunta 7:

% Conhecimento Imperfeito -> Conhecimento Interdito

-jogo(7, guerra_godinho, 2500).

jogo(7, guerra_godinho, valor).
excecao(jogo(IdJogo, Arbitro, Ac)):- jogo(IdJogo, Arbitro, valor).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Pergunta 8:

% Conhecimento Imperfeito -> Conhecimento Impreciso

excecao(jogo(8, helder_heitor, Ac)):- Ac >= 1000* 0.5, Ac =< 1000+ 1000*0.5.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Pergunta 9:

% Conhecimento Imperfeito -> Conhecimento Impreciso

excecao(jogo(9, ivo_inocencio, Ac)):- Ac >= 1000 - 1000*0.1, Ac =< 1000 + 1000* 0.1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Predicados Importantes para Conhecimento Interdito

nulo(valor).

+jogo(IdJogo, Arbitro, Ac)::(findall(Ac, (jogo(IdJogo, Arbitro, Ac), not(nulo(Ac))), L), length(L, N), N== 0).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Pergunta 10:

+jogo(IdJogo, Arbitro, Ac)::(findall(Arbitro, jogo(IdJogo, Arbitro, _), L), length(L, N), N== 0).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Pergunta 11:

+jogo(IdJogo, Arbitro, Ac)::(findall(Id, jogo(Id, Arbitro, _), L), length(L, N), N< 3).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Pergunta 12:

+jogo(IdJogo, Arbitro, Ac)::(findall(Id, jogo(Id, Arbitro, _), L), checkJogo(IdJogo, L)).

checkJogo(IdJogo, []).
checkJogo(IdJogo, [H|T]):- IdJogo=\= H+1, IdJogo=\= H-1, checkJogo(IdJogo, T).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Definição de invariantes

% Invariante que permite acrescentar conhecimento (de forma controlada)
evolucao(Termo):- findall(Invariante, +Termo::Invariante, Lista), teste(Lista), insercao(Termo).

insercao(Termo):- assert(Termo).

teste([]).
teste([R|RL]):- R, teste(RL).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

si(Questao, verdadeiro):- Questao.
si(Questao, false):- -Questao.
si(Questao, desconhecido):- nao(Questao), nao(-Questao).


nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
