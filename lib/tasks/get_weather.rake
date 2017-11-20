task :get_weather => [:environment] do
  # date = Date.today
  # Je parcours mes spots
      # Pour ce spot je cherche ou je créé les weathers
    GetWeatherInfo.get_weather(spot_id)

end
