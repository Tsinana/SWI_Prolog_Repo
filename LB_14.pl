%
% write list or string
%

list_write([]):- !.
list_write([H|T]):- string_write(H), nl, list_write(T).

string_write([]):- !.
string_write([H|T]):- put(H), string_write(T).

string_ww([]):- !.
string_ww([H|T]):- write(H), string_ww(T).


%
% read list or string
%

string_read(Str):- string_read(Str,_).
string_read(Str,N):-get0(Char),s_read(Char,Str,[],N,0).
s_read(46,Str,Str,N,N):-!.
s_read(-1,Str,Str,N,N):-!.
s_read(10,Str,Str,N,N):-!.
s_read(Char,Str,NowStr,N,I):- I1 is I+1, append(NowStr,[Char],NowStr1),
    get0(Char1), s_read(Char1,Str,NowStr1,N,I1).

string_read_for_list(Str,N,IsLast):- get0(Char),s_read_l(Char,Str,[],N,0,IsLast).
s_read_l(46,Str,Str,N,N,1):-!.
s_read_l(10,Str,Str,N,N,0):-!.
s_read_l(-1,Str,Str,N,N,1):-!.
s_read_l(Char,Str,NowStr,N,I,IsLast):-
    I1 is I+1, append(NowStr,[Char],NowStr1),
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

string_read_for_list_cheat(Str,N,IsLast):- get0(Char),s_read_C(Char,Str,[],N,0,IsLast).
s_read_C(46,Str,Str,N,N,1):-!.
s_read_C(10,Str,Str,N,N,0):-!.
s_read_C(32,Str,Str,N,N,0):-!.
s_read_C(-1,Str,Str,N,N,1):-!.
s_read_C(Char,Str,NowStr,N,I,IsLast):-
    I1 is I+1,append(NowStr,[Char],NowStr1),
    get0(Char1),
    s_read_C(Char1,Str,NowStr1,N,I1,IsLast).

list_read_cheat(List):-
    string_read_for_list_cheat(Str,_,IsLast),list_read([Str],List,IsLast).
list_read_cheat(List,List,1):-!.
list_read_cheat(Cur_list,List,0):-
    string_read_for_list_cheat(Str,_,IsLast),
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

func_19:-
    see('C:/GitHub/SWI_Prolog_Repo/Fails/task_2_4.txt'),
    list_read(List),seen,
    list_the_most_popular_word(List,Str),
    tell('C:/GitHub/SWI_Prolog_Repo/Fails/task_2_4_answer.txt'),string_write(Str),told.

%20


%list_the_most_popular_word(+List,-Str)
list_solo_words(List,L):- l_sw(List,[],[],L).

%l_sw(List,ListStr,ListId,NewList)
l_sw([],LS,LI,L):- l_sw(LS,LI,L).
l_sw([H|T],LS,LI,L):-
    list_quantity_string_in_list([H|T],H,Q),
    list_without_string([H|T],H,NL),
    append(LS,[H],LS1),
    append(LI,[Q],LI1),
    l_sw(NL,LS1,LI1,L).
l_sw([],[],[]):- !.
l_sw([H|T],[HH|TT],L):-
    1 is HH, !,
    l_sw(T,TT,L1),
    append(L1,[H],L).
l_sw([_|T],[_|TT],L):-l_sw(T,TT,L).


func_20:-
    see('C:/GitHub/SWI_Prolog_Repo/Fails/task_2_5.txt'),
    list_read(List),seen,
    list_solo_words(List,Str),
    tell('C:/GitHub/SWI_Prolog_Repo/Fails/task_2_5_answer.txt'),list_write(Str),told.

% 3

func_3:-
    see('C:/GitHub/SWI_Prolog_Repo/Fails/task_3.txt'),
    list_read_cheat(List),seen,
    func_3(List,L),
    tell('C:/GitHub/SWI_Prolog_Repo/Fails/task_3_answer.txt'),list_write(L),told.
%func_3([H|T],L):-func_3S(H,Str).
%
%func_3S(A,Str)
%
%
%

in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

in_list_exlude([El|T],El,T).
in_list_exlude([H|T],El,[H|TT]):-in_list_exlude(T,El,TT).

build_all_razm_with_repeat_by_k(List,K):-  b_a_rwr(List,K,[]).
build_all_razm_with_repeat_by_k:- string_read(List,_), read(K), b_a_rwr(List,K,[]).

b_a_rwr(_,0,Perm):- string_write(Perm), !, nl, fail.
b_a_rwr(List,K,Perm):- in_list(List,El), K1 is K-1, b_a_rwr(List,K1,[El|Perm]).

build_all_perm(A):- b_a_p(A,[]).
build_all_perm:- string_read(A),b_a_p(A,[]).

b_a_p([],Perm):- string_write(Perm), !, nl, fail.
b_a_p(List,Perm):- in_list_exlude(List,El,A), b_a_p(A,[El|Perm]).

build_all_razm_by_k(List,K):- b_a_r(List,K,[]).
build_all_razm_by_k:- string_read(A), read(K), b_a_r(A,K,[]).

b_a_r(_,0,Perm):- string_write(Perm),nl,!,fail.
b_a_r(List,N,Perm):- in_list_exlude(List,El,A), N1 is N-1 ,b_a_r(A,N1,[El|Perm]).

build_all_subset:- string_read(A),sub_set(A,B),write(B),nl,fail.

sub_set([],[]).
sub_set([H|Set],[H|SubSet]):-sub_set(Set,SubSet).
sub_set([_|Set],SubSet):-sub_set(Set,SubSet).

build_all_sochet_by_k(List,K):- sochet(List,B,K), string_write(B),nl,fail.
build_all_sochet_by_k:-
    string_read(List), read(K), sochet(List,B,K),string_write(B),nl,fail.

sochet(_,[],0):-!.
sochet([H|Set],[H|SubSet],K):- K1 is K - 1, sochet(Set,SubSet,K1).
sochet([_|Set],SubSet,K):- sochet(Set,SubSet,K).

build_all_sochet_with_repeat_by_k(List,K):- sochet_wr(List,B,K), string_write(B),nl,fail.
build_all_sochet_with_repeat_by_k:-
    string_read(List), read(K), sochet_wr(List,B,K),string_write(B),nl,fail.

sochet_wr(_,[],0):-!.
sochet_wr([H|Set],[H|SubSet],K):- K1 is K - 1, sochet_wr([H|Set],SubSet,K1).
sochet_wr([_|Set],SubSet,K):- sochet_wr(Set,SubSet,K).

build_all_razm_with_repeat_by_k(List,K,X):-b_a_rwr(List,K,[],X).

b_a_rwr(_,0,X,X):- !.
b_a_rwr(List,K,Perm,X):- in_list(List,El), K1 is K-1, b_a_rwr(List,K1,[El|Perm],X).

build_all_perm(List,X):-b_a_p_X(List,[],X).

b_a_p_X([],X,X):- !.
b_a_p_X(List,Perm,X):- in_list_exlude(List,El,A), b_a_p_X(A,[El|Perm],X).

build_all_perm(List,X):-b_a_p_X(List,[],X).



getSochet_wr(_,SubSet,0,SL,SLAns):- append(,[SubSet],SLAns), !.
getSochet_wr([H|Set],[H|SubSet],K,SL,SLAns):- K1 is K - 1, getSochet_wr([H|Set],SubSet,K1,SL,SLAns).
getSochet_wr([_|Set],SubSet,K,SL,SLAns):- getSochet_wr(Set,SubSet,K,SL,SLAns).
