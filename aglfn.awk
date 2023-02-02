# NOTE: This script must remain compatible with BSD awk and GNU awk

BEGIN {
  count=0;
  FS=";"
  print "use crate::GLYPH_NAME_PAIRS;"
  print "pub fn glyph_name(c: char) -> Option<&'static str> {"
  print "    match c as u32 {"
}

# /^[0-9A-F]{4};/ should work but FreeBSD awk as of 12.1 doesn't support {}
# https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=54410
/^[0-9A-F]+;/ { if (length($1) != 0) { printf("%*c0x%s => Some(GLYPH_NAME_PAIRS[%s].1), // %s\n", 8, " ", $1, count, $3); count++ } }

END {
  print "        _ => None,"
  print "    }"
  print "}"
}
