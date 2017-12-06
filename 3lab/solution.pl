%X - list of positions of white/black trains at the left side
%R - way which was passed to get the correct permutation Y of black/white trains at the right side
%revese_all predicate reveses path list and his elements because of popping the first(not last) train of list X
solve(X, R):- reverse(X, X1), permutation(X1, Y), bw(Y), bfs(s(X1, [], []), s([], [], Y), W), reverse_all(W, W1), reverse(W1, R), !.

reverse_all([], []).
reverse_all([s(X, Y, Z) | T], [s(P, Q, R) | RT]):- reverse(X, P), reverse(Y, Q), reverse(Z, R), reverse_all(T, RT).

%does the list X contain the correct permutation of black/white trains(list begins with black(bw1) or white(bw2) train)
bw(X):- bw1(X); bw2(X).

bw1([]).
%if X is black, then next train must be white
bw1([X | T]):- X==black, bw2(T).

bw2([]).
%if X is white, then next train must be black
bw2([X | T]):- X==white, bw1(T).

first([], []).
first([X | T], X).
%1st argument of 's' state is list of trains at left side, 2nd - bottom and 3rd - right one
move(s([A | AT], B, C), s(AT, B, [A | C])):- first(C, X), X \= A.
move(s(A, [B | BT], C), s(A, BT, [B | C])):- first(C, X), X \= B.
move(s([A | AT], B, C), s(AT, [A | B], C)):- first(C, X), X == A.

%if we can move to Y, then prolong our path to it(Y can`t be contained in path, which we`ve already passed)
prolong([X | T], [Y, X | T]):- move(X, Y), \+(member(Y, [X | T])).

%if X at the beggining of queue, then get an item, where X is contained in
path([[X | T] | _], X, [X | T]).

%find all prolongations from current state and append list of these prolongations to the current queue. Then continue search with new queue
path([P | Q], B, R):- findall(X, prolong(P, X), L), append(Q, L, QL), !, path(QL, B, R).

%if we haven`t reached B state, then continue searching path in the tail our list(queue)
path([_ | Q], B, R):- path(Q, B, R).

%breadth first search begins at A state and ends at B one; R is reversed path from A to B.
bfs(A, B, R):- path([[A]], B, R).

