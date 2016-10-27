:- use_module(library(clpfd)).

schedule(Containers, Constraints, Tasks) :- 
    addTasks(Containers, Constraints, Tasks).

schedule(Constraints, Tasks) :- 
    write(Tasks), nl,
    write('(Start,Duration,End,Resources,Name)'), nl,
    cumulative(Tasks, [limit(123)]),
    write(Tasks),nl.

addTasks([] , Constraints , Task) :- schedule([],Task).
addTasks([Container | Containers], Constraints, Task) :- 
    addContainer(Container, B, M, D),
    checkConstraints(B, Containers, Constraints, StartTime),
    append([task( StartTime, D, _, M, B )],Task, Tasks),
    addTasks(Containers, Constraints, Tasks).
    
addContainer(container(B,M,D), B, M, D). 
addConstraint(on(A,B), A,B).

checkDuration([],X,Duration).
checkDuration([container(B,M,D) | Containers], X, Duration) :-
    X == B,
    Duration is D + 0;
    X \== B, 
    Duration is 0 + 0,
    checkDuration(Containers, X, Duration).

checkConstraints(B, Containers, [], StartTime).
checkConstraints(B, [], Constraints, StartTime) :- 
    StartTime is 0 + 0.

checkConstraints(B, [Container | Containers], [Constraint | Constraints], StartTime) :- 
    addConstraint(Constraint , X , Y),
    B == Y,
    checkDuration([Container | Containers], X, Duration),
    StartTime is 0 + Duration;
    checkConstraints(B,  Containers, Constraints, StartTime).

max2([R], R).
max2([task(A,B,C,D,E)|Tasks], R):-
    max2(Xs, T), (D > T -> R = D ; R = T).
    
