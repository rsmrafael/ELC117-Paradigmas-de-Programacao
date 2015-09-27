/* 
 Paradigmas de Programação
 Trabalho em Prolog - t7
 Rafael Sebastião Miranda
*/

% Questão 1 

pred([],[]).
pred([H|T],[H1|T1]) :- H1 is H + 1, pred(T,T1).

/* 
 pred(A,B) diz se a lista B possui todos elementos da lista A, acrescidos de 1, na mesma posição
 ?- pred([1,2,3],[a,b,c]). retorna falso, pois a não é (1+1)
 ?- pred([8,9],L). retorna a lista para o qual a consulta é verdadeira [9,10]
 ?- pred([1,2,3],[2,L]). retorna falso, pois L não pode ser nem uma lista, nem um único valor
 ?- pred([1,2],[2,X]). retorna X = 3, pois esse é o único valor que satisfaz a consulta
*/

% Questão 2

ziplus([],[],[]).
ziplus([H1|T1],[H2|T2],[H3|T3]) :- H3 is H1 + H2, ziplus(T1,T2,T3).

% Questão 3

countdown(0,[0]).
countdown(N,[H|T]) :- H is N, N1 is N - 1 , countdown(N1,T).

% Questão 4

potAux(N,N,[]).
potAux(N,X,[H|T]) :- X1 is X + 1, H is X^2, potAux(N,X1,T).
potencias(N,L) :- potAux(N,0,L).

% Questão 5

positivos([],[]).
positivos([H1|T1],[]) :- H1 =< 0 , positivos(T1,[]).
positivos([H1|T1],[H2|T2]) :- ( H1>0 , H2 is H1 , positivos(T1,T2) );
							  ( H1=<0 , positivos(T1,[H2|T2]) ).
							  
% Questão 6

mesmaPosicao(A,[A|_],[A|_]).
mesmaPosicao(A,[_|T1],[_|T2]) :- mesmaPosicao(A,T1,T2).

% Questão 7

intercala(_,[],[]).
intercala(_,[X],[X]).
intercala(A,[X1|L1],[X1,A|L2]) :- intercala(A,L1,L2).

% Questão 8

comissao(0,_,[]).
comissao(NP,[H|T1],[H|T2]) :- NP1 is NP - 1, comissao(NP1,T1,T2).
comissao(NP,[_|T1],[H2|T2]):- comissao(NP,T1,[H2|T2]).

% Questão 9

azulejos(0,0).
azulejos(NA,NQ) :- not(NA = 0), NA1 is NA - floor(sqrt(NA))^2 , azulejos(NA1,NQ1), NQ is 1 + NQ1.
