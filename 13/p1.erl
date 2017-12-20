-module(prog).
-export([main/0]).

input() ->
    io:fread("", "~d: ~d").

next_layer({ok, [L, R]}) when L == 0 -> 
    (0 + next_layer(input()));

next_layer({ok, [L, R]}) ->
    if
        ((L rem (R - 1)) - 0) == 0, L > R -> L * R;
        true -> 0
    end + next_layer(input()) ;

next_layer(_) ->
    0.

main() ->
    io:fwrite("Severity is at ~p", [next_layer(input())]).
