#!/bin/sh
sed -ze 's/\n/\\n/g' -e 'i\"' -e '$a\";' -i *.md
for x in $(ls *.md); do sed -e	'/markdown-content-replace =/r./a.md' template-md.html > $x.html; sed -e "s/date-timestamp/$(date +%F\ %R)/" -i $x.html; done
