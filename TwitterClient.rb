require 'twitter'

class TwitterClient
  attr_reader :client

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = "9cSCqWNqZudbOgp5UpuAse75v"
      config.consumer_secret = "0pirJ4B1eAsWK2QsVCVpNq2zIuC4zeRJyHZkgFlqzIGHWkcebd"
    end
  end

  def search(keyword)
    @client.search(keyword, result_type: "recent").take(100)
  end
end
