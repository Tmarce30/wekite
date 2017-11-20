require 'open-uri'

module GetWeatherInfo
  def self.get_weather(spot_id)
    spot = Spot.find(spot_id)

    url = "http://api.worldweatheronline.com/premium/v1/marine.ashx?key=#{ENV['WEATHER_API']}&q=#{spot.latitude},#{spot.longitude}&format=json"

    weather_serialized = open(url).read

    weather = JSON.parse(weather_serialized)
    # getting weather data for today at noon


    weather_forcast = []


    weather['data']['weather'].each do |forcast|
      # weather description
      weather_desc = forcast['hourly'][4]['weatherDesc'][0]['value']
      # air temperature
      air_temp = forcast['hourly'][4]['tempC']
      # windspeedKmph
      wind_speed = forcast['hourly'][4]['windspeedKmph']
      # winddir16Point
      wind_dir = forcast['hourly'][4]['winddir16Point']
      # water temperature
      water_temp = forcast['hourly'][4]['waterTemp_C']
      weather_forcast << {weather_desc: weather_desc, air_temp: air_temp, wind_speed: wind_speed, wind_dir: wind_dir, water_temp: water_temp}
    end
    binding.pry
  end
end


# Si j'ai un weather
        # alors j'update mon weather
      # Sinon
        # je crée mon weather
          # J'appelle la fonction weather qui me ramene le hash
          # Je creer l'objet weather
