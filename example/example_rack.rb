$:.push File.dirname(__FILE__) + '/../lib'

require 'microsoft_graph'
require 'sinatra'
require 'json'

set :port, 4200

client_id = ENV['AZURE_CLIENT_ID']
secret = ENV['AZURE_CLIENT_SECRET']
tenant_id = ENV['AZURE_TENNAND_ID']
extensions = ENV['AZURE_EXTENSIONS']

use Rack::Session::Cookie
use OmniAuth::Builder do
  provider :microsoft_graph, {client_id, secret, tenant_id}
end

get '/' do
  "<a href='/auth/microsoft_graph'>Log in with Microsoft</a>"
end

get '/auth/microsoft_graph/callback' do
  content_type 'text/plain'
  request.env['omniauth.auth'].to_json
end

get '/auth/failure' do
  content_type 'text/plain'
  params.to_json
end
