%
% write list or string
%

list_write([]):- !.
list_write([H|T]):-
    string_write(H), nl, list_write(T).

string_write([]):- !.
string_write([H|T]):- put(H), string_write(T).

%
% read list or string
%

string_read(Str):- string_read(Str,_).
string_read(Str,N):-get0(Char),s_read(Char,Str,[],N,0).
s_read(46,Str,Str,N,N):-!.
s_read(-1,Str,Str,N,N):-!.
s_read(10,Str,Str,N,N):-!.
s_read(Char,Str,NowStr,N,I):-
    I1 is I+1,
    append(NowStr,[Char],NowStr1),
    get0(Char1),
    s_read(Char1,Str,NowStr1,N,I1).

string_read_for_list(Str,N,IsLast):- get0(Char),s_read_l(Char,Str,[],N,0,IsLast).
s_read_l(46,Str,Str,N,N,1):-!.
s_read_l(10,Str,Str,N,N,0):-!.
s_read_l(-1,Str,Str,N,N,1):-!.
s_read_l(Char,Str,NowStr,N,I,IsLast):-
    I1 is I+1,append(NowStr,[Char],NowStr1),
    get0(Char1),
    s_read_l(Char1,Str,NowStr1,N,I1,IsLast).

list_read(List):-
    write('Vvedite slova 4ere3 enter. stop - .'),nl,
    string_read_for_list(Str,_,IsLast),list_read([Str],List,IsLast).
list_read(List,List,1):-!.
list_read(Cur_list,List,0):-
    string_read_for_list(Str,_,IsLast),
    append(Cur_list,[Str],C_l),
    list_read(C_l,List,IsLast).

%
%
%

string_lenght(A,L):-s_l(A,0,L).
s_l([],I,I):-!.
s_l([_|T],I,L):-I1 is I + 1,s_l(T,I1,L).

string_compare([],[]):-true,!.
string_compare([H|T],[H|TN]):-!,string_compare(T,TN).
string_compare(_,_):-false.

list_without_string(List,Str,NewList):- l_ws(List,Str,[],NewList).
l_ws([],_,A,A):-!.
l_ws([H|T],H,List,NewList):- !,l_ws(T,H,List,NewList).
l_ws([H|T],Str,List,NewList):-
    append(List,[H],List1),
    l_ws(T,Str,List1,NewList).

list_quantity_string_in_list(List,Str,Q):-l_qsil(List,Str,0,Q).
l_qsil([],_,Q,Q):-!.
l_qsil([H|T],Str,Q,Qu):-
    string_compare(H,Str),!,
    Q1 is Q + 1,
    l_qsil(T,Str,Q1,Qu).
l_qsil([_|T],Str,Q,Qu):- l_qsil(T,Str,Q,Qu).

%list_max(+List,?Max)
list_max([H|T],Max):- l_max(T,H,Max).
l_max([],M,M):- !.
l_max([H|T],M,Max):- H > M,!,l_max(T,H,Max).
l_max([_|T],M,Max):- l_max(T,M,Max).

%list_min(+List,?Min)
list_min([H|T],Min):- l_min(T,H,Min).
l_min([],M,M):- !.
l_min([H|T],M,Min):- H < M,!,l_min(T,H,Min).
l_min([_|T],M,Min):- l_min(T,M,Min).

% list_find(+L,?X)
list_find([H|_],H).
list_find([_|T],X):-list_find(T,X).

string_qauntity_char_in(Str,Qu,Ch):- s_qc(Str,0,Qu,Ch).
s_qc([],Q,Q,_):-!.
s_qc([H|T],Q,Qu,H):- !, Q1 is Q + 1,s_qc(T,Q1,Qu,H).
s_qc([_|T],Q,Qu,Ch):- s_qc(T,Q,Qu,Ch).

list_qauntity_char_in(List,Qu,Ch):- l_qc(List,0,Qu,Ch).
l_qc([],Q,Q,_):-!.
l_qc([H|T],Q,Qu,Ch):-
    string_qauntity_char_in(H,Q1,Ch),
    QN is (Q1 + Q),
    l_qc(T,QN,Qu,Ch).

%list_element
%l_el(+List,?Id,?El)
l_el(List,Id,El):- l_el(List,0,Id,El).
l_el([El|_],I,I,El):- !.
l_el([_|T],I,Id,El):- I1 is I + 1, l_el(T,I1,Id,El).

l_el_s(List,Id,El):- l_el_s(List,0,Id,El).
l_el_s([El|_],I,I,El).
l_el_s([_|T],I,Id,El):- I1 is I + 1, l_el_s(T,I1,Id,El).

%
% 11
%

func_11:-string_read(Str,N),string_write(Str),write(', '),string_write(Str),write(', '),string_write(Str),write(', '),write(N).

% 12 without 'space'

count_words(A,K):-count_words(A,K,1).
count_words([],0,_):-!.
count_words([32|T],K,1):- !, count_words(T,K,1).
count_words([32|T],K,0):- !, count_words(T,K,1).
count_words([_|T],K,1):- !, count_words(T,K1,0),K is K1 + 1.
count_words([_|T],K,0):- count_words(T,K,0).

func_12:- string_read(Str),count_words(Str,Quantity),write(Quantity).

% 13

%list_the_most_popular_word(+List,-Str)
list_the_most_popular_word(List,Str):- s_mpw(List,[],[],Str).

%s_mpw(List,ListStr,ListId,String)
s_mpw([],LS,LI,Str):- list_max(LI,Max),l_el(LI,Id,Max),l_el(LS,Id,Str).
s_mpw([H|T],LS,LI,Str):-
    list_quantity_string_in_list([H|T],H,Q),
    list_without_string([H|T],H,NL),
    append(LS,[H],LS1),
    append(LI,[Q],LI1),
    s_mpw(NL,LS1,LI1,Str).

func_13:-
    list_read(List),
    list_the_most_popular_word(List,Str),string_write(Str).

%14

func_14:-
    string_read(Str,N),func_14(Str,N).
func_14(Str,N):-
    N>5,!,
    l_el(Str,0,El1),put(El1),
    l_el(Str,1,El2),put(El2),
    l_el(Str,2,El3),put(El3),
    l_el(Str,3,El4),put(El4),
    l_el(Str,4,El5),put(El5),
    l_el(Str,5,El6),put(El6).
func_14(Str,N):- func_14(Str,N,1).
func_14(_,I,I):-!.
func_14(Str,N,I):-
    l_el(Str,0,El1),put(El1),I1 is I + 1,func(Str,N,I1).

%15

func_15:-
    string_read(Str,N),func_15(Str,N).
func_15(Str,N):-
    N1 is N - 1,
    l_el(Str,N1,El),
    l_el_s(Str,I1,El),
    write(I1).

% 16

list_min_lenght_word(List,Word):- l_mlw(List,[],[],Word).
l_mlw([],LW,LI,Word):-list_min(LI,Min),l_el(LI,Id,Min),l_el(LW,Id,Word).
l_mlw([H|T],LW,LI,Word):-
    string_lenght(H,A),
    list_without_string([H|T],H,NL),
    append(LW,[H],LW1),
    append(LI,[A],LI1),
    l_mlw(NL,LW1,LI1,Word).

func_16:-
    see('C:/GitHub/SWI_Prolog_Repo/Fails/task_2_1.txt'),
    list_read(List),list_min_lenght_word(List,Word),seen,
    tell('C:/GitHub/SWI_Prolog_Repo/Fails/task_2_1_answer.txt'),string_write(Word),told.

% 17

list_qauntity_string_without_space(List,Qu):- l_qsws(List,0,Qu).
l_qsws([],Q,Q):-!.
l_qsws([H|T],Q,Qu):-not(list_find(H,32)),!,Q1 is Q + 1,l_qsws(T,Q1,Qu).
l_qsws([_|T],Q,Qu):-l_qsws(T,Q,Qu).

func_17:-
    see('C:/GitHub/SWI_Prolog_Repo/Fails/task_2_2.txt'),
    list_read(List),list_qauntity_string_without_space(List,Q),seen,
    tell('C:/GitHub/SWI_Prolog_Repo/Fails/task_2_2_answer.txt'),write(Q),told.

%18

func_18:-
    see('C:/GitHub/SWI_Prolog_Repo/Fails/task_2_3.txt'),
    list_read(List),seen,
    string_lenght(List,Q),
    list_qauntity_char_in(List,QCh,65),
    SR is QCh div Q,
    func_18(List,SR,[],NL),
    tell('C:/GitHub/SWI_Prolog_Repo/Fails/task_2_3_answer.txt'),list_write(NL),told.

func_18([],_,L,L):- !.
func_18([H|T],SR,L,NL):-
    string_qauntity_char_in(H,Q,65),
    Q > SR,
    !,
    append(L,[H],L1),
    func_18(T,SR,L1,NL).
func_18([_|T],SR,L,NL):- func_18(T,SR,L,NL).

%19
