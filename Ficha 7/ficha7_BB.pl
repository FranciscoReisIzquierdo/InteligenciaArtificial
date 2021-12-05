%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica 
% Problemas utilizando Pesquisa Informada
% Problema de Pesquisa -> Problema de Estado Único

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Notas:
% Partindo de qualquer nó, queremos chegar ao nó lisboa

% Base de Conhecimento:

% Definição das arestas: aresta(nó1, nó2, tuplo(custoDistancia, custoTempo))

aresta(alandroal, redondo, tuplo(25, 10)).
aresta(redondo, monsaraz, tuplo(30, 20)). 
aresta(monsaraz, barreiro, tuplo(120, 60)).
aresta(barreiro, baixa_da_banheira, tuplo(5, 5)).
aresta(baixa_da_banheira, moita, tuplo(7, 6)).
aresta(moita, alcochete, tuplo(20, 20)).
aresta(alcochete, lisboa, tuplo(20, 15)).
aresta(lisboa, almada, tuplo(15, 20)).
aresta(almada, palmela, tuplo(25, 20)).
aresta(palmela, barreiro, tuplo(25, 20)).
aresta(palmela, alcacer, tuplo(30, 30)).
aresta(alcacer, arrailos, tuplo(90, 60)).
aresta(arrailos, elvas, tuplo(50, 30)).
aresta(elvas, alandroal, tuplo(40, 25)).
aresta(elvas, borba, tuplo(15, 10)).
aresta(borba, estremoz, tuplo(15, 10)).
aresta(estremoz, evora, tuplo(40, 25)).
aresta(evora, montemor, tuplo(20, 15)).
aresta(montemor, vendas_novas, tuplo(15, 10)).
aresta(vendas_novas, lisboa, tuplo(50, 30)).

% -> Definição dos nodos: node(nó, estimativaDistância, estimativaTempo)

node(alandroal, 180, 90).
node(redondo, 170, 80).
node(monsaraz, 120, 70).
node(barreiro, 30, 20).
node(baixa_da_banheira, 33, 25).
node(moita, 35, 20).
node(alcochete, 26, 15).
node(lisboa, 0, 0).
node(almada, 25, 20).
node(palmela, 40, 25).
node(alcacer, 65, 45).
node(arrailos, 190, 80).
node(elvas, 270, 150).
node(borba, 250, 90).
node(estremoz, 145, 85).
node(evora, 95, 68).
node(montemor, 70, 40).
node(vendas_novas, 45, 30).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Predicados auxiliares:

% Verifica se dois nos são adjacentes, devolvendo o tuplo associado a ambos, por unificação

adjacente(A, B, Tuplo):- aresta(A, B, Tuplo).
adjacente(A, B, Tuplo):- aresta(B, A, Tuplo).

% Devolve o custo da distância associado a uma aresta

getDistancia(tuplo(Dist, Temp), Dist).

custoDistancia(A, B, Distancia):- adjacente(A, B, Tuplo), getDistancia(Tuplo, Distancia).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Devolve o custo do tempo associado a uma aresta

getTempo(tuplo(Dist, Temp), Temp).

custoTempo(A, B, Tempo):- adjacente(A, B, Tuplo), getTempo(Tuplo, Tempo).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Devolve a lista de nos adjacentes

listaAdjacencia(Node, ListaAdj):- findall(N, adjacente(Node, N, _), ListaAdj).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Devolve a soma do custo da aresta (Tempo + Distância)

somaCustos(A, Total):- node(A, Dist, Temp), Total is Dist+ Temp.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Devolve o nodo com menor custo (menor soma de Tempo e Distância)

menorCusto([H|Tail], Node):- somaCustos(H, Acum), menorCustoAux(Tail, H, Acum, Node).

menorCustoAux([], Node, Acum, Node).
menorCustoAux([H|Tail], Menor, Acum, Node):- somaCustos(H, Valor), Valor< Acum, menorCustoAux(Tail, H, Valor, Node).
menorCustoAux([H|Tail], Menor, Acum, Node):- somaCustos(H, Valor), Valor >= Acum, menorCustoAux(Tail, Menor, Acum, Node).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Remove elementos repetidos de uma lista (nomeadamente de uma lista de adjacência, pois não queremos passar por nodos repetidos)

removeRepetidos([], L, Result, Result).
removeRepetidos([H|T], L, Aux, Result):- not(member(H, L)), removeRepetidos(T, L, [H|Aux], Result).
removeRepetidos([H|T], L, Aux, Result):- member(H, L), removeRepetidos(T, L, Aux, Result).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Greedy Search (Gulosa)

greedySearch(NodeI, Path, CustoDist, CustoTemp):- greedySearchAux(NodeI, [], 0, 0, Path, CustoDist, CustoTemp).

greedySearchAux(lisboa, Visited, CustoDist, CustoTemp, Path, CustoDist, CustoTemp):- reverse([lisboa| Visited], Path). 
greedySearchAux(NodeI, Visited, Dist, Temp, Path, CustoDist, CustoTemp):- listaAdjacencia(NodeI, Lista), removeRepetidos(Lista, Visited, [], Final), menorCusto(Final, NextNode), custoTempo(NodeI, NextNode, T), custoDistancia(NodeI, NextNode, D), NewTemp is Temp+ T, NewDist is Dist+ D, greedySearchAux(NextNode, [NodeI|Visited], NewDist, NewTemp, Path, CustoDist, CustoTemp), !.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
