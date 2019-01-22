#Ajout des requires
require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib/app/", __FILE__)
require 'scrapper'

#Création d'une instance de la classe Scrapper
scrapper = Scrapper.new

#Ajout des informations dans le fichier 'emails.json' situé dans 'db'
def save_as_JSON(hash)
  File.open("db/emails.json","w")do |f|
    f.write(hash.to_json)
  end
end 

#Ajout des informations dans le fichier 'emails.json' situé dans 'db'
def save_as_spreedsheet(hash)
  #Lancement de la session google sheet avec les bonnes api situé dans le fichier 'config.json'.
  session = GoogleDrive::Session.from_config("config.json")
  #Enregistrement dans le google doc 'https://docs.google.com/spreadsheets/d/1FddAlbGQaHc8tc1HEXQr0lnVlJRehIy8DQ10uLWGjC4/edit#gid=0'
  ws = session.spreadsheet_by_key("1FddAlbGQaHc8tc1HEXQr0lnVlJRehIy8DQ10uLWGjC4").worksheets[0]

  #Ajout des titres
  array_city_town = hash
  ws[1, 1] = "Villes"
  ws[1, 2] = "Emails"
  row = 3

  #Boucles pour joindre Villes => keys | Emails => values
  array_city_town.each do |f| 
  ws[row, 1] = f.keys.join
  ws[row, 2] = f.values.join
  row += 1
  end

  #Obligatoire
  ws.save
  ws.reload
end


#Ajout des informations dans le fichier 'emails.csv' situé dans 'db'
def save_as_csv(hash)
  array_city_town = hash

  CSV.open("db/emails.csv", "w") do |csv|
    JSON.parse(File.open("db/emails.json").read).each do |hash|
      csv << hash.values
    end
  end
  
end   


#Lancement du script
save_as_JSON(scrapper.get_townhall_urls)
save_as_spreedsheet(scrapper.get_townhall_urls)

#Semi-fonctionnel
save_as_csv(scrapper.get_townhall_urls)