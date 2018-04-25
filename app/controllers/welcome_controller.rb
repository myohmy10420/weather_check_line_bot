class WelcomeController < ApplicationController
protect_from_forgery with: :null_session
  def webhook
    # # Line Bot API 物件初始化
    # client = Line::Bot::Client.new { |config|
    #   config.channel_secret = ENV['line_channel_secret']
    #   config.channel_token = ENV['line_channel_token']
    # }

    head :ok
  end
end
