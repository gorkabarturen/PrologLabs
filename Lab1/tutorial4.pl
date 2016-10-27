has_key(a,blue_key).
has_key(d,green_key).
has_key(c,red_key).

door(a,d,no_key).
door(b,d,blue_key).
door(a,c,green_key).
door(a,e,red_key).

init(state(a,[no_key])).
goal(state(e,_)).

action(state(X,Keys), state(Y,Keys)):-
    (door(X,Y,Key); door(Y,X,Key) ),
    member(Key,Keys).
