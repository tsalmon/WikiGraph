require 'wikipedia'

def parser(article)
  link = []
  links = article.scan(/\[\[[^\]]+\]\]/)
  links.each do |value|
    if(not value =~ /\w+:/)
      link << (value[2..(value.size()-3)]).gsub(/\|.*/, '')
    end
  end
  link = link.uniq
  return link
end

'
if(ARGV.length < 1) then
  puts "Need arguments <actor_1> [... <actor_n>]"
  exit
end
'

page = Wikipedia.find( 'Getting Things Done' )

parser(page.content)

