% 1
% list_find(+L,?X)
list_find([H|_],H).
list_find([_|T],X):-list_find(T,X).

% 2
%list_revolution (+List1,?List2)
list_revolution1(List1,List2):-list_revolution1(List1,[],List2,List2).
list_revolution1([],List2,List2,[]).
list_revolution1([X|T],ListR,List2,[_|Tail]):- list_revolution1(T,[X|ListR],List2,Tail).

% 3
% p(?Sublist,+List)
p1([],_).
p1([H|Ts],[H|T]):-p1(Ts,T).


% 4
% list_delete_index(+List1,+X,?List2)
list_delete_index(List1,X,List2):- list_delete_index(List1,X,List2,0).
list_delete_index([_|T],X,T,X).
list_delete_index([H|T],X,[H|Tn],Index):-
    Index1 is Index + 1,list_delete_index(T,X,Tn,Index1).

% 5
% list_delete_digit(+List1,+X,?List2)
list_delete_digit([],_,[]).
list_delete_digit([H|T],H,List2):- list_delete_digit(T,H,List2).
list_delete_digit([H|T],X,[H|Tn]):-list_delete_digit(T,X,Tn).

% 6
concat1([],B,B).
concat1([H|T],B,[H|Tn]):-concat1(T,B,Tn).

% list_single_elemets(+List)
list_single_elemets(List):-list_single_elemets(List,[]).
list_single_elemets([],_):-true.
list_single_elemets([H|T],List2):-not(list_find(List2,H)),!,
    concat1([H],List2,ListNew),list_single_elemets(T,ListNew).
list_single_elemets(_,_):-false.

%11
%arr_min(+Arr,?X)
arr_min([],X,X):-!.
arr_min([H|T],M,X):-H<M,!,
    arr_min(T,H,X).
arr_min([_|T],M,X):-arr_min(T,M,X).
arr_min([H|T],X):-arr_min(T,H,X).
