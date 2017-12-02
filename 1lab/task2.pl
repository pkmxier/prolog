%Task 3
:- ['three.pl'].
sum_grades([], 0).
sum_grades([grade(_, Y)|T], X):- sum_grades(T, X1), X is Y+X1.

average_mark(G, X, Y):- student(G, X, L), sum_grades(L, Y1), Y is Y1/6, !.

didpass([]).
didpass([grade(_, Y)|T]):- Y\=2, didpass(T).

student_passed(X):- student(_, X, L), didpass(L), !.

sub(X, [], 0).
sub(X, [S|T], Y):- myMember(grade(X, 2), S), sub(X, T, Y1), Y is Y1+1, !; sub(X, T, Y2), Y is Y2, !.
sub_did_not_passed(X, Y):- subject(X1, X), !, findall(Z, student(_, _, Z), L), sub(X1, L, Y).

average_mark_for_list([], 0).
average_mark_for_list([X|T], Y):- average_mark(_, X, Y1), average_mark_for_list(T, Y2), (Y1 >= Y2, Y is Y1; Y is Y2).
max_average_mark(G, X):- findall(Z, student(G, Z, _), L), average_mark_for_list(L, X).

max_mark_students(G, L):- max_average_mark(G, T), findall(Y, average_mark(G, Y, T), L), !.
