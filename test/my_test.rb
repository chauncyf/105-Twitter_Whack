ENV['APP_ENV'] = 'test'

require_relative '../app.rb'
require 'minitest/autorun'
require 'rack/test'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "GET /" do
  it "Should response" do
    get ''
    last_response.ok?
    assert_includes last_response.body, 'Welcome to Twitter Whack'
  end
end

describe "POST on /" do
  it "should redirect to result page" do
    post '/', {
        word1: 'hello',
        word2: 'world',
    }
    last_response.ok?
    assert last_response.redirect?
  end
end

describe "GET on /whack_result" do
  it "will response result with two words as parameter" do
    word1 = 'hello'
    word2 = 'world'
    get "/whack_result?word1=#{word1}&word2=#{word2}"
    last_response.ok?
    assert_includes last_response.body, 'Your words (hello and world) gave an index of 100 with a score of 10000.'
  end

  it "will get whack with 'Sinatra' and 'Hamster'" do
    word1 = 'Sinatra'
    word2 = 'Hamster'
    get "/whack_result?word1=#{word1}&word2=#{word2}"
    last_response.ok?
    assert_includes last_response.body, 'Congratulation, you got whacked!'
  end
end
