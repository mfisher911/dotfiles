function urmcpw
    # -M - character sets
    #   S: must use symbols
    #   N: must use numeral
    #   C: must use capitals
    #   L: must use lower case
    # -m - minimum length
    # -x - maximum length
    # -E - excluded characters
    apg -M SNCL -m 8 -x 8 -E '@[]{}#%^*+=_\\|~<>'
end
