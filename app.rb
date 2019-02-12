require 'sinatra'
require_relative 'TwitterClient'
require_relative 'helper'

get '/' do
  erb :home
end

post '/' do
  word1 = params[:word1]
  word2 = params[:word2]

  redirect "/whack_result?word1=#{word1}&word2=#{word2}"
end

get '/whack_result' do
  twitter_client = TwitterClient.new
  result1 = twitter_client.search(params['word1'])
  result2 = twitter_client.search(params['word2'])
  result3 = twitter_client.search(params['word1'] + ' ' + params['word2'])

  score = result1.size * result2.size
  index = result3.size
  tweet = result3.sample
  comment = parse_score(index)

  erb :whack_result, locals: {score: score, index: index, tweet: tweet, comment: comment, word1: params['word1'], word2: params['word2']}
end