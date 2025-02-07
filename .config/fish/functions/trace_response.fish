function trace_response
    argparse v/verbose -- $argv
    if set -ql _flag_verbose
        curl --insecure --verbose --location --silent -D - -o /dev/null $argv
    else
        curl --insecure --location --silent -D - -o /dev/null $argv
    end
end
