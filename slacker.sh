#!/bin/sh
cat "$*" | \
sed '
/^\(March\|April\|May\|June\|July\|August\) [0-9]\+\(th\|nd\|st\|rd\):/ {
    s/^/@@@ 2017-/
    s/March/03/
    s/April/04/
    s/May/05/
    s/June/06/
    s/July/07/
    s/August/09/
    s/ \([0-9]\+\)\(th\|nd\|st\|rd\):/-\1/
}
/^@@@ .*/i\%%%
/^.\+ \[[0-9][0-9]:[0-9][0-9]\]/ {
    h
    s/^\(.\+\) \[.*/\1/
    x
    i\!!!
}
/^\[[0-9][0-9]:[0-9][0-9]\]/ {
    G
    s/\n/ /
    s/\(\[.\+\]\) \(.\+\)/\2 \1/
}
' | \
sed '
/^@@@ /,/^%%%$/ {
    /^@@@ / {
        s/^@@@ \(.*\)/\1/
        x
        d
    }
    /^.* \[[0-9][0-9]:[0-9][0-9]\]/ {
        G
        s/\n/ /
        s/\(.*\) \[\(.*\)\] \(.*\)/%%% \3 \2, \1, @@@/
    }
}
/^%%%$/d
' | \
sed -n '
/^%%%/,/^!!!$/ {
    /^%%%.*/ {
        s/^%%%//
        h
        d
    }
    /^[^!]\{3\}/ H
}
/^!!!$/ {
    g
    s/\n/\\n /g
    s/@@@\\n \(.*\)/"\1"/
    p
}
'
