#! /usr/bin/env bash

function test_vancouver_watching_ingest() {
    local options=$1

    local object_name="test_vancouver_watching_ingest_$(abcli_string_timestamp)"

    abcli_eval ,$options \
        vanwatch ingest \
        area=vancouver,count=3,~batch,$2 \
        $object_name \
        "${@:3}"

    abcli_publish \
        as=test_vancouver_watching_ingest,~download,suffix=.gif \
        $object_name
}
