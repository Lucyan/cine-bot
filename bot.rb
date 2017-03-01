require 'rest-client'
require 'json'
require 'mail'

puts "*"*100
puts "Cine bot"
puts "*"*100

pelicula = 'logan'
#pelicula = 'la-gran-muralla'

url = 'http://www.cinehoyts.cl/Sinopsis.aspx/ObtenerCarteleraConFecha'
headers = { content_type: :json, accept: :json }
payload = {
  ClavePelicula: pelicula,
  ClaveCiudad: 'santiago-oriente',
  EsVIP: false
}

response = RestClient.post(url, payload.to_json, headers)
response = JSON.parse(response)
carteleta = response['d']['CarteleraCiudad']['Complejos']


puts "*"*100
puts "cartelera count: #{carteleta.count}"
puts "*"*100


if carteleta.count > 0
  options = { :address              => "smtp.gmail.com",
              :port                 => 587,
              :user_name            => '',
              :password             => '',
              :authentication       => 'plain',
              :enable_starttls_auto => true  }
  
  Mail.defaults do
    delivery_method :smtp, options
  end

  Mail.deliver do
        to "leonardo311@gmail.com, bgonzalezjara@gmail.com"
      from "leonardo.olivares@gmail.com"
    subject "Cartelera #{pelicula} abierta!"
      body "Hurra!!! Ya está habilitada la cartelera de #{pelicula}!"
  end
end

puts "*"*100
puts "FIN PROCESO"
puts "*"*100