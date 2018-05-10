# Weather API https://works.ioa.tw/weather/api/doc/index.html#api-Weather_API
class TaiwanWeatherService
  # attr_reader :first_key_word

  def initialize(key_words)
    @key_word = key_words[0]
  end

  def check_town_weather!
    @town = get_town_id!
    weather = get_town_weather!
    "[今日氣象] #{weather["desc"]}
     [當前溫度] #{weather["temperature"]}
     [體感溫度] #{weather["felt_air_temp"]}
     [當前濕度] #{weather["humidity"]}

     [更新時間] #{weather["at"]}
    "
  end

  def get_town_id!

    url = 'https://works.ioa.tw/weather/api/all.json'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    citys = JSON.parse(response)

    town_infos = nil

    citys.each do |city|
      city["towns"].each do |town|
        if town["name"] == @key_word
          town_infos = town
        end
      end
    end

    town_infos || "Not find"
  end

  def get_town_weather!
    url = "https://works.ioa.tw/weather/api/weathers/#{@town["id"]}.json"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    town_weather = JSON.parse(response)
  end
end
