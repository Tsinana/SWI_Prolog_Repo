man(voeneg).
man(ratibor).
man(boguslav).
man(velerad).
man(duhovlad).
man(svyatoslav).
man(dobrozhir).
man(bogomil).
man(zlatomir).
man(misha).

woman(goluba).
woman(lubomila).
woman(bratislava).
woman(veslava).
woman(zhdana).
woman(bozhedara).
woman(broneslava).
woman(veselina).
woman(zdislava).

parent(voeneg,ratibor).
parent(voeneg,bratislava).
parent(voeneg,velerad).
parent(voeneg,zhdana).

parent(goluba,ratibor).
parent(goluba,bratislava).
parent(goluba,velerad).
parent(goluba,zhdana).

parent(ratibor,svyatoslav).
parent(ratibor,dobrozhir).
parent(lubomila,svyatoslav).
parent(lubomila,dobrozhir).

parent(boguslav,bogomil).
parent(boguslav,bozhedara).
parent(bratislava,bogomil).
parent(bratislava,bozhedara).

parent(velerad,broneslava).
parent(velerad,veselina).
parent(veslava,broneslava).
parent(veslava,veselina).

parent(duhovlad,zdislava).
parent(duhovlad,zlatomir).
parent(zhdana,zdislava).
parent(zhdana,zlatomir).

%11
father(X):-parent(Y,X),man(Y),write(Y),!.
father(X,Y):- parent(X,Y),man(X).

%12
wife(X):-parent(X,Z),parent(Y,Z),woman(Y),write(Y),!.
wife(X,Y):- parent(X,Z),parent(Y,Z).

%13
grand_da(X):-parent(X,Z),parent(Z,Y),woman(Y),write(Y).
grand_da(X,Y):-parent(Y,Z),parent(Z,X).

%14
grand_ma_and_son(X,Y):-parent(X,Z),parent(Z,Y);parent(W,X),parent(Y,W).

%15
mult_digit(0,A):-write(A),!.
mult_digit(X,A):-X1 is (X div 10),A1 is (A*(X mod 10)), mult_digit(X1,A1).
mult_digit(X):- mult_digit(X,1).

%16
mult_digit_d(0,1):-!.
mult_digit_d(X,A):-X1 is X div 10,mult_digit_d(X1,A1),A is A1*(X mod 10).
mult_digit_d(X):-mult_digit_d(X,A),write(A).

%17
max_digit_nodiv3(0,0):-!.
max_digit_nodiv3(X,M):- X1 is X div 10 ,X2 is X mod 10, max_digit_nodiv3(X1,M1),((X2 mod 3 =\= 0, M1 < X2 -> M is X2);M is M1).
max_digit_nodiv3(X):-  max_digit_nodiv3(X,M),write(M).

%18
max_digit_nodiv3_d(0,M):-write(M),!.
max_digit_nodiv3_d(X,M):- X1 is X div 10 ,X2 is X mod 10,((X2 mod 3 =\= 0, X2>M -> max_digit_nodiv3_d(X1,X2)); max_digit_nodiv3_d(X1,M)).
max_digit_nodiv3_d(X):-  max_digit_nodiv3_d(X,0).

%19
fib(1,1):-!.
fib(2,1):-!.
fib(N,X):- N1 is N - 1, N2 is N - 2, fib(N1, X1), fib(N2, X2), X is X1 + X2.

%20
fib_d(_,_,N,N,X):-write(X),!.
fib_d(A1,A2,N1,N,_):- B is A1+A2,N2 is N1+1,fib_d(A2,B,N2,N,B).
fib_d(N,X):- fib_d(1,1,2,N,X).

