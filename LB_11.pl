man(voeneg).
man(ratibor).
man(boguslav).
man(velerad).
man(duhovlad).
man(svyatoslav).
man(dobrozhir).
man(bogomil).
man(zlatomir).

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
father(X):-parent(Y,X),write(Y),!.
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
max_digit_nodiv3(0,M):-write(M),!.
max_digit_nodiv3(X,M):- X1 is X div 10 ,X2 is X mod 10,((X2 mod 3 =\= 0, X2>M -> max_digit_nodiv3(X1,X2)); max_digit_nodiv3(X1,M)).
max_digit_nodiv3(X):-  max_digit_nodiv3(X,0).
