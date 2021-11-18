%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica 
% Problemas utilizando Pesquisa Informada
% Problema de Pesquisa -> Problema de Estado Único

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Notas:
% Partindo de qualquer nó, queremos chegar ao nó t

% Base de Conhecimento
% -> Definição das arestas: aresta(nó1, nó2, custo)

aresta(s, e, 2).
aresta(s, a, 5).
aresta(a, b, 2).
aresta(b, c, 2).
aresta(c, d, 3).
aresta(d, t, 3).
aresta(t, g, 2).
aresta(g, f, 2).
aresta(f, e, 5).

% -> Definição dos nodos: node(nó, estimativaDoCusto)

node(s,10).
node(a, 5).
node(b, 4).
node(c, 4).
node(d, 3).
node(t, 0).
node(g, 2).
node(f, 4).
node(e, 7).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Devolve nó adjacente e custo a essa adjacência, por unificação 
adjacente(X, Y, C):- aresta(X, Y, C).
adjacente(X, Y, C):- aresta(Y, X, C).

 
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Depth First Search with Cost
depthFirstCost(Inicio, Path, Cost):- depthFirstCostAux(Inicio, [], 0, Path, Cost).

depthFirstCostAux(t, Visited, Cost, Path, Cost):- reverse([t|Visited], Path). 
depthFirstCostAux(Node, Visited, Cost, Path, Total):- adjacente(Node, X, Value),
	not(member(X, Visited)), 
	NewCost is Cost + Value,
	depthFirstCostAux(X, [Node|Visited], NewCost, Path, Total).
	
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Greedy Search (Gulosa)

% Retorna a lista dos nodes adjacentes ao node X
listaDeAdjacentes(X, Lista):- findall(Y, adjacente(X, Y, _), Lista).

% Retorna o node com menor custo aproximado ao destino
menorCustoGreedy([H|ListaAdj], X):- node(H, CustoAprox), menorCustoAux(ListaAdj, CustoAprox, H, X). 

menorCustoAux([], CustoAprox, X, X).
menorCustoAux([H|T], CustoAprox, NodeCloser, X):- node(H, Y), Y>= CustoAprox, menorCustoAux(T, CustoAprox, NodeCloser, X).
menorCustoAux([H|T], CustoAprox, NodeCloser, X):- node(H, Y), Y< CustoAprox, menorCustoAux(T, Y, H, X).

% Algoritmo Greedy Search (Gulosa)
greedySearch(Inicio, Path, Cost):- greedySearchAux(Inicio, [], 0, Path, Cost).

greedySearchAux(t, Visited, Cost, Path, Cost):- reverse([t|Visited], Path).
greedySearchAux(Node, Visited, Cost, Path, Total):- listaDeAdjacentes(Node, ListAdj),
	menorCustoGreedy(ListAdj, NextNode),
	not(member(NextNode, Visited)),
	adjacente(Node, NextNode, Value),
	NewCost is Cost + Value,
	greedySearchAux(NextNode, [Node|Visited], NewCost, Path, Total).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
