% 1 ѕостроить предикат, который возвращает true, если элемент есть в
% списке.
% list_find(+L,?X)
list_find([H|_],H).
list_find([_|T],X):-list_find(T,X).

% 2 ѕостроить предикат, который переворачивает список
%list_revolution (+List1,?List2)
list_revolution1(List1,List2):-list_revolution1(List1,[],List2,List2).
list_revolution1([],List2,List2,[]).
list_revolution1([X|T],ListR,List2,[_|Tail]):- list_revolution1(T,[X|ListR],List2,Tail).

% 3 ѕостроить предикат p(Sublist,List), который возвращает true, если
% элементы Sublist встречаетс€ в List в том же пор€дке. (те. Sublist
% мб. меньше List)
% p(?Sublist,+List)
p1([],_).
p1([H|Ts],[H|T]):-p1(Ts,T).


%  4 ѕостроить предикат, который удал€ет элемент с заданным номером из
% списка.
% list_delete_index(+List1,+X,?List2)
list_delete_index(List1,X,List2):- list_delete_index(List1,X,List2,0).
list_delete_index([_|T],X,T,X).
list_delete_index([H|T],X,[H|Tn],Index):-
    Index1 is Index + 1,list_delete_index(T,X,Tn,Index1).

% 5 ѕостроить предикат, который удал€ет все элементы, равные
% данному.
% list_delete_digit(+List1,+X,?List2)
list_delete_digit([],_,[]).
list_delete_digit([H|T],H,List2):- list_delete_digit(T,H,List2).
list_delete_digit([H|T],X,[H|Tn]):-list_delete_digit(T,X,Tn).
