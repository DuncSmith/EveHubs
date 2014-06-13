require 'sinatra'
require 'json'
require 'titleize'
require 'httparty'
require_relative "lib/evecentral"

include EveCentral

set :bind, '0.0.0.0'
set :port, '4567'

before do
  
end

get '/api/hubs/:system' do
  content_type :txt
  @jumps = fetch_jumps(params[:system].to_s).to_json
end

get '/hubs/:system' do
  content_type :html
  @jumps = fetch_jumps(params[:system].to_s)
  erb :index
end