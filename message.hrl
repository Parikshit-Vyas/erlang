% .hrl format like in header file of C etc

% its like a struct 
-record(message,{
	sender = "" ,
	receiver = "" ,
	text = ""
}).

