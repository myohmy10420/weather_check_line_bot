# Weather API https://works.ioa.tw/weather/api/doc/index.html#api-Weather_API
class TaiwanWeatherService

  def initialize(key_words)
    @key_word = key_words[0]
  end

  def check_town_weather!
    @town = get_town_infos!

    weather_infos = get_town_weather!
"[今日氣象] #{weather_infos["desc"]}
[當前溫度] #{weather_infos["temperature"]}
[體感溫度] #{weather_infos["felt_air_temp"]}
[當前濕度] #{weather_infos["humidity"]}

[更新時間] #{weather_infos["at"]}
"
  end

  private

  def get_town_infos!

    url = 'https://works.ioa.tw/weather/api/all.json'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    citys = JSON.parse(response)

    town_infos = nil

    town_infos = citys.find { |city|
      city["towns"].find { |town| town["name"] == @key_word }
    }

    town_infos || "Not find"
  end

  def get_town_weather!
    url = "https://works.ioa.tw/weather/api/weathers/#{@town["id"]}.json"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    town_weather = JSON.parse(response)
  end
end
