require 'wikipedia'
page = Wikipedia.find( 'Mark_Wahlberg#Filmography' )

re = /\={2}Filmography\={2}.*\={2}[ ]?\w*[ ]?\={2}/m
#puts re =~ page.content
puts page.content.match re
