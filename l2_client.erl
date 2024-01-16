-module(l2_client).
-export([l2_client/3]).


l2_client(Server , Str , Command) -> 
	
	Server ! {self(),{Str, Command}},
	
	receive
		{Server , ResultStr }->
			ResultStr
	end.
