list_read(0,[]):-!.
list_read(I,[X|T]):-read(X),I1 is I-1,list_read(I1,T).

list_write([]):-!.
list_write([H|T]):-write(H),write(' '),list_write(T).

string_write([]):-!.
string_write([H|T]):-put(H),string_write(T).

list_all_string_write([]):-!.
list_all_string_write([H|T]):-
    string_write(H), nl,
    list_all_string_write(T).

string_read(Str):- string_read(Str,_).
string_read(Str,N):-get0(Char),s_read(Char,Str,[],N,0).
s_read(-1,Str,Str,N,N):-!.
s_read(10,Str,Str,N,N):-!.
s_read(Char,Str,NowStr,N,I):-
    I1 is I+1,
    append(NowStr,[Char],NowStr1),
    get0(Char1),
    s_read(Char1,Str,NowStr1,N,I1).

string_read_for_list(Str,N,IsLast):- get0(Char),s_read_l(Char,Str,[],N,0,IsLast).
s_read_l(-1,Str,Str,N,N,1):-!.
s_read_l(10,Str,Str,N,N,0):-!.
s_read_l(Char,Str,NowStr,N,I,IsLast):-
    I1 is I+1,append(NowStr,[Char],NowStr1),
    get0(Char1),
    s_read_l(Char1,Str,NowStr1,N,I1,IsLast).

list_read(List):-
    string_read_for_list(Str,_,IsLast),list_read([Str],List,IsLast).
list_read(List,List,1):-!.
list_read(Cur_list,List,0):-
    string_read_for_list(Str,_,IsLast),
    append(Cur_list,[Str],C_l),
    list_read(C_l,List,IsLast).

% 11
func_11:-string_read(Str,N),string_write(Str),write(', '),string_write(Str),write(', '),string_write(Str),write(', '),write(N).

% 12 without 'space'
count_words(A,K):-count_words(A,K,1).
count_words([],0,_):-!.
count_words([32|T],K,1):- !, count_words(T,K,1).
count_words([32|T],K,0):- !, count_words(T,K,1).
count_words([_|T],K,1):- !, count_words(T,K1,0),K is K1 + 1.
count_words([_|T],K,0):- count_words(T,K,0).

func_12:- string_read(Str),count_words(Str,Quantity),write(Quantity).

