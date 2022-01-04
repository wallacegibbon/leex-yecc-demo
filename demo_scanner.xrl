Definitions.

Delim = [.+\-/()]|\*\*|\*
BinaryDigit = [01]
OctallDigit = [0-7]
DecimalDigit = [0-9]
HexDigit = [0-9a-f]

Rules.

0x{HexDigit}+ : {token, {integer, TokenLine, str_to_int(TokenChars, 16)}}.
0o{OctallDigit}+ : {token, {integer, TokenLine, str_to_int(TokenChars, 8)}}.
0b{BinaryDigit}+ : {token, {integer, TokenLine, str_to_int(TokenChars, 2)}}.
{DecimalDigit}+ : {token, {integer, TokenLine, list_to_integer(TokenChars)}}.
{DecimalDigit}+\.{DecimalDigit}+ : {token, {float, TokenLine, list_to_float(TokenChars)}}.
{DecimalDigit}\.{DecimalDigit}+e{DecimalDigit}+ : {token, {float, TokenLine, list_to_float(TokenChars)}}.
{Delim} : {token, {list_to_atom(TokenChars), TokenLine}}.
[\s\r\t\v\f\n]* : skip_token.

Erlang code.

str_to_int([$0, _ | Chars], Base) ->
    list_to_integer(Chars, Base).

