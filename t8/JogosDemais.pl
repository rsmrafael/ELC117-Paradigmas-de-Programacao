/* 
 Paradigmas de Programação
 Trabalho em Prolog - t8 - part 2
 Rafael Sebastião Miranda
 http://olimpiada.ic.unicamp.br/pdf/provas/ProvaOBI2013_inic_f2n2.pdf
 Questões 7 - 12
*/

% Base

/* jogos retorna lista com possível combinação de jogos e custos */
% Um dos jogos custa R$ 1, 00 por dia jogado, outro custa R$ 1, 20 por dia jogado, e o outro custa R$ 1, 50 por dia jogado
custo(J,C) :- member(J,[x,y,z]) , member(C,[1,1.2,1.5]).
jogos(JS) :- custo(x,JX),custo(y,JY),custo(z,JZ),
			not(JX=JY ; JX=JZ ; JY=JZ),
			JS = [(x,JX),(y,JY),(z,JZ)].

/* count retorna o número de aparições de um elemento em um lista */
count(_,[],0).
count(A,[A|T],C) :- count(A,T,C1) , C is C1+1.
count(A,[H|T],C) :- not(A = H) , count(A,T,C).
			
/* W é possível semana de jogos */
week(W) :-  jogos(JS) , JS = [(x,JX),(y,JY),(z,JZ)],
			member(J2,JS) , member(J3,JS) , member(J4,JS),
			member(J5,JS) , member(J6,JS),
			W = [J2,J3,J4,J5,J6],
			member((x,JX),W),member((y,JY),W),member((z,JZ),W),
			J5 = (_,1.5), % Às quintas-feiras, João joga o jogo que custa R$ 1, 50.
			JX > JZ, % O jogo X custa mais do que o jogo Z.
			J4=(_,P4),J6=(_,P6),P4 > P6, % O jogo que João joga às quartas-feiras é mais caro do que o jogo que ele joga às sextas-feiras.
			count((z,JZ),W,CZ),count((x,JX),W,CX),CZ>CX. % João joga o jogo Z mais vezes por semana do que ele joga o jogo X.
			
% Questão 7
			
check7(C) :- week([(_,C2),(_,C3),(_,C4),(_,C5),(_,C6)]),
			C is (C2+C3+C4+C5+C6).
	% ?- check7(4).
	% false.
	% ?- check7(5).
	% false.
	% ?- check7(6.2).
	% true . (Resposta certa (c))
	% ?- check7(7.5).
	% false.
	% ?- check7(8).
	% false.
	
% Questão 8
			
check8(J2,J3,J4,J5,J6) :- week([(J2,_),(J3,_),(J4,_),(J5,_),(J6,_)]).

	% ?- check8(y,z,x,y,z).
	% true . (Resposta certa (a))
	% ?- check8(y,z,z,y,x).
	% false.
	% ?- check8(z,z,x,x,y).
	% false.
	% ?- check8(z,z,x,x,z).
	% false.
	% ?- check8(z,z,x,z,y).
	% false.

% Questão 9

check9(D) :- D=2 , week([(_,1.5),_,_,_,_]);
			D=3 , week([_,(_,1.5),_,_,_]);
			D=4 , week([_,_,(_,1.5),_,_]);
			D=5 , week([_,_,_,(_,1.5),_]);
			D=6 , week([_,_,_,_,(_,1.5)]).
			
	% ?- check9(2).
	% true .
	% ?- check9(3).
	% true .
	% ?- check9(4).
	% true .
	% ?- check9(5).
	% true .
	% ?- check9(6).
	% false. (Resposta certa (e))
