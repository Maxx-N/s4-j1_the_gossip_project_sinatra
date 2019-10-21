require 'gossip'

class ApplicationController < Sinatra::Base 

  get '/' do # requête qui dirige l'utilisateur vers la page d'accueil (fichier "index.erb") lors de la saisie de l'URL ("http://localhost:4567/") dans le navigateur
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do # requête qui dirige l'utilisateur vers la page de création de potins (fichier "new_gossip.erb") lors de la saisie de l'URL ("http://localhost:4567/gossips/new/") dans le navigateur
    erb :new_gossip
  end

  post '/gossips/new/' do # requête qui créé un potin en fonction du formulaire rempli par l'utilisateur
    Gossip.new(params["gossip_author"],params["gossip_content"]).save # chaque gossip créé est stocké dans la base de données grâce à la méthode d'instance "save" définie dans la classe "Gossip"
    redirect '/'
  end

  get '/gossips/:id' do # requête qui dirige l'utilisateur vers la page du potin (fichier "show.erb")portant le numéro de l'id lors de la saisie de l'URL ("http://localhost:4567/gossips/id") dans le navigateur
    puts "Voici le numéro du potin que tu veux : #{params['id']}!"
    puts Gossip.find(params['id'])
    erb :show, locals: {gossips: Gossip.all}
  end


end