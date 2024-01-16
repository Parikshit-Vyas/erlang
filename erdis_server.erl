-module(erdis_server).
-export([start_server/0,stop_server/0]).

%% using Mnesia and sockets to create simple key-value DB store like REDIS.

%% records are basically like structs
-record(entry,{
	key,
	value
	}).

initialize_db() ->
	% Mnesia is a distributed real-time DBMS written in erlang
	mnesia:create_schema([node()]),
	mnesia:start(),
	mnesia:create_table(entry,[{attributes,record_info(fields,entry)}]).

start_server() ->
	initialize_db(),
	% Listening to port 10101	
	{ok,Listen} = gen_tcp:listen(10101,[binary,{packet,4},{reuseaddr,true},{active,true}]),
	% process is created for socket creation
	spawn(fun()->par_connect(Listen) end ).


par_connect(Listen) -> 
	% Socket creation by accepting the incoming request to port .
	{ok,Socket} = gen_tcp:accept(Listen),
	% creating one more process that continues listening to port
	spawn(fun() -> par_connect(Listen) end),
	% Now this socket is used for further calls to this server process instance.
	loop(Socket).

stop_server() -> 
	mnesia:stop().



loop(Socket) -> 
	receive
		{tcp,Socket,Bin} -> 
			io:format("Server received binary = ~p ~n",[Bin]),
			Str = binary_to_term(Bin),
			Reply = process_command(Str),
			BinReply = term_to_binary(Reply),
			io:format("Server replying .. = ~s ~n",[BinReply]),
			gen_tcp:send(Socket,BinReply),
			loop(Socket);
		{tcp_closed,Socket} -> 
			io:format("Server Socket closed ~n")
	end.

process_command(Str) -> 
	Parts = string:split(Str," ",all),
	Command = lists:nth(1,Parts),

	case Command of
		"get" -> get_value(lists:nth(2,Parts));
		"set" -> set_value(lists:nth(2,Parts),lists:nth(3,Parts));
		"size" -> get_size();
		"keys" -> keys();
		"delete" -> delete(lists:nth(2,Parts));
		"exists" -> exists(lists:nth(2,Parts))	

	end.

get_value(Key) ->
	F = fun() -> 
		Oid = {entry,Key},
		Entries = mnesia:read(Oid),
		case Entries =:= [] of
			true -> does_not_exists;
			false -> lists:nth(1,Entries)
		end
	    end,
	mnesia:transaction(F).


set_value(Key,Value) ->
	Entry = #entry{key=Key,value=Value},
	
	F = fun() -> 
		mnesia:write(Entry)
	    end,
	mnesia:transaction(F),
	{ok,Key,Value}.

get_size() -> 
	F = fun() -> 
		mnesia:table_info(entry,size)
	    end,
	{ok,mnesia:transaction(F)}.


keys() ->
	F = fun() ->
		mnesia:all_keys(entry)
	    end,
	{ok,mnesia:transaction(F)}.

delete(Key) ->
	Oid = {entry,Key},
	F = fun() ->
		mnesia:delete(Oid)
	    end,
	mnesia:transaction(F),
	{ok,Key}.


exists(Key) -> 
	Exists = get_value(Key),
	case Exists of
		{atomic,does_not_exists}-> false;
		{atomic,_} -> true
	end.






