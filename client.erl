%%%-------------------------------------------------------------------
%%% @author HP PC
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. Sep 2022 17:18
%%%-------------------------------------------------------------------
-module(client).
-author("HP PC").
-import(string,[concat/2]).
%% API
-export([start/1,get_hashed_string_of_client/2,get_random_string_of_client/2,connect/1]).

connect(Node_1) ->
  io:fwrite("connecting to server"),
  {list1,Node_1} ! { connect, self()}.



get_random_string_of_client(Length, Chars) ->
  lists:foldl(fun(_, Number) ->
    [lists:nth(rand:uniform(length(Chars)),
      Chars)]
    ++ Number
              end, [], lists:seq(1, Length)).

get_hashed_string_of_client(Term,Node_1) ->
  Str1 = "yeshil",
  Str2 = get_random_string_of_client(16,"abcdefghijklmnopqrstuvwxyz1234567890"),
  Str3 = concat(Str1,Str2),
  Str4 = io_lib:format("~64.16.0b", [binary:decode_unsigned(crypto:hash(sha256,
    Str3))]),
  Str5 = lists:sublist(Str4,1,Term),
  Str6 = zeroes(Term),
  if
    Str5 == Str6 ->
      {list2,Node_1} ! {Str3,Str4,Str1,Term},
      io:fwrite("client pinged server~n");
    true -> ok
  end,
  get_hashed_string_of_client(Term,Node_1).
start(Node_1) ->
  {ok,Zeroes} = io:read("Enter number of zeroes: "),
  spawn(client,connect,[Node_1]),
  spawn(client,get_hashed_string_of_client,[Zeroes,Node_1]).



zeroes(N) when N == 0 -> "";
zeroes(N) when N == 1 -> "0";
zeroes(N) when N > 1 -> string:concat("0",zeroes(N-1)).



