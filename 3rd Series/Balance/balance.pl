balance(N,W,L,R):-
N1 is N-1,
pow(3,N1,Z),
X is div(Z-1,2),
W=<X,
W1 is mod(W,3),
balance2(N,W1,W,L,R,0),!.

balance2(N,_,_,[],[],N).
balance2(_,_,0,[],[],_).
balance2(N,1,W,L1,[K1|T],K):- W2 is div(W-1,3),W3 is mod(W2,3),K1 is K+1,balance2(N,W3,W2,L1,T,K1).
balance2(N,2,W,[K1|T],L2,K):- W2 is div(W+1,3),W3 is mod(W2,3),K1 is K+1,balance2(N,W3,W2,T,L2,K1).
balance2(N,0,W,L1,L2,K):- W2 is div(W,3),W3 is mod(W2,3),K1 is K+1,balance2(N,W3,W2,L1,L2,K1).