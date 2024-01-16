-module(fibo).
-export([func/1]).


func(0)->0;

func(1)->1;

func(N)->
	func(N-1)+func(N-2).	
