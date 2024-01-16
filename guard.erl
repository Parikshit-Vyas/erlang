-module(guard).
-export([factorial/1,range/1]).

is_A(X) -> X == "A".


%here any one guard needs to be true
%head(arg1 ,arg2 ... )[when Guard1 ; Guard2; ... GuardN ] -> Body.

%every gaurd needs to be true
%head(arg1 , arg2 ...)[when Guard1, Gaurd2 , ... GaurdN] -> Body.

%% User-Defined funcs cant be called in guards.

factorial(N) when N<2 , N>-1 -> 1;

factorial(N) -> N * factorial(N-1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


range(X) when is_integer(X); X > 10 ; X <100 -> 
	io:format("~w is in range ~n",[X]);

range(X) -> 
	io:format("~w is not in range",[X]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


min(X,Y) when X > Y -> Y;
min(X,Y) ->  X .

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

is_sum_greater(X,Y,Z) when X + Y > Z -> true ;
is_sum_greater(X,Y,Z) -> false.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

even(X) when X rem 2 == 0 -> true;
even(X) -> false.
