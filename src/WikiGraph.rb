require 'open-uri'
require 'wikipedia'

def internet_connection?
  begin
    true if open("http://www.google.com/")
  rescue
    false
  end
end


#`links` is an array of [[links]] in the article `content`
# we remove alias of links (foo|bar -> get only foo)
# we don't get particulars links (like image, url out of wikipedia, etc)
def parser(content, name_article)
  if(content == nil)
    puts "article '#{name_article}' doesn't exist"
    exit
  end
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
  puts "Need arguments <actor_1> [... <actor_n>]"
  exit
else 
  if(internet_connection? == false)
    puts "Not connected"
    exit
  end 
end


common = parser(Wikipedia.find(ARGV[0]).content, ARGV[0])

ARGV[1..-1].each do |name|
  common = common & (parser(Wikipedia.find(name).content, name))
end

puts common
