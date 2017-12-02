%N = 10
myLength([], 0).
myLength([X|Y], N):- myLength(Y, N1), N is N1 + 1.

myMember(X, [X|_]).
myMember(X, [_|Y]):- myMember(X, Y).

myAppend([], X, X).
myAppend([A|X], Y, [A|Z]):- myAppend(X, Y, Z).

remove(X, [X|T], T).
remove(X, [Y|T], [Y|T1]):- remove(X, T, T1).

permute([], []).
permute(L, [X|R]):- remove(X, L, T), permute(T, R).


remove_n(1, [X|T], T):-!.
remove_n(N, [X|T], [X|T1]):- N1 is N - 1, remove_n(N1, T, T1).

sum_vectors([], X, X).
sum_vectors(X, [], X).
sum_vectors([X|S], [Y|T], [Z|L]):- Z is X+Y, sum_vectors(S, T, L), !.
