require 'rubygems'
require 'nokogiri'
require 'open-uri'

    doc = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))

    puts doc.css('.iFAJnj').text
    name = doc.css('.fjclfm .cmc-link').children.map{|x| x.text}.compact
    price = doc.css('.price___3rj7O a.cmc-link').children.map{|y| y.text}.compact

    hash = Hash[name.zip(price)]
    my_hash = hash.each{|x, y| y[0]=""}
    puts my_hash