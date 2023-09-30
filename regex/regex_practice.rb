# Matching strings
fetch_url(text) if text.match(/\Ahttps?:\/\/\S+\z/)
fetch_url(text) if text.match?(/\Ahttps?:\/\/\S+\z/)

# I think we can simply use `#match?` here given
# we only require a boolean return value for the
# if statement to work.

# Splitting strings
record = "xyzzy  3456  \t  334\t\t\tabc" # `\t` here is a whitespace char
fields = record.split(/\s+/)
# -> ['xyzzy', '3456', '334', 'abc']

# Capture group
/(['"]).+?\1/ 
# This sequence is called backreference, it 
# references the first group in the sequence.

# Can also use
if text.match(/".*?"/) || text.match(/'.*?'/)
  puts "Got a quoted string"
end

# Transformations
text = %(We read "War of the Worlds".)
puts text.sub(/(['"]).+\1/, '\1The Time Machine\1')
# prints: We read "The Time Machine".

# To mask an email ID
def mask_email(email)
  parts = email.split('@')
  username = parts[0][0, 2] + parts[0][2..-1].gsub(/./, '*')
  "#{username}@#{parts[1]}"
end

# Example usage:
email = "john.doe@example.com"
puts mask_email(email)
