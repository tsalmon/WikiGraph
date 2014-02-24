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
require 'Set'

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

#string to int
#call by: main
#back: any
#give: int or nil
def log_and()
  common = parser(Wikipedia.find(ARGV[0]).content, ARGV[0])
  ARGV[1..-1].each do |name|
   common = common & (parser(Wikipedia.find(name).content, name))
  end
  return common
end

def log_or()
  common = parser(Wikipedia.find(ARGV[0]).content, ARGV[0])
  ARGV[1..-1].each do |name|
   common = common | (parser(Wikipedia.find(name).content, name))
  end
  return common
end

def log_xor()
  common = Set.new(parser(Wikipedia.find(ARGV[0]).content, ARGV[0]))
  ARGV[1..-1].each do |name|
   common = common ^ Set.new(parser(Wikipedia.find(name).content, name))
  end
  return common.to_a
end


def wikigraph()

  puts common
end



# code operator
# 1 : or
# 2 : and
# 3 : xor
########
# op can be a leaf(and so f1, f2 are nils both)
# or op is operator, and so f1, f2 are formula both
class Formula 
  attr :f1, :f2, :op
  def initialize(op, f1=nil, f2=nil)
    @op = op
    @f1 = f1
    @f2 = f2
  end 

  def eval()
    if(@f1 == nil)
      return parser(Wikipedia.find(@op).content, @op)
    else      
      case @op
        when 1 then
          return (@f1.eval() | @f2.eval())
        when 2 then
          return (@f1.eval() & @f2.eval())
        when 3 then 
          return (Set.new(@f1.eval()) ^ Set.new(@f2.eval)).to_a
        else 
          puts "unknow symbole"
          exit
      end
    end    
  end 

  #just for see the expression
  def getS()
    case @op
      when 1 then
        return "|"
      when 2 then
        return "&"
      when 3 then
        return "^"
      else return "???"
    end
  end

  def inspect()
    if(@f1 == nil)
      return @op
    else      
      return "(#{@f1.inspect()} #{getS()} #{@f2.inspect()})"
    end
  end
end


#string to int
#call by: main
#back: any
#give: int or nil
def sti(x)
  begin
    return Integer(x)
  rescue
    return nil
  end
end

#------MAIN---------------------------------------------------------------

if(ARGV.length < 1)
 puts "Need arguments <actor_1> [... <actor_n>]"
 exit
end

def parser_formula(start_arg_article)
end

#sample:
#f = Formula.new(1, Formula.new(2, Formula.new("Nantes"), Formula.new("Rennes")), Formula.new("Paris"))
#print f.eval()
#puts 