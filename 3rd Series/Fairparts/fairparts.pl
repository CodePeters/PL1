fair_parts(File,Final2):-
 read_and_return(File, N, Weights),
 max_list(Weights,Left),
 sum(Weights,Right),
 reverse(Weights,List),
 fairDiv(List,Left,Right,Final2,N).

fairDiv(L1,Left,Right,Final,N):-

    Li is div(Right+Left,2),
    fuller(L1,Li,FList,0),
    del(FList,FList2),
    length(FList2,N2),
    (Left =\= Right-> (N>=N2 ,Right1 is Li,fairDiv(L1,Left,Right1,Final,N);   
                       N<N2 ,Left1 is Li+1,fairDiv(L1,Left1,Right,Final,N) );
     Left=:=Right->(N>N2,fuller1(L1,Li,Final1,0,N),del(Final1,FList3) ,reverse2(FList3,Final);reverse2(FList2,Final))),!.
    
fuller([],_,[[_]],_).
fuller([H|T],Li,[[H1|T1]|T2],Sum):-Sum1 is Sum+H,(Sum1 =< Li,H1 is H,fuller(T,Li,[T1|T2],Sum1);
                                                   Sum1 > Li ,T1=[],fuller([H|T],Li,T2,0) ).

fuller1([],_,[[_]],_,1).
fuller1([H|T],Li,[[H1|T1]|T2],Sum,N):-Sum1 is Sum+H,length(T,K),(Sum1 =< Li,K+1>=N,H1 is H,!,fuller1(T,Li,[T1|T2],Sum1,N);
                                                    T1=[],N1 is N-1,N1>=0 ,fuller1([H|T],Li,T2,0,N1) ).

del([[_]],[[]]).
del([[_]|T1],[[]|T2]):-del(T1,T2).
del([[H|T]|T2],[[H|T1]|T3]):-del([T|T2],[T1|T3]). 

read_and_return(File, N, Weights) :-
    open(File, read, Stream),
    read_line(Stream, [M, N]),
    read_line(Stream, Weights),
    length(Weights, L),
    ( L =:= M -> close(Stream)  %% just a check for for sanity
    ; format("Error: expected to read ~d weights but found ~d", [M, L]),
      close(Stream), fail).

read_line(Stream, List) :-
    read_line_to_codes(Stream, Line),
    atom_codes(A, Line),
    atomic_list_concat(As, ' ', A),
    maplist(atom_number, As, List).

sum(L,N):- sum2(L,N,0).

sum2([],N,N).
sum2([H|T],N,M):-N1 is M+H,sum2(T,N,N1).

reverse2(L,L2):-reverse(L,List),reverse3(List,L2).
reverse3([],[]).
reverse3([L|T],[H|T2]):-reverse(L,List),H=List ,reverse3(T,T2).