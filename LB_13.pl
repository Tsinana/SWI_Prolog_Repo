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
% p(+Sublist,+List)
p1([],_).
p1([H|Ts],[H|T]):-p1(Ts,T).
