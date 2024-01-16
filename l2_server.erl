-module(l2_server).
-export([start/0,loop/0]).

start()-> 
	spawn(l2_server,loop,[]).

loop()->
	receive
	% comment , pattern matching

	{Client , {Str , uppercase}} -> 
		Client ! {self(),string:to_upper(Str)};

	{Client , {Str , lowercase}} -> 
		Client ! {self() , string:to_lower(Str)}

	end,
	loop().
