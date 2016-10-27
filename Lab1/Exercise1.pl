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

likes(X, Y) :- beautiful(Y).
happy(X) :- rich(X).
happy(X) :- likes(X, Y), likes(Y,X).
likes(nisse, X) :- likes(X, nisse)
likes(ulrika, X) :- rich(X), kind(X).
likes(ulrika, X) :- beautiful(X), strong(X).

