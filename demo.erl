-module(demo).
-export([loop/0, parse_str/1, eval/1, parse_and_eval/1]).

parse_str(String) ->
    case demo_scanner:string(String) of
        {ok, Tokens, _} ->
            case demo_parser:parse(Tokens) of
                {ok, AST} ->
                    AST;
                {error, {Line, _, Info}} ->
                    throw({Line, Info})
            end;
        {error, Info, Line} ->
            throw({Line, Info})
    end.

eval({'+', L, R}) -> eval(L) + eval(R);
eval({'-', L, R}) -> eval(L) - eval(R);
eval({'*', L, R}) -> eval(L) * eval(R);
eval({'**', L, R}) -> math:pow(eval(L), eval(R));
eval({'/', L, R}) -> eval(L) / eval(R);
eval({integer, _, Value}) -> Value;
eval({float, _, Value}) -> Value.

%% example expr string: 1 + 2.0e2 * 3 ** 2 * (3 + 4)
parse_and_eval(String) ->
    eval(parse_str(String)).

loop() ->
    io:format("~w~n", [eval(parse_str(io:get_line(">>> ")))]),
    loop().

