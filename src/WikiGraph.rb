require 'wikipedia'

#`links` is an array of [[links]] in the article `content`
# we remove alias of links (foo|bar -> get only foo)
# we don't get particulars links (like image, url out of wikipedia, etc)
def parser(content)
  link = []
  links = content.scan(/\[\[[^\]]+\]\]/)
  links.each do |value|
    if(not value =~ /\w+:/)
      link << (value[2..(value.size()-3)]).gsub(/\|.*/, '')
    end
  end
  link = link.uniq
  return link
end

if(ARGV.length < 1) then
  puts "Need arguments <article_1> [... <article_n>]"
  exit
end

common = parser(Wikipedia.find(ARGV[0]).content)

ARGV[1..-1].each do |nom|
  common = common & (parser(Wikipedia.find(nom).content))
end

puts common

