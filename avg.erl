-module(avg).
-export([avg/1]).

% how sum is calcualted using recursion sort of ... 
sum([])->0;

sum([H|T])-> H + sum(T).

avg(L)->sum(L)/length(L).


