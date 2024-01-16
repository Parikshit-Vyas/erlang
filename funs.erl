-module(funs).
-export([filter/1]).


% Just like anonymous functions use `fun`
% lists:map , maps each element to a outer function 
%lists:filter , filters lists based on a function.

filter(L) ->
 { lists:map(fun(X) -> X >10 end,L) , lists:filter(fun(X) -> X>10 end,L) }.
