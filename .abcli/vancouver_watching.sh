#! /usr/bin/env bash

function vanwatch() {
    vancouver_watching "$@"
}

function vancouver_watching() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ]; then
        vancouver_watching_conda "$@"
        vancouver_watching_discover "$@"
        vancouver_watching_ingest "$@"
        vancouver_watching_list "$@"
        vancouver_watching_openai_vision "$@"
        vancouver_watching_process "$@"
        vancouver_watching pylint "$@"
        vancouver_watching pytest "$@"
        vancouver_watching_update_cache "$@"
        vancouver_watching test "$@"

        $(abcli_keyword_is $2 verbose) &&
            python3 -m vancouver_watching --help
        return
    fi

    local function_name=vancouver_watching_$task
    if [[ $(type -t $function_name) == "function" ]]; then
        $function_name "${@:2}"
        return
    fi

    if [ "$task" == "init" ]; then
        abcli_init Vancouver_Watching "${@:2}"
        conda activate Vancouver-Watching
        return
    fi

    if [ "$task" == "pylint" ]; then
        if [[ "$2" == "help" ]]; then
            abcli_show_usage "vanwatch pylint <args>" \
                "pylint vancouver_watching."
            return
        fi

        abcli_pip install pylint

        pushd $abcli_path_git/vancouver-watching >/dev/null
        pylint \
            -d $abcli_pylint_ignored \
            $(git ls-files '*.py') \
            "${@:2}"
        popd >/dev/null

        return
    fi

    if [[ "|pytest|test|" == *"|$task|"* ]]; then
        abcli_${task} plugin=vancouver_watching,$2 \
            "${@:3}"
        return
    fi

    if [ "$task" == "version" ]; then
        python3 -m vancouver_watching version "${@:2}"
        return
    fi

    python3 -m vancouver_watching \
        "$task" \
        "${@:2}"
}

abcli_source_path \
    $abcli_path_git/vancouver-watching/.abcli/tests
