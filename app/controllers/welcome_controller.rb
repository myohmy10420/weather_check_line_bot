require 'line/bot'
class WelcomeController < ApplicationController
protect_from_forgery with: :null_session
  def webhook
    # Line Bot API 物件初始化
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV['line_channel_secret']
      config.channel_token = ENV['line_channel_token']
    }

    response_message = {
      type: "text",
      text: params["events"].first["message"]["text"]
    }

    client.reply_message(reply_token, response_message)
    head :ok
  end
end
