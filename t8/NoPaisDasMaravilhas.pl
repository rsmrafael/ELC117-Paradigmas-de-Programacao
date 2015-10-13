/* 
 Paradigmas de Programação
 Trabalho em Prolog - t8 - part 1
 Rafael Sebastião Miranda
 http://olimpiada.ic.unicamp.br/pdf/provas/ProvaOBI2013_inic_f2n2.pdf
 Questões 19 - 24
*/

% Base

/* Pega uma combinação de menina, dia de semana e horário */
dia("reuniao",4,8).
dia("sara",3,9).
dia(AP,D,H) :-  member(AP,["lia","mel","nanda","olga","pilar","rute","tina","nenhuma"]), member(D,[2,3,4,5,6]) , member(H,[8,9]).
						
/* Exatamente uma candidata se apresentará a cada (dia,horário) */
noRepeatedMember([]).
noRepeatedMember([(_,D,H)|T]) :- not(member((_,D,H),T)) , noRepeatedMember(T).
noRepeatedMember([H|T]) :- not(member(H,T)) , noRepeatedMember(T).


/* W é possível semana de testes */
week(W) :-  dia("lia",DL,HL),dia("mel",DM,HM),dia("nanda",DN,HN),
			dia("olga",DO,HO),dia("pilar",DP,HP),dia("rute",DR,HR),
			dia("sara",DS,HS),dia("tina",DT,HT),dia("reuniao",DRE,HRE),
			noRepeatedMember([(DL,HL),(DM,HM),(DN,HN),(DO,HO),
			(DP,HP),(DR,HR),(DS,HS),(DT,HT),(DRE,HRE)]),
			( DP < DN ; ( DP = DN , HP < HN)), % "pilar" deve ser testada em algum momento antes de "nanda"
			DO = DM, 						  % "olga" deve ser testada no mesmo dia que "mel"
			( HL = 9 ; ( HL = 8 , HR = 8 ) ), % Se "lia" é testada às 8, "rute" é testada às 8
			W = [("lia",DL,HL),("mel",DM,HM),("nanda",DN,HN),("olga",DO,HO),
			("pilar",DP,HP),("rute",DR,HR),("sara",DS,HS),("tina",DT,HT),
			("nenhuma",DRE,HRE)].
			
% Questão 19
			
check19([AP1,AP2,AP3,AP4,AP5]) :- week(W) , member((AP1,2,8),W), member((AP2,3,8),W),
			member((AP3,4,8),W),member((AP4,5,8),W),member((AP5,6,8),W).
	% ?- check19(["olga","nanda","nenhuma","pilar","tina"]).
	% false.
	% ?- check19(["olga","lia","nenhuma","mel","rute"]).
	% false.
	% ?- check19(["olga","pilar","nenhuma","lia","nanda"]).
	% false.
	% ?- check19(["lia","tina","nenhuma","pilar","rute"]).
	% false.
	% ?- check19(["rute","tina","nenhuma","pilar","mel"]).
	% true . (Resposta certa (d))
	
% Questão 21

check21(AP,D,H) :- week(W), member(("tina",DT,HT),W), member(("nanda",DN,HN),W),
			member(("sara",DS,HS),W),
			( DT < DS ; ( DT = DS , HT < HS)),
			( DN < DS ; ( DN = DS , HN < HS)),
			member((AP,D,H),W).
			
	% ?- check21("mel",5,_).
	% true .
	% ?- check21("rute",5,8).
	% true .
	% ?- check21("lia",5,8).
	% false. (Resposta certa (c))
	% ?- check21("lia",4,9).
	% true .
	% check21("tina",D,_),check21("pilar",D,_).
	% D = 2 . (true)
	
% Questão 24

check24(W) :- week(W) , member(("rute",5,8),W), member(("tina",6,8),W).
	% ?- check24(W),member(("olga",DO,HO),W),member(("sara",DS,HS),W),(DO>DS;(DO=DS,HO>HS)).
	% false.
	% ?- check24(W),member(("lia",4,9),W).  (Resposta certa (b))
	% W = [ ("lia", 4, 9), ("mel", 2, 8), ("nanda", 5, 9), ("olga", 2, 9), ("pilar", 3, 8), ("rute", 5, 8), ("sara", 3, 9), ("tina", ..., ...), (..., ...)] . (true)
	% ?- check24(W),member(("nanda",2,8),W).
	% false.
	% ?- check24(W),member(("lia",2,9),W).
	% false.
	% ?- check24(W),member(("olga",DO,_),W),member(("nanda",DN,_),W),(DO is DN+1;DN is DO+1).
	% false.
