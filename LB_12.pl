%Nod(+A,+B,?C)
nod(A,0,A):-!.
nod(_,0,_):-!,fail.
nod(A,B,C):-Ost is A mod B, nod(B,Ost,C).

%sum_all_digit(+A,-Sum)
sum_all_digit(0,0):-!.
sum_all_digit(A,Sum):-(A mod 10) < 5,!,
    A1 is A div 10,S is (A mod 10), sum_all_digit(A1,Sum1),Sum is Sum1+S.
sum_all_digit(A,Sum):- A1 is A div 10,sum_all_digit(A1,Sum).

%min_div_digit(+A,-Div)
min_div_digit(_,_,0):-!.
min_div_digit(A,A,I):- A>4, A is I*I,!.
min_div_digit(A,Div,I):- 0 is A mod I,!,
    Div is I, min_div_digit(A,Div,0).
min_div_digit(A,Div,I):- I1 is I +1, min_div_digit(A,Div,I1).
min_div_digit(1,1):-!.
min_div_digit(0,_):- write('Duralei'),!,fail.
min_div_digit(A,Div):- min_div_digit(A,Div,2).

%lenght_digit(+A,-X)
lenght_digit(0,0):- !.
lenght_digit(A,X):- A1 is A div 10,lenght_digit(A1,X1),X is X1 +1.

%11
%func_11(+A,?Count)
rec_func_11_d(A,C,A,X):-!, C is X.
rec_func_11_d(A,C,I,CX):- 0 is I mod 2,not(nod(A,I,1)),!,
    CX1 is CX+1,I1 is I+1, rec_func_11_d(A,C,I1,CX1).
rec_func_11_d(A,C,I,CX):- I1 is I+1,rec_func_11_d(A,C,I1,CX).
func_11(A,Count):- rec_func_11_d(A,Count,2,0).

%func_11_up(+A,-Count)
rec_func_11_up(A,0,A):-!.
rec_func_11_up(A,C,I):- 0 is I mod 2,not(nod(A,I,1)),!,
    I1 is I + 1, rec_func_11_up(A,C1,I1),C = C1 + 1.
rec_func_11_up(A,C,I):- I1 is I+1,rec_func_11_up(A,C,I1).
func_11_up(A,Count):- rec_func_11_up(A,Count,2).

% 12
%func_12(+A,-X)
func_12(_,_,_,1):-!,fail.
func_12(A,X,Div,I):- not(nod(A,I,1)),not(0 is (I mod Div)),!,
    X is I.
func_12(A,X,Div,I):- I1 is I - 1, func_12(A,X,Div,I1).
func_12(A,X):- min_div_digit(A,Div),I is A -1,func_12(A,X1,Div,I),sum_all_digit(A,Y),X is X1 * Y.

% 13
%func_13(+A,-X)
func_13(0,XX,_,XX):-!.
func_13(N,X,L,XX):- N1 is N-1,lenght_digit(N1,L1),L1 is L,!,
    pow(10,L,Y),XX1 is (N+XX)*Y,func_13(N1,X,L1,XX1).
func_13(N,X,L,XX):- N1 is N-1,L1 is L-1, pow(10,L1,Y),XX1 is (N+XX)*Y,func_13(N1,X,L1,XX1).
func_13(N,X,L,XX):- N1 is N-1,
    XX1 is (N+XX),func_13(N1,X,L,XX1).
func_13(N,X):-lenght_digit(N,L), func_13(N,X,L,0).

%-- -- -- List_fun -- -- --

%read_list(+N,-List)
read_list(0,[]):-!.
read_list(N,[H|T]):- read(H),
    Nmines1 is N - 1,read_list(Nmines1,T).

%write_list(+list)
write_list([]):-!.
write_list([H|T]):- write(H),write(' '), write_list([T]).

%list_min(+List,?X)
list_min([],M,M):-!.
list_min([H|T],X,M):-H<M,
    list_min(T,X,H).
list_min([_|T],X,M):- list_min(T,X,M).
list_min([H|T],X):-list_min(T,X,H).

%concat1(+List1,+List2,-List3)
concat1([],B,B):-!.
concat1([H|T],B,[H|Tail]):- concat1(T,B,Tail).

%list_find_qDigit(+List,+X,-Q)
list_find_qDigit([],_,0):-!.
list_find_qDigit([H|T],X,Q):- H is X,!,
    list_find_qDigit(T,X,Q1),Q is Q1 +1.
list_find_qDigit([_|T],X,Q):- list_find_qDigit(T,X,Q).

% 14.
%func_14(+List,-NewList)
func_14([H|_],[],M,Qm):- Qm is 1, H is M,!.
func_14([H|T],[H|Tn],M,Qm):-H is M,!,
    Qm1 is Qm -1,func_14(T,Tn,M,Qm1).
func_14([H|T],[H|Tn],M,Qm):-func_14(T,Tn,M,Qm).
func_14(List,NewList):-list_min(List,M),list_find_qDigit(List,M,Qm),func_14(List,NewList,M,Qm).



