require 'nokogiri'
require 'httparty'
require 'open-uri'

def get_townhall_urls
	page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))
   
    url_array = []
   
	urls = page.xpath('//*[@class="lientxt"]/@href')
	    urls.each do |url|
		url = "http://annuaire-des-mairies.com" + url.text[1..-1]
		url_array << url		
	    end
	return url_array 
end

#1# On va collecter l'email d'une mairie d'une ville du Val d'Oise
def get_townhall_email(townhall_url)
	page = Nokogiri::HTML(URI.open(townhall_url))
    
    email_array = []

    email = page.css('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
    town = page.css('/html/body/div/main/section[2]/div/table/tbody/tr[1]/td[1]').text.split #/ on divise la string pour pouvoir récupérer uniquement le nom de la ville

        email_array << {town[3] => email}
        puts email_array
        return email_array
end

#2# On va synchroniser les noms des villes et les emails des mairies
def data_sync
	url_array = get_townhall_urls 
	    url_array.each do |townhall_url|
		get_townhall_email(townhall_url)
	    end
end 
data_sync