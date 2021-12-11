%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% INTELIGÊNCIA ARTIFICIAL - MiEI/LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida
% Representacao de conhecimento imperfeito

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

:- op( 900,xfy,'::' ).
:- dynamic servico/2.
:- dynamic ato/4.

%-------------------------------------------------
% Aplicação do PMF

-servico(Servico, Nome) :- 
    nao(servico(Servico, Nome)), 
    nao(excecao(servico(Servico, Nome))).
	
-ato(Ato, Prestador, Utente, Dia) :- 
    nao(ato(Ato, Prestador, Utente, Dia)), 
    nao(excecao(ato(Ato, Prestador, Utente, Dia))).

%--------------------------------- - - - - - - - - - -  -
% Alínea c)

% Linha 1 da tabela

servico(ortopedia, amelia).

ato(penso, ana, joana, sabado).

%--------------------------------- - - - - - - - - - -  -
% Linha 2 da tabela

servico(obstetricia, ana).

ato(gesso, amelia, jose, domingo).

%--------------------------------- - - - - - - - - - -  -
% Linha 3 da tabela

servico(obstetricia, maria).

ato('#017', mariana, joaquina, domingo).
excecao(ato(Ato, Enf, Utente, Data)):- ato('#017', Enf, Utente, Data).

%--------------------------------- - - - - - - - - - -  -
% Linha 4 da tabela

servico(obstetricia, mariana).

ato(domicilio, maria, '#121', '#251').
excecao(ato(Ato, Enf, Utente, Data)):- ato(Ato, Enf, '#121', '#251').

%--------------------------------- - - - - - - - - - -  -
% Linha 5 da tabela

servico(geriatria, sofia).

excecao(ato(domicilio, susana, joao, segunda)).
excecao(ato(domicilio, susana, jose, segunda)).

%--------------------------------- - - - - - - - - - -  -
% Linha 6 da tabela 

servico(geriatria, susana).

ato(sutura, '#313', josue, segunda).
excecao(ato(Ato, Enf, Utente, Data)):- ato(Ato, '#313', Utente, Data).

%--------------------------------- - - - - - - - - - -  -
% Linha 7 da tabela

servico('#007', teodora).
excecao(servico(Servico, Nome)):- servico('#007', Nome).

excecao(sutura, maria, josefa, terca).
excecao(sutura, maria, josefa, sexta).
excecao(sutura, mariana, josefa, terca).
excecao(sutura, mariana, josefa, sexta).

%--------------------------------- - - - - - - - - - -  -
% Linha 8 da tabela 

servico('@NP9', zulmira).
excecao(servico(S, N)):- ato('@NP9', N).
nulo('@NP9').
+servico(S, N)::(findall(S, servico(S, N), L), not(nulo(S)), length(L, N), N== 0).

excecao(ato(penso, ana, jacinta, Data)):- member(Data, [segunda, terca, quarta, quinta, sexta, sabado, domingo]).

%--------------------------------- - - - - - - - - - -  -
% Alinea c)

% Assumo que existe um predicado que dado um dia verifica se é feriado

% +ato(Ato, Prestador, Utente, Dia)::(not(feriado(Dia))). 

%--------------------------------- - - - - - - - - - -  -
% Alinea d)

-servico(S, Prestador)::(findall(Ato, ato(Ato, Prestador, _, _), L), length(L, N), N== 0).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

evolucao( Termo ) :-
    findall( Invariante,+Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ).

insercao( Termo ) :-
    assert( Termo ).
insercao( Termo ) :-
    retract( Termo ),!,fail.

teste( [] ).
teste( [R|LR] ) :-
    R,
    teste( LR ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a involucao do conhecimento

involucao( Termo ) :-
    findall( Invariante,-Termo::Invariante,Lista ),
    remocao( Termo ),
    teste( Lista ).

remocao( Termo ) :-
    retract( Termo ).
remocao( Termo ) :-
    assert( Termo ),!,fail.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Questao,Resposta -> {V,F}
%                            Resposta = { verdadeiro,falso,desconhecido }

demo( Questao,verdadeiro ) :-
    Questao.
demo( Questao,falso ) :-
    -Questao.
demo( Questao,desconhecido ) :-
    nao( Questao ),
    nao( -Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -


					

				 


