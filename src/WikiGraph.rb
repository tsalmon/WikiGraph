require 'wikipedia'

def parser(article)
  link = article.scan(/\[\[[^\]]+\]\]/)
end

'
if(ARGV.length < 1) then
  puts "Need arguments <actor_1> [... <actor_n>]"
  exit
end
'

page = Wikipedia.find( 'Getting Things Done' )

parser(page.content)
