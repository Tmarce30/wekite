require 'open-uri'

module GetWeatherInfo
  def self.get_weather(latitude, longitude)
    url = "http://api.worldweatheronline.com/premium/v1/marine.ashx?key=#{ENV['WEATHER_API']}&q=#{latitude},#{longitude}&format=json"
      weather_serialized = open(url).read
            binding.pry

      weather = JSON.parse(weather_serialized)
      # getting weather data for today at noon

      # weather description
      weather_desc = weather['data']['weather'].first['hourly'][4]['weatherDesc'][0]['value']
      # air temperature
      air_temp = weather['data']['weather'].first['hourly'][4]['tempC']
      # windspeedKmph
      wind_speed = weather['data']['weather'].first['hourly'][4]['windspeedKmph']
      # winddir16Point
      wind_dir = weather['data']['weather'].first['hourly'][4]['winddir16Point']
      # water temperature
      water_temp = weather['data']['weather'].first['hourly'][4]['waterTemp_C']

      hash = {weather_desc: weather_desc, air_temp: air_temp, wind_speed: wind_speed, wind_dir: wind_dir, water_temp: water_temp}
  end
end
