require 'open-uri'

def internet_connection?
  begin
    true if open("http://www.google.com/")
  rescue
    false
  end
end

#if(internet_connection? == false)
#    puts "Not connected"
#    exit
#end

require 'wikipedia'


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

def wikigraph(t)
  common = parser(Wikipedia.find(t[0]).content, ARGV[0])

  t[1..-1].each do |name|
   common = common & (parser(Wikipedia.find(name).content, name))
  end

  puts common
end

def sti(x)
  begin
    return Integer(x)
  rescue
    return nil
  end
end

def arguments()
  if(ARGV.length < 1)
   puts "Need arguments <actor_1> [... <actor_n>]"
   exit
  end

  r_arg = ARGV[0] =~ /^-[^r]*r[^r]*$/
  p_arg = ARGV[0] =~ /^-[^p]*p[^p]*$/

  n = sti(ARGV[1])

  if(ARGV[0] =~/[^rp]/)
    puts "unknow arguments"
  elsif((ARGV.length < 3 and r_arg != nil) or (r_arg != nil and n == nil))
    puts("bad arg: -r")
  elsif(ARGV.length < 2 and p_arg != nil)
    puts "bad arguments: -p"
  else
    puts "arguments ok"
  end
end 

arguments()