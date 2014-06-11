require 'sinatra'
require 'json'
require 'titleize'
require 'httparty'
require_relative "lib/evecentral"

include EveCentral

before do
  content_type :txt
end

get '/hubs/:system' do
begin
  system = params[:system].to_s.titleize
  res = EveCentral::hub_distance(system)
  res.to_s
rescue JSON::ParserError
  return "Please enter a valid system"
rescue SocketError
  return "Unable to Connect to EveCentral"
end
end

