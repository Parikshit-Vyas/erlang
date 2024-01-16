-module(if_stmt).
-export([temp/1]).


%% if statments : true guard acts as default option.

temp(X) ->
	if 
		X < 40 -> io:format("Nice temperature.~n");
		X > 40 -> io:format("Its Hot~n");
		true -> io:format("Its 40degrees~n")
	end.
