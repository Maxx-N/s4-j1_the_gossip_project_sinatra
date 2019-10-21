require 'csv'

class Gossip   # classe "Model" qui va récupérer ou stocker des informations auprès de la base de données (contenue dans le fichier db/gossip.csv)
  attr_accessor :author, :content

  def initialize(author, content) # une instance (un gossip) est initiée avec deux attributs : son auteur et son contenu
    @author = author
    @content = content
  end

  def save # chaque instance créée est stockée dans la base de données. Cette méthode est appelée par la requête "post" dans le fichier "controller.rb"
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [author, content]
    end
  end

  def self.all # chaque élément de la base de données (ou gossip) est stocké un par un dans l'array "all_gossips", ce qui permet de l'identifier par un index (sa position dans l'array)
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find(id) # en appelant cette méthode avec un id comme argument, on peut retrouver un gossip grâce à son index (position dans l'array)
    all_gossips = self.all
    return all_gossips[id.to_i - 1] # les index commençant par 0 et non par un, on recherche l'index un rang en dessous de la position réelle (celle que l'on veut afficher)
  end

end