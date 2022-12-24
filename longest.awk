BEGIN {
  FS=";"
}

/^[0-9A-F]+;/ { maxglyphname=length($2) > maxglyphname ? length($2) : maxglyphname; }

END {
  print maxglyphname
}
