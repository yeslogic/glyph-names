//! Map a character to a glyph name.
//!
//! ### Example
//! ```
//! use glyph_names::glyph_name;
//!
//! assert_eq!(glyph_name('a'), Some("a"));
//! assert_eq!(glyph_name('%'), Some("percent"));
//! assert_eq!(glyph_name('☺'), Some("smileface"));
//! assert_eq!(glyph_name('↣'), None);
//! ```

mod aglfn;

pub use aglfn::glyph_name;
