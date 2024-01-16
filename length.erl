%meters to yards , inches and feet

%name of the module
-module(length).
%which function with how many paramters you want to export.
-export([convert/1]).

% same as C define
-define(YARD,1.0936).
-define(INCH,39.370).
-define(FOOT,3.28).



convert({yard,Meters}) ->
	Meters* ?YARD;

convert({inch,Meters}) ->
	Meters* ?INCH;

convert({foot,Meters}) ->
	Meters* ?FOOT.




