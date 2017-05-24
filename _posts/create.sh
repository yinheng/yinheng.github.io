
dd=$( date -u +%C%y-%m-%d-)
name=${dd}${1}".markdown"
echo Using name: $name
cp yyyy-mm-dd-TEMPLATE.markdown $name
vim $name
