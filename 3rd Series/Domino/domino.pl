dominos(File,Ways):-
    read_and_return(File, Weights),
    fullzeros(Mark),
    fullzeros(Used),
    nb_setval(count,0),
    solver(Weights,Mark,Used),
    nb_getval(count,Ways).

solver(Weights,Mark,Used):-solver2(Weights,Mark,Used,0,0).

solver2(List,Mark,Used,X,Y):-(Y=:=8->X2 is X+1,Y2 is 0;X2 is X,Y2 is Y),(X2=:=7->add ;Y1 is Y2+1,X1 is X2+1,(index(Mark,X2,Y2,1)->solver2(List,Mark,Used,X2,Y1);

                                      replace2(X2,Y2,1,Mark,L1),index(List,X2,Y2,E1),

                                      (Y2<7,index(L1,X2,Y1,0),index(List,X2,Y1,E2),index(Used,E1,E2,0)->
                                       replace2(E1,E2,1,Used,L2),replace2(E2,E1,1,L2,L3),replace2(X2,Y1,1,L1,Mark1) ,solver2(List,Mark1,L3,X2,Y1); true),

                                      (X2<6,index(L1,X1,Y2,0),index(List,X1,Y2,E3),index(Used,E1,E3,0)->
                                       replace2(E1,E3,1,Used,L4),replace2(E3,E1,1,L4,L5),replace2(X1,Y2,1,L1,Mark2),solver2(List,Mark2,L5,X2,Y1); true) )),!.

add :- nb_getval(count, C), CNew is C + 1, nb_setval(count, CNew).

fullzeros(L):-fullzeros2(L,7).

fullzeros2([],0).
fullzeros2([[0,0,0,0,0,0,0,0]|T],N):-N1 is N-1,fullzeros2(T,N1),!.

replace2(Line,Column,E,[List | Rest],[List |NewList]) :-
    Line > 0,
    Line1 is Line - 1,
    replace2(Line1, Column,E, Rest, NewList),!.

replace2(0, Column,E,[List | Rest],[List1 |Rest]) :-
    removeElementL(Column, E,List, List1).

removeElementL(Column, E,[H | T], [H | T1]) :-
    Column > 0,
    Column1 is Column - 1,
    removeElementL(Column1,E, T, T1).

removeElementL(0, E,[_H | T],[E|T]).

index(Matrix, Row, Col, Value):-
  nth0(Row, Matrix, MatrixRow),
  nth0(Col, MatrixRow, Value).

read_and_return(File,Weights) :-
    open(File, read, Stream),
    read1(Stream,Weights,1).
   
read1(Stream,[],8):- close(Stream).
read1(Stream,[H|T],N):-
    read_line(Stream, H),
    N1 is N+1,
    read1(Stream,T,N1),!.
   
read_line(Stream, List) :-
    read_line_to_codes(Stream, Line),
    atom_codes(A, Line),
    atomic_list_concat(As, ' ', A),
    maplist(atom_number, As, List).