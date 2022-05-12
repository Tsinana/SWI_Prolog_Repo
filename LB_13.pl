% list_find(+L,?X)
list_find([H|_],H).
list_find([_|T],X):-list_find(T,X).

%list_revolution (+List1,?List2)
list_revolution1(List1,List2):-list_revolution1(List1,[],List2,List2).
list_revolution1([],List2,List2,[]).
list_revolution1([X|T],ListR,List2,[_|Tail]):- list_revolution1(T,[X|ListR],List2,Tail).

% p(?Sublist,+List)
p1([],_).
p1([H|Ts],[H|T]):-p1(Ts,T).

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

%list_find_first_even(+List,?X)
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

%  12 Дан целочисленный массив. Необходимо вывести вначале его
%  положительные элементы, а затем - отрицательные.

