#![deny(missing_docs)]

//! Map a character to a glyph name according to the
//! [Adobe Glyph List Specification](https://github.com/adobe-type-tools/agl-specification).
//!
//! ### Example
//! ```
//! use glyph_names::glyph_name;
//!
//! assert_eq!(glyph_name(37, 'a' as u32), "a");
//! assert_eq!(glyph_name(9, '%' as u32), "percent");
//! assert_eq!(glyph_name(999, '☺' as u32), "smileface");
//! assert_eq!(glyph_name(12, '↣' as u32), "uni21A3");
//! assert_eq!(&glyph_name(908, '🕴' as u32), "u1F574");
//! assert_eq!(&glyph_name(1, 0x110000), "g1");
//! ```

use std::borrow::Cow;
use std::convert::TryFrom;

/// Adobe Glyph List For New Fonts
mod aglfn;

/// Look up a glyph name for the supplied glyph id, char code pair.
pub fn glyph_name(gid: u16, ch: u32) -> Cow<'static, str> {
    char::try_from(ch)
        .ok()
        .map(|ch| {
            aglfn::glyph_name(ch)
                .map(Cow::from)
                .unwrap_or_else(|| Cow::from(unicode_glyph_name(ch)))
        })
        .unwrap_or_else(|| Cow::from(format!("g{}", gid)))
}

// It is recommended to specify names by using the ‘uni’ prefix for characters in the Basic
// Multilingual Plane (BMP), and the shorter ‘u’ prefix for characters in the 16 Supplemental
// Planes
// https://github.com/adobe-type-tools/agl-specification#6-assigning-glyph-names-in-new-fonts
fn unicode_glyph_name(ch: char) -> String {
    let ch = ch as u32;
    if ch <= 0xFFFF {
        // Basic Multilingual Plane
        format!("uni{:04X}", ch)
    } else {
        format!("u{:04X}", ch)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_unicode_glyph_name() {
        assert_eq!(&unicode_glyph_name('a'), "uni0061");
        assert_eq!(&unicode_glyph_name('↣'), "uni21A3");
        assert_eq!(&unicode_glyph_name('🕴'), "u1F574");
    }
}
