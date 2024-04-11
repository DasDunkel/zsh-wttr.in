#!/bin/zsh
weather(){

    WTTR_ARGS="${WTTR_DEFAULT_ARGS}A" # Force term output by default

    for i in "$@"; do # Process args
        case $i in
            -s|--simple) # Only print current weather
                WTTR_ARGS="${WTTR_ARGS}0"
                shift
            ;;
            -q|--quiet) # Quieter output
                WTTR_ARGS="${WTTR_ARGS}q"
                shift
            ;;
            -qq|--very-quiet) # Even quieter output
                WTTR_ARGS="${WTTR_ARGS}Q"
                shift
            ;;
            -r|--restricted) # Restrict output to standard console font glyphs
                WTTR_ARGS="${WTTR_ARGS}d"
                shift
            ;;
            -nf|--no-follow) # Disable the follow line at bottom of output
                WTTR_ARGS="${WTTR_ARGS}F"
                shift
            ;;
            -nc|--no-color) # Disable color sequences
                WTTR_ARGS="${WTTR_ARGS}T"
                shift
            ;;
            -n|--narrow) # Use narrow version (noon/night instead of morn/noon/eve/night)
                WTTR_ARGS="${WTTR_ARGS}n"
                shift
            ;;
            -h|--help)
                echo "<arg> |  <full>       | <ENV>"
                echo "  -s  | --simple      | 0 : Only print current weather"
                echo "  -q  | --quiet       | q : Quiet version (no "Weather report" text)"
                echo "  -qq | --very-quiet  | Q : Superquiet version (no 'Weather report'/city name)"
                echo "  -r  | --restricted  | d : Restrict output to standard console font glyphs"
                echo "  -nf | --no-follow   | F : Do not show the "Follow" line"
                echo "  -nc | --no-color    | T : Switch terminal sequences off (no colors)"
                echo "  -n  | --narrow      | n : Narrow version (only day and night)"
                return
            ;;
            -*|--*)
                echo "Unknown argument: $1"
                return
            ;;
            *)
            ;;
        esac
    done

    if [ ! -z "${1+x}" ] ; then # Location passed as arg
        LOCATION="${1}"
    elif [ -z "${1+x}" ] && [ ! -z "${WTTR_DEFAULT+x}" ] ; then # No location arg but default is set
        LOCATION="${WTTR_DEFAULT}"
    elif [ -z "${1+x}" ] && [ -z "${WTTR_DEFAULT+x}" ] ; then # No location at all, exit
        echo "No location specified in WTTR_DEFAULT or arguments"
        return
    fi

    curl -H "Accept-Language: ${LANG%_*}" "https://wttr.in/${LOCATION}?${WTTR_ARGS}"
    
}
