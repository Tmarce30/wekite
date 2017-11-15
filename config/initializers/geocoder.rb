Geocoder.configure(
  timeout: 10,
  units: :km,

  lookup: :google,
  api_key: ENV['GOOGLE_API_SERVER_KEY'],
  use_https: true,

)
