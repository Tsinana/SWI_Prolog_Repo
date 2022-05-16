% list_find(+L,?X)
list_find([H|_],H).
list_find([_|T],X):-list_find(T,X).

list_find_ex([El|T],El,T).
list_find_ex([H|T],El,[H|Tail]):-list_find_ex(T,El,Tail).

list_find_ex_stop([El|T],El,T):-!.
list_find_ex_stop([H|T],El,[H|Tail]):-list_find_ex_stop(T,El,Tail).


% list_revolution (+List1,?List2)
list_revolution1(List1,List2):-list_revolution1(List1,[],List2,List2).
list_revolution1([],List2,List2,[]).
list_revolution1([X|T],ListR,List2,[_|Tail]):- list_revolution1(T,[X|ListR],List2,Tail).

permutation1(_,0,Premka,Premka).
permutation1(A,Lenght,Perm,Premka):-
    list_find_ex(A,El,T),L1 is Lenght-1,permutation1(T,L1,[El|Perm],Premka).

% list_lenght(+List,-Lenght)
list_lenght1([],0):-!.
list_lenght1([_|T],L):- list_lenght1(T,L1),L is L1 + 1.

% list_delete_index(+List1,+X,?List2)
list_delete_index(List1,X,List2):- list_delete_index(List1,X,List2,0).
list_delete_index([_|T],X,T,X).
list_delete_index([H|T],X,[H|Tn],Index):-
    Index1 is Index + 1,list_delete_index(T,X,Tn,Index1).

% list_delete_digit(+List1,+X,?List2)
list_delete_digit([],_,[]).
list_delete_digit([H|T],H,List2):- list_delete_digit(T,H,List2).
list_delete_digit([H|T],X,[H|Tn]):-list_delete_digit(T,X,Tn).

concat1([],B,B).
concat1([H|T],B,[H|Tn]):-concat1(T,B,Tn).

% list_single_elemets(+List)
list_single_elemets(List):-list_single_elemets(List,[]).
list_single_elemets([],_):-true.
list_single_elemets([H|T],List2):-not(list_find(List2,H)),!,
    concat1([H],List2,ListNew),list_single_elemets(T,ListNew).
list_single_elemets(_,_):-false.

% list_find_first_even(+List,?X)
list_find_first_even([H|_],M):-0 is H mod 2,!,
    M is H.
list_find_first_even([_|T],M):-list_find_first_even(T,M).

% 11
% arr_min(+Arr,?X)
arr_min_even([],X,X):-!.
arr_min_even([H|T],M,X):- 0 is H mod 2,H<M,!,
    arr_min_even(T,H,X).
arr_min_even([_|T],M,X):-arr_min_even(T,M,X).
arr_min_even(List,X):-list_find_first_even(List,M),arr_min_even(List,M,X).

% 12
% arr_do_new_arr_negative_and_positive(+List1,-List2)
arr_do_new_arr_negative_and_positive(List1,List2):-
    func_adnaNaP(List1,ListN,ListP),concat1(ListP,ListN,List2).
func_adnaNaP([],[],[]):-!.
func_adnaNaP([H|T],[H|TN],List):- H>0,!,
    func_adnaNaP(T,TN,List).
func_adnaNaP([H|T],List,[H|TP]):- func_adnaNaP(T,List,TP).

% 13
% list_quantity_sum_any_two_digit(+List,Q)
list_quantity_sum_any_two_digit([H|T],Q):-list_quantity_sum_any_two_digit([H|T],T,H,Q).
list_quantity_sum_any_two_digit(_,[],_,0):-!.
list_quantity_sum_any_two_digit(List,[H|T],El,Q):-
    list_find_ex_stop(List,El,Ex), func_222222222222222222222(Ex,El),!,
    list_quantity_sum_any_two_digit(List,T,H,Q1),Q is Q1+1.
list_quantity_sum_any_two_digit(List,[H|T],_,Q):-
    list_quantity_sum_any_two_digit(List,T,H,Q).

func_1([H|T],El):-func_1(T,H,El).
func_1([],_,_):-true.
func_1([H|T],Previous,El):-El is Previous + H,!,func_1(T,H,El).
func_1(_,_,_):-false.

func_222222222222222222222(Ex,El):-list_lenght1(Ex,L),
    permutation1(Ex,L,[],EX),func_1(EX,El).

