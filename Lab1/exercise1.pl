% Facts of the program

beautiful(ulrika).
beautiful(nisse).
rich(nisse).
rich(bettan).
strong(bettan).
strong(peter).
beautiful(peter).
kind(bosse).
strong(bosse).

% Rules of the program

likes(X, Y) :-
    rich(Y), kind(Y), X==ulrika, Y\==ulrika, likes(Y , ulrika);
    beautiful(Y), X\==ulrika , X\==nisse;
    beautiful(Y), strong(Y), X==ulrika, Y\==ulrika,  likes(Y, ulrika);
    X==nisse, Y\==nisse, likes(Y, nisse).

happy(X) :- rich(X) ; likes(X,Y), likes(Y,X).
