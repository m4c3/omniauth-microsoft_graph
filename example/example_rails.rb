##config/initializers/omniauth.rb

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
provider :microsoft_graph,
    client_id: ENV['AZURE_CLIENT_ID'],
    client_secret: ENV['AZURE_CLIENT_SECRET'],
    tenant_id: ENV['AZURE_TENANT_ID'],
    extensions: ENV['AZURE_EXTENSIONS']
end
