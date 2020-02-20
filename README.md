glyph-names
===========

<div align="center">
  <a href="https://docs.rs/glyph-names">
    <img src="https://docs.rs/glyph-names/badge.svg" alt="Documentation">
  </a>
  <a href="https://crates.io/crates/glyph-names">
    <img src="https://img.shields.io/crates/v/glyph-names.svg" alt="Version">
  </a>
  <a href="https://github.com/yeslogic/glyph-names/blob/master/LICENSE">
    <img src="https://img.shields.io/crates/l/glyph-names.svg" alt="License">
  </a>
</div>

<br>

Mapping of characters to glyph names according to the [Adobe Glyph List
Specification][agl-specification].

Usage
-----

```rust
use glyph_names::glyph_name;

fn main() {
    assert_eq!(glyph_name(37, 'a' as u32), "a");
    assert_eq!(glyph_name(9, '%' as u32), "percent");
    assert_eq!(glyph_name(999, '☺' as u32), "smileface");
    assert_eq!(glyph_name(12, '↣' as u32), "uni21A3");
    assert_eq!(&glyph_name(908, '🕴' as u32), "u1F574");
    assert_eq!(&glyph_name(1, 0x110000), "g1");
}
```

Notes
-----

### Regenerating aglfn.rs

1. Ensure you have the agl-aglfn submodule checked out (`git submodule update --init`).
2. Run `make`.

[ucd-generate]: https://github.com/BurntSushi/ucd-generate
[agl-specification]: https://github.com/adobe-type-tools/agl-specification
