#!/bin/bash

function usage {
    >&2 echo "$0: create a GA4GH repo given a root directory of PROFYLE metadata"
    >&2 echo "Usage: $0 /path/to/profile/rootdir /path/to/output/directory"
}

function create_repo {
    local profyle_dir=$1
    local output_dir=$2
    local REPO=${output_dir}/ga4gh-example-data/registry.db

    if [[ ! -d "$profyle_dir" ]]
    then
        >&2 echo "PROFYLE root directory $profyle_dir not found."
        usage
        return 1
    fi
    if [[ ! -d "$output_dir" ]]
    then
        >&2 echo "Output directory $output_dir  not found."
        usage
        return 1
    fi

    mkdir "$output_dir"/ga4gh-example-data

    if [[ -f "$REPO" ]] 
    then
        rm -f "$REPO"
    fi

    cd "$output_dir" || exit
    PROFYLE_ingest "$REPO" "$profyle_dir"
    ga4gh_repo verify "$REPO"
}

function main {
    local indir=$1
    local outdir=$2

    if [[ -z "${indir}" ]] || [[ -z "${outdir}" ]]
    then
        usage
        echo " Missing arguments"
        exit 1
    fi
    
    create_repo "$indir" "$outdir"
}

main "$@"
