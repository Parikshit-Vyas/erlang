-module(cases).
-export([greet/3]).

%% case statments :: 

greet(Name, Lang, Age) ->
	case Lang of 
		polish when Age < 18 -> io:format("Witaj ~s ~n",[Name]);
		polist -> io:format("Witaj Mr.~s ~n",[Name]);
		english when Age < 18 -> io:format("Hello ~s ~n",[Name]);
		english -> io:format("Hello Mr. ~s ~n",[Name]);
		spanish -> io:format("Hola ~s ~n",[Name])
	end.
