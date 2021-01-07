%-----------------------------1 method----------------------------------------------------------
do(L, S) :-                         
    put_arit(L, S, A),
    printer(A, S).    

put_arit(L, S, A) :-                %Finds a solution (+Number list, +Sum, -Solution)
    gen(L, Ls),
    atomic_list_concat(Ls, A),      
    read_term_from_atom(A, T, []),  
    T =:= S.

printer(A, S) :-                    %Writes solutions to console
      writef('%w = %w\n',[A,S]),
      fail.

gen([X], [X]).                      %Generates all possible combinations
gen([H|T], L) :-
    ( L = [H|[+|Ns]]; L = [H|[-|Ns]];  L = [H|Ns]),
    gen(T, Ns).


%Example:
% ?- do([1,2,3], 6).
% 1+2+3 = 6;
% false.


%-----------------------------1 method----------------------------------------------------------

%-----------------------------2 method----------------------------------------------------------

do2(L, S) :-                        
    put_arit2(L, S, Ls),
    printer2(Ls, S).

put_arit2(L, S, Ls) :-             %Finds a solution (+Number list, +Sum, -Solution)
    gen2(L, Ls),
    get_sum(Ls, N),
    N =:= S.

printer2(Ls, S) :-
    printList(Ls),
    writef(' = %w\n', [S]),
    fail.

printList([]).
printList([H|T]) :- write(H), printList(T).


gen2([X], [X]).                      %Generates all possible combinations
gen2([H|T], L) :-
    ( L = [H|[+|Ns]]; L = [H|[-|Ns]];  L = [H|Ns]),
    gen2(T, Ns).


get_sum(L, S) :- get_sum(L, S, +, 0).   %Get value of sum (+List, -Sum)

get_sum([], S, '', S).
get_sum(L, S, Zn, B) :-                 
    make_num(L, T, Z, Sk),
    Zn == +,
    B1 is B + Sk,
    get_sum(T, S, Z, B1).

get_sum(L, S, Zn, B) :-
    make_num(L, T, Z, Sk),
    Zn == -,
    B1 is B - Sk,
    get_sum(T, S, Z, B1).
    


make_num(L, T, Z, S) :- make_num(L, T, Z, S, 0).        %Makes a number up until a +, - or end of list (+List, -Tail, -Sign, -Number)

make_num([+|T], T, +, S, S).
make_num([-|T], T, -, S, S).
make_num([], [], '', S, S).
make_num([H|T], Ts, Z, S, A) :- A1 is A*10 + H, make_num(T, Ts, Z, S, A1), !.


%Example:
% ?- do2([1,2,3], 6).
% 1+2+3 = 6;
% false.

%-----------------------------2 method----------------------------------------------------------
