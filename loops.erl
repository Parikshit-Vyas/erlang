-module(loops).
-export([for/3,fordown/3,range/4]).

% F here is (fun (I) -> io:format("~w~n",[I])end).
% once loop reaches max it creates only 1 element at max
% 1 ,2 ,3, 4, 5, ... 
for(Max,Max,F) -> 
	[F(Max)];
for(I,Max,F) -> 
	[F(I)|for(I+1,Max,F)].


% 10,9,8,7,6 ... 
fordown(Min,Min,F) -> [F(Min)];
fordown(I,Min,F)-> [F(I)|fordown(I-1,Min,F)].

% 1,3,5,7,9 ... 
range(Max,Max,Step,F)->[F(Max)];
range(I,Max,Step,F) -> [F(I)|range(I+Step,Max,Step,F)].
