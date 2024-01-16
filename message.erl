-module(message).
% including header file
-include("message.hrl").
-export([print_mssg/1,update_sender/2]).


print_mssg(#message{sender=S,receiver=R,text=T} = M) ->
	io:format("Message~n"),
	io:format("Sender : ~s ~n",[S]),
	io:format("Recevier : ~s ~n",[R]),
	io:format("TExt : ~s ~n",[T]).

update_sender(Sender , #message{} = M) ->
	M#message{sender=Sender}.

%% record guard

is_mssg(X) when is_record(X,message) -> true ;
is_mssg(X) -> false.
