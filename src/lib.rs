#![deny(missing_docs)]
#![no_std]

//! Map a character to a glyph name according to the
//! [Adobe Glyph List Specification](https://github.com/adobe-type-tools/agl-specification).
//!
//! ### Example
//! ```
//! use std::borrow::Cow;
//! use glyph_names::glyph_name;
//!
//! assert_eq!(glyph_name('a' as u32), Some(Cow::from("a")));
//! assert_eq!(glyph_name('%' as u32), Some(Cow::from("percent")));
//! assert_eq!(glyph_name('☺' as u32), Some(Cow::from("smileface")));
//! assert_eq!(glyph_name('↣' as u32), Some(Cow::from("uni21A3")));
//! assert_eq!(glyph_name('🕴' as u32), Some(Cow::from("u1F574")));
//! assert_eq!(glyph_name(0x110000), None);
//! ```

#[macro_use(format)]
extern crate alloc;

use alloc::borrow::Cow;
use alloc::string::String;
use core::convert::TryFrom;

/// Adobe Glyph List For New Fonts
mod aglfn;
mod aglfn_names;
pub use aglfn_names::GLYPH_NAME_PAIRS;

/// Look up a glyph name for the supplied glyph id, char code pair.
pub fn glyph_name(ch: u32) -> Option<Cow<'static, str>> {
    char::try_from(ch).ok().map(|ch| {
        aglfn::glyph_name(ch)
            .map(Cow::from)
            .unwrap_or_else(|| Cow::from(unicode_glyph_name(ch)))
    })
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
