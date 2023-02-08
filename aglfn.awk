# NOTE: This script must remain compatible with BSD awk and GNU awk

BEGIN {
  FS=";"
  count=0
  print "use crate::GLYPH_NAME_PAIRS;" > "src/aglfn.rs"
  print "pub fn glyph_name(c: char) -> Option<&'static str> {" > "src/aglfn.rs"
  print "    match c as u32 {" > "src/aglfn.rs"

  print "/// A slice containing all glyph names." > "src/aglfn_names.rs"
  print "///" > "src/aglfn_names.rs"
  print "/// This can be used to do reverse lookups/find out if a search term maps to a glyph." > "src/aglfn_names.rs"
  print "///" > "src/aglfn_names.rs"
  print "/// **Note:** Only named glyphs are present in this slice, names like uniABCD and uABCDEF are" > "src/aglfn_names.rs"
  print "/// omitted." > "src/aglfn_names.rs"
  print "pub static GLYPH_NAME_PAIRS: &[(char, &str)] = &[" > "src/aglfn_names.rs"
}

/^[0-9A-F]{4};/ {
  if (length($1) != 0) {
    printf("%*c0x%s => Some(GLYPH_NAME_PAIRS[%s].1), // %s\n", 8, " ", $1, count, $3) > "src/aglfn.rs"
    printf("%*c('\\u{%s}', \"%s\"),\n", 4, " ", $1, $2) > "src/aglfn_names.rs"
    count++
  }
}

END {
  print "        _ => None," > "src/aglfn.rs"
  print "    }" > "src/aglfn.rs"
  print "}" > "src/aglfn.rs"

  print "];" > "src/aglfn_names.rs"
}
