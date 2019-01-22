require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'pry'
require 'rb-readline'
require 'google_drive'

#Création de la class Scrapper
class Scrapper

  #Récuperation du programme de mairie et utilisation de la database dans 'app.rb'
  def get_townhall_email(townhall_url)
    name_of_city = "/html/body/div/main/section[1]/div/div/div/h1"
    mairie = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{townhall_url}"))
  
  
      name = []
      email = []

  
      name.push(mairie.css(name_of_city).text)
      email.push(mairie.css('tr.txt-primary.tr-last td')[7].text)
      hash = Hash[name.zip(email)]
      #ADDED
      return hash
      ##FIN ADDED
    end
  
  def get_townhall_urls
    array = []
    array_city_town = []
    mairie = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  
    mairie.css('a.lientxt').map do |val|
      array.push(val['href'][2..-1])
    end
    #MODIFIED
    array.each do |url|
      array_city_town << get_townhall_email(url)
    end
    return array_city_town
    ##FIN MODIFIED
  end

  

end

#binding.pry