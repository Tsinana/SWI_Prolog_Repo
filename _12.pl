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

% 13. Cкажем, что n - цифровое число является пандигитальным, если оно
% использует все цифры от 1 до n ровно один раз. Например, 2143 - это
% 4-значный пандигитал, а также простое число. Какое самое большое n-
% цифровое пандигитальное простое число существует? Задача должна быть
% решена без использования списков. Самое большое число n(n-1)(n-2)..1








%read_list(+N,-List)
read_list(0,[]):-!.
read_list(N,[H|T]):- read(H),
    Nmines1 is N - 1,read_list(Nmines1,T).

%write_list(+list)
write_list([]):-!.
write_list([H|T]):- write(H),write(' '), write_list([T]).

% 14. Дан целочисленный массив. Необходимо найти элементы,
% расположенные перед последним минимальным
%func_14()

%list_min(+List,?Min)
list_min_rec([],_):-!.
list_min_rec([H|T],M):- H<M,list_min_rec(T,M),!.
list_min_rec([H|T],M):- H is H,list_min_rec(T,M).
list_min([H|T],H):-list_min_rec([H|T],H),!.
list_min(List,M):-list_min_rec(List,M).



