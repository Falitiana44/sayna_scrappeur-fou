require 'open-uri'
require 'nokogiri'

def deputer_email(url,nom)
	email_tab = []
	compteur = 0
	compteur2 = 0
	deputes = Hash.new
	url.each{|x|
		doc2 = Nokogiri::HTML(open(x))
		email_tab[compteur] =  doc2.css('dl.vcard.dep-fiche  dd:nth-child(4) > a:nth-child(1)')
		deputes[nom[compteur2]] = email_tab[compteur].text
		puts deputes 
		compteur += 1
		compteur2 += 1
    }
end

def depute_url
	depute_tab = []
	nom_tab = []
	compteur = 0
	compteur2 = 0
	deputes = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
	deputes.css('div#deputes-list ul  li  a').each do |depute_name|
		depute_tab[compteur] = "http://www2.assemblee-nationale.fr#{depute_name['href']}"
		compteur += 1
	end	
	deputes.css('div#deputes-list ul  li  a').each do |depute_name|
		nom_tab[compteur2] = depute_name.text
		compteur2 += 1
	end	
	deputer_email(depute_tab,nom_tab)
end

depute_url