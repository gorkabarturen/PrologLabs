% Example program :   ?- search. 
% 
% Initial state of the program:  
%     |      |
%     |      | Cannibal
%     |   [B]| Cannibal
%     |      | Cannibal
%     |      | Missionary
%     |      | Missionary
%     |      | Missionary  


% Missionaries are safe if there are 0 missionaries, 3, or equal missionaries and cannibals 
safe(0, _).
safe(3, _).
safe(X, X).

% A state is represented by a term:
%    state( Missionaries, Cannibals, BoatRight)
initial(state(3,3,1)). 
% Goal is to get every cannibal and missionary to the left side of the river
goal(state(0,0,0)).
goalpath([Node | _]) :- goal(Node).

move( state( M1, C1, 1), state( M2, C1, 0) )    :- 
    M1 > 1, M2 is M1-2, safe(M2, C1).  % Move two missionaries from right to left

move( state( M1, C1, 0),state( M2, C1, 1) )   :-
    M1 < 2, M2 is M1+2, safe(M2, C1).  % Move two missionaries from left to right

move( state( M1, C1, 1),state( M1, C2, 0) )     :-
    C1 > 1, C2 is C1-2, safe(M1, C2).  % Move two cannibals from right to left

move( state( M1, C1, 0), state( M1, C2, 1) )   :- 
    C1 < 2, C2 is C1+2, safe(M1, C2).  % Move two cannibals from left to right

move( state( M1, C1, 1),state( M1, C2, 0) )    :- 
    C1 > 0, C2 is C1-1, safe(M1, C2).  % Move one cannibal from right to left

move( state( M1, C1, 0), state( M1, C2, 1) )   :- 
    C1 < 3, C2 is C1+1, safe(M1, C2).  % Move one cannibal from left to right

move( state( M1, C1, 1),state( M2, C2, 0) )   :-
    M1 > 0, M2 is M1-1,  
    C1 > 0, C2 is C1-1, safe(M2, C2).  % Move cannibal and missionary from right to left

move( state( M1, C1, 0), state( M2, C2, 1) )  :-
    M1 < 3, M2 is M1+1,   
    C1 < 3, C2 is C1+1, safe(M2, C2).  % Move cannibal and missionary from left to right

% Explanation of the printing of the states
printsol([X]) :- write('State of the right side of the river'), nl, write('(Number of Missionaries, Number of cannibals, Boat is on the right side of the river)'), nl, write(X),nl.
printsol([X,Y|Z]) :- printsol([Y | Z]), write(X), nl.



% Start of the program
search :- 
    initial( Start),
% Apply the breadth-first search algorithm over the initial state
    depthfirst( [ [Start] ], Solution),
    % Solution is a path (in reverse order) from initial to a goal
    printsol(Solution).

% Implementation of the depth-first search algorithm.
% depthfirst( [ Path1, Path2, ...], Solution):

depthfirst( [ Path | _], Path)  :-
    goalpath( Path ).  % if Path is a goal-path, then it is a solution.

depthfirst( [Path | Paths], Solution)  :-
    % Expand the node 
  expand( Path, NewPaths),
    % Append the children nodes at the start of the current queue
  append( NewPaths, Paths, Paths1),
  depthfirst( Paths1, Solution).

expand( [Node | Path], NewPaths)  :-
  setof( [NewNode, Node | Path],
         ( move( Node, NewNode), not(member( NewNode, [Node | Path] )) ),
         NewPaths),
  !.

expand( _, [] ).              % Node has no successor

not(P) :- P, !, fail.
not(_).

