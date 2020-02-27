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
use std::borrow::Cow;
use glyph_names::glyph_name;

fn main() {
    assert_eq!(glyph_name('a' as u32), Some(Cow::from("a")));
    assert_eq!(glyph_name('%' as u32), Some(Cow::from("percent")));
    assert_eq!(glyph_name('☺' as u32), Some(Cow::from("smileface")));
    assert_eq!(glyph_name('↣' as u32), Some(Cow::from("uni21A3")));
    assert_eq!(glyph_name('🕴' as u32), Some(Cow::from("u1F574")));
    assert_eq!(glyph_name(0x110000), None);
}
```

Notes
-----

### Regenerating aglfn.rs

1. Ensure you have the agl-aglfn submodule checked out (`git submodule update --init`).
2. Run `make`.

[ucd-generate]: https://github.com/BurntSushi/ucd-generate
[agl-specification]: https://github.com/adobe-type-tools/agl-specification
