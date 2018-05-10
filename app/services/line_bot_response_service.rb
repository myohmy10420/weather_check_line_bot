class LineBotResponseService
  attr_reader :reply_token

  def initialize(params)
    @params = params
    @reply_token = params['events'][0]['replyToken']

    @message_type = params['events'][0]["message"]["type"].downcase
    @message_text = params['events'][0]["message"]["text"].downcase

  end

  def response!
    message = ""

    if trigger_response?
      key_words = @message_text.remove("天氣").strip.split(' ')
      message = response_by_key_word(key_words) if key_words.present?
    end

    return nil if message.blank?

    response_message(message)
  end

  private

  def trigger_response?
    @message_type == "text" && @message_text.start_with?("天氣")
  end

  def response_message(message)
    {
      type: "text",
      text: message
    }
  end

  def response_by_key_word(key_words)
    TaiwanWeatherService.new(key_words).check_town_weather!
  end
end
