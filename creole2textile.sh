#!/bin/sh
sed -r '
/^s*{{3}s*$/, /^s*}}}/{ # code block
s/^s*{{3}s*$//
s/^s*}}}s*$//
b # Do not process anything between {{{ and }}}
}
s/^s*={5} ([^=]*)(s+={5})?/h5. 1/ # heading 1
s/^s*={4} ([^=]*)(s+={4})?/h4. 1/ # heading 2
s/^s*={3} ([^=]*)(s+={3})?/h3. 1/ # heading 3
s/^s*={2} ([^=]*)(s+={2})?/h2. 1/ # heading 4
s/^s*={1} ([^=]*)(s+={1})?/h1. 1/ # heading 5
s/{{{/@/g; s/}}}/@/g; # inlined code
s,([^:])//,1_,g # italics whith URL escape
s,^//,_,g # italics
s/[[]{2}http:([^| ]+)|([^]]+)[]]{2}/"2":http:1/g # urls
' $1

