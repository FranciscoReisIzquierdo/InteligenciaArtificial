%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica 
% Problema dos jarros -> Problema de Estado Único

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Notas:
% Jarro A -> capacidade= 8
% Jarro B -> capacidade= 5
% Par(A, B) -> jarros(A, B)
% Estado Inicial -> jarros(0, 0)
% Estado Objetivo -> jarros(_, 4) ou jarros(4, _)
% Estado Inicial <-> Estado Objetivo -> Operadores


%---------------------------------
% Estado Inicial:

estadoInicial(jarros(0,0)).

%---------------------------------
% Estado Final:

estadoFinal(jarros(_, 4)).
estadoFinal(jarros(4, _)).

%---------------------------------
% Depth First Search 
% Nota: Não verifico a profundidade!, Caso se pretenda controlar a profundidade, bastava colocar mais uma variável N, que tivesse a profundidade máxima "premitida"
depthFirst(Ei, Ef, Path):- depthFirstAuxiliar(Ei, Ef, [], Path).

depthFirstAuxiliar(Ei, Ei, Visited, Path):- reverse([Ei|Visited], Path).


depthFirstAuxiliar(Ei, Ef, Visited, Path):-
	not(member(Ei, Visited)),
	transicao(Ei, T, E),
	depthFirstAuxiliar(E, Ef, [Ei|Visited], Path).
	
	
%---------------------------------
% Operadores
% Transições possíveis transicao: Ei x Op x EF
	
% Encher jarro A
transicao(jarros(A, B), encher(1), jarros(8, B)):- A< 8.

% Encher jarro B
transicao(jarros(A, B), encher(2), jarros(A, 5)):- B< 8.

% Esvaziar jarro A
transicao(jarros(A, B), esvaziar(1), jarros(0, B)):- A> 0.

% Esvaziar jarro B
transicao(jarros(A, B), esvaziar(2), jarros(A, 0)):- B> 0.

% Transferir do jarro A para o B
transicao(jarros(A, B), transferir(1,2), jarros(Af, Bf)):- 
	A > 0,
    	Af is max(A - 5 + B, 0),
    	Af < A,
    	Bf is B + A - Af.
	
% Transferir do jarro B para o A
transicao(jarros(A, B), transferir(2,1), jarros(Af, Bf)):- 
	B > 0,
    	Bf is max(B - 5 + A, 0),
    	Bf < B,
    	Af is A + B - Bf.
	
%---------------------------------
% Breadth First Search
breadthFirst(Ei, Ef, Path):- breadthFirstAuxiliar(Ei, Ef, [], Path).

breadthFirstAuxiliar(Ei, Ei, Visited, Visited).


breadthFirstAuxiliar(Ei, Ef, Visited, Path):-
	not(member(Ei, Visited)),
	transicao(Ei, T, E),
	append(Visited, [Ei], Newvisited),
	breadthFirstAuxiliar(E, Ef, Newvisited, Path).	

%---------------------------------
