# NOTE: This script must remain compatible with BSD awk and GNU awk

BEGIN {
  FS=";"
  print "pub fn glyph_name(c: char) -> Option<&'static str> {"
  print "    match c as u32 {"
}

# /^[0-9A-F]{4};/ should work but FreeBSD awk as of 12.1 doesn't support {}
# https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=54410
/^[0-9A-F]+;/ { printf("%8c0x%s => Some(\"%s\"), %"maxglyphname-length($2)"s%s\n", " ", $1, $2, "", "// "$3) }

END {
  print "        _ => None,"
  print "    }"
  print "}"
}
