Nonterminals expr op2 op23 op22 op21.
Terminals '(' ')' '+' '-' '*' '**' '/' integer float.
Rootsymbol expr.

expr -> op2 : '$1'.
expr -> integer : '$1'.
expr -> float : '$1'.
expr -> '(' expr ')' : '$2'.

op2 -> expr op21 expr : {token_sym('$2'), '$1', '$3'}.
op2 -> expr op23 expr : {token_sym('$2'), '$1', '$3'}.
op2 -> expr op22 expr : {token_sym('$2'), '$1', '$3'}.

Left 300 op23.
op23 -> '**' : '$1'.

Left 200 op22.
op22 -> '*' : '$1'.
op22 -> '/' : '$1'.

Left 100 op21.
op21 -> '+' : '$1'.
op21 -> '-' : '$1'.

Erlang code.
token_sym({Sym, _}) -> Sym.

