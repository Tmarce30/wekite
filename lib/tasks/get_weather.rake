task :get_weather => [:environment] do
  # date = Date.today
  spots = Spot.all

  spots.each do |spot|
    GetWeatherInfo.get_weather(spot.id)
  end
end
