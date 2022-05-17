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

% *fire*  i'm fine  *fire*    *fire*

in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).
sprava_next(_,_,[_]):-fail.
sprava_next(A,B,[A|[B|_]]).
sprava_next(A,B,[_|List]):-sprava_next(A,B,List).
sleva_next(_,_,[_]):-fail.
sleva_next(A,B,[B|[A|_]]).
sleva_next(A,B,[_|List]):-sleva_next(A,B,List).
next_to(A,B,List):-sprava_next(A,B,List).
next_to(A,B,List):-sleva_next(A,B,List).
el_no(List,Num,El):-el_no(List,Num,1,El).
el_no([H|_],Num,Num,H):-!.
el_no([_|Tail],Num,Ind,El):-Ind1 is Ind+1,el_no(Tail,Num,Ind1,El).

% 14
pr_commun:- Friends=[_,_,_],
el_no(Friends,1,[blond,_]),
el_no(Friends,2,[brunt,_]),
el_no(Friends,3,[orange,_]),
in_list(Friends,[_,rishow]),
in_list(Friends,[_,below]),
in_list(Friends,[_,chernov]),
(in_list(Friends,[blond,rishow]);in_list(Friends,[blond,chernov])),
(in_list(Friends,[brunt,rishow]);in_list(Friends,[brunt,below])),
(in_list(Friends,[orange,below]);in_list(Friends,[orange,chernov])),
write(Friends).

% 15
per_15:- List=[_,_,_],
    el_no(List,1,[aAnna,_,_]),
    el_no(List,2,[vValia,_,_]),
    el_no(List,3,[nNatasha,_,_]),
    in_list(List,[_,_,white]),
    in_list(List,[_,_,green]),
    in_list(List,[_,_,blue]),
    in_list(List,[_,white,_]),
    in_list(List,[_,green,_]),
    in_list(List,[_,blue,_]),
    not(in_list(List,[vValia,white,white])),
    in_list(List,[nNatasha,_,green]),
    in_list(List,[aAnna,A,A]),
    write(List).

% 16
per_16:- List=[_,_,_],
    el_no(List,1,[slecar,_]),
    el_no(List,2,[tokar,_]),
    el_no(List,3,[svarshik,_]),
    in_list(List,[_,bBoris]),
    in_list(List,[_,iIvan]),
    in_list(List,[_,sSemen]),
    not(in_list(List,[tokar,sSemen])),
    not(in_list(List,[slecar,bBoris])),
    write(List),nl.

% 17
per_17:- List=[_,_,_,_],
    el_no(List,1,[milk,_]),
    el_no(List,2,[water,_]),
    el_no(List,3,[cola,_]),
    el_no(List,4,[kvas,_]),
    in_list(List,[_,butilka]),
    in_list(List,[_,stakan]),
    in_list(List,[_,kuvshin]),
    in_list(List,[_,banka]),
    not(in_list(List,[water,butilka])),
    not(in_list(List,[milk,butilka])),
    not(in_list(List,[cola,banka])),
    not(in_list(List,[water,banka])),
    not(in_list(List,[kvas,kuvshin])),
    (next_to([kvas,_],[cola,_],List);next_to([_,kuvshin],[cola,_],List)),
    (next_to([milk,_],[_,stakan],List);next_to([_,banka],[_,stakan],List)),
     write(List).

% 18
per_18:- List=[_,_,_,_],
    el_no(List,1,[voronov,_]),
    el_no(List,2,[pavlov,_]),
    el_no(List,3,[leva,_]),
    el_no(List,4,[saharov,_]),
    in_list(List,[_,dancer]),
    in_list(List,[_,painter]),
    in_list(List,[_,singer]),
    in_list(List,[_,writer]),
    not(in_list(List,[pavlov,painter])),
    not(in_list(List,[pavlov,writer])),
    not(in_list(List,[voronov,singer])),
    not(in_list(List,[leva,singer])),
    not(in_list(List,[leva,painter])),
    not(in_list(List,[saharov,writer])),
    not(in_list(List,[voronov,writer])),
    write(List).














