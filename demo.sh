build() {
    echo generating scanner from leex file...
    erl -noinput -s leex file demo_scanner.xrl -s init stop
    echo generating parser from yecc file...
    erl -noinput -s yecc file demo_parser.yrl -s init stop
    echo compiling erlang source files...
    erlc *.erl
}

run() {
    erl -noshell -s demo loop
}

clean() {
    rm -f *.beam demo_scanner.erl demo_parser.erl erl_crash.dump
}

case $1 in
    "build")
        build;;
    "run")
        run;;
    "clean")
        clean;;
    *)
        echo "usage: demo.sh build|run|clean"
esac

