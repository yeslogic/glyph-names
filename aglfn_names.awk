# NOTE: This script must remain compatible with BSD awk and GNU awk

BEGIN {
  FS=";"
  print "/// A slice containing all glyph names. This can be used to do "
  print "/// reverse lookups/find out if a search term maps to a glyph."
  print "pub static GLYPH_NAME_PAIRS: &[(char, &str)] = &["
}

# /^[0-9A-F]{4};/ should work but FreeBSD awk as of 12.1 doesn't support {}
# https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=54410
/^[0-9A-F]+;/ { printf("%*c('\\u{%s}', \"%s\"),\n", 4, " ", $1, $2) }

END {
  print "];"
}
