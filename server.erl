-module(server).
-import(string,[concat/2]).
-import(crypto,[hash/2]).
-import(binary,[decode_unsigned/1]).
-export([get_random_string/2,get_hashed_string/1,zeroes/1,listen/0,start/1,loop/2]).

get_random_string(Length, Chars) ->
  lists:foldl(fun(_, Number) ->
    [lists:nth(rand:uniform(length(Chars)),
      Chars)]
    ++ Number
              end, [], lists:seq(1, Length)).


start(Term) ->
      register(list1,spawn(server,listen,[])),
      register(list2,spawn(server,listen,[])),
      spawn(server,get_hashed_string,[Term]).

get_hashed_string(Term) ->
  Str1 = "jbaddam",
  Str2 = get_random_string(16,"abcdefghijklmnopqrstuvwxyz1234567890"),
  Str3 = concat(Str1,Str2),
  %io:fwrite("value is ~p~n",[Str3]),
  %io:fwrite("String is ~p~n",[Str7])
  Str4 = io_lib:format("~64.16.0b", [binary:decode_unsigned(crypto:hash(sha256,
    Str3))]),
  Str5 = lists:sublist(Str4,1,Term),
  Str6 = zeroes(Term),
  if
    Str5 == Str6 -> io:fwrite("server random_String: ~p, Zeroes for Hashin is  ~p,  and Hashed Data is:  ~p~n",[Str3,Term,Str4]);
    true -> ok
  end,
  get_hashed_string(Term).

loop(0,Term) ->
  Term,
  ok;
loop(Count,Term) ->
  get_hashed_string(Term),
  loop(Count-1,Term).

listen() ->
  receive
    {connect, Node_2} ->
      io:format("client connection established and started mining for ~p~n",[Node_2]);
    {InputData,Hashed_Data,Client_name,Zeroes} ->
      io:format("~p random_String: ~p, Zeroes for Hashing is  ~p   Hashed Data is:  ~p~n",[Client_name,InputData,Zeroes,Hashed_Data]),
      listen()
  end.


zeroes(N) when N == 0 -> "";
zeroes(N) when N == 1 -> "0";
zeroes(N) when N > 1 -> string:concat("0",zeroes(N-1)).
