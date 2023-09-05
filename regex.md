# Regex

- Basic alphanumerics: Delimit with front slash `/`.
  - Concatenates all characters between the front slashes.
  - For example; `/abc/`
- Prepend a back slash `\` to special characters or meta characters.
  - They are; `$ ^ * + ? . ( ) [ ] { } | \ /`
  - For example; `/\?/`
- To match one of several sub patterns use alternation.
  - To do so write two or more patterns separated by pipe `|` and delimit with `()`.
  - For example; `/(cat|dog|rabbit)/`
- A few control characters require back slash `\` too. They are `\n`, `\r`, `\t`.
- To ignore case append `i` after the close `/`. The `i` is called an option, a flag or a modifier.
- For a set of characters delimit the charcters with `[]`.
  - For example; `/[abc]/` searches for 'a', 'b', or 'c' individually.
  - You can also concatenate character classes. For example; `/[abc][123]/` searches for all combinations of the two classes.
  - Inside character classes only the following are meta characters; `^ \ - [ ]`
  - You can also include range of characters using a `-` between the start and end characters. For example; `/[a-z0-9]/`
  - Caret `^` can be used a non-meta character if it is not the frist character in the class, `-` if it is the first character in the class.
  - You can negate characters by prepending `^` (caret) to the characters you want to negate. Example; `/[^aeiou]/`
- `.` meta-character represent any character. `.` within `[]` becomes a literal.
- `\s` represents whitespace character, and `\S` represents non-white space characters.
  - Whitespace characters are; space (' '), tab ('\t'), vertical tab ('\v'), carriage return ('\r'), line feed ('\n'), and form feed ('\f')
- `\d` matches any digits, and `\D` matches any non-digit.
- `\w` matches all alphanumeric characters, and unscore (`_`), `\W` matches all other characters.

**Anchors** - `^` and `$` meta-characters are anchors.

- `^` at the begining of a pattern matches it to a begining of a new line.
- `$` at the end of a pattern matches it to the end of a new line.
- `\A` anchor matches regex at the begining of the string.
- `\z` and `\Z` anchors match regex at the end of the string.
  - `\Z` matches upto but not including the the new line at the end of the stirng.
- `\b` matches regex to word boundaries and `\B` to non-word boundaries.
