#!/bin/bash
usage="$(basename "$0") ls|enable <file>|disable <file>|help"
function usage () {
    printf "$usage\n" >&2
    exit 64
}
function nofile () {
    printf "\e[31mFile does not exist\n" >&2
    exit 0
}
function notenabled () {
    printf "\e[31mFile is not enabled\n" >&2
    exit 0
}
case "$1" in
    "ls")
    Enbl=()
    for file_enabled in ./sites-enabled/*; do
        if [[ -L "${file_enabled}" ]]; then
            Enbl+=(basename "$file_enabled")
        fi
    done
    for file_available in ./sites-available/*; do
        if [[ -f $file_available ]]; then
            name=$(basename "$file_available")
            if [[ "${Enbl[@]}" =~ "${name}" ]]; then
                printf "\e[32m"
            else
                printf "\e[31m"
            fi
            printf "$name\n"
        fi
    done
    ;;
    "enable")
        if [ $# -lt 2 ]; then
            usage
        fi
        printf "Enabling $2\n"
        if [ ! -f "./sites-available/$2" ]; then
            nofile
        fi
        ln -s "$PWD/sites-available/$2" "$PWD/sites-enabled/$2" 
        if [ $? -eq 0 ]; then
            printf "\e[32m$2 enabled successfully!\n"
        else
            printf "\e[31mSymlink error code $? returned"
        fi
    ;;
    "disable")
        if [ $# -lt 2 ]; then
            usage
        fi
        printf "Disabling $2\n"
        if [ ! -f "./sites-enabled/$2" ]; then
            notenabled
        fi
        rm "./sites-enabled/$2"
        if [ $? -eq 0 ]; then
            printf "\e[32m$2 disabled successfully!\n"
        else
            printf "\e[31mRM error code $? returned"
        fi
    ;;
    "help"|*)
        usage
    ;;
esac

