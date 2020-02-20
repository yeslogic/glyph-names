mod aglfn;

pub use aglfn::glyph_name;

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_glyph_name() {
        assert_eq!(glyph_name('a'), Some("a"));
        assert_eq!(glyph_name('%'), Some("percent"));
        assert_eq!(glyph_name('☺'), Some("smileface"));
        assert_eq!(glyph_name('↣'), None);
    }
}
