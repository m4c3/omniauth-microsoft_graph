# frozen_string_literal: true

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class MicrosoftGraph < OmniAuth::Strategies::OAuth2
      BASE_AZURE_URL = 'https://login.microsoftonline.com'

      option :name, :microsoft_graph
      option :client_id
      option :client_secret
      option :tenant_id, 'common'
      option :scopes, 'openid profile offline_access'
      option :extensions, nil
      option :authorize_options, %i[display score auth_type scope prompt login_hint domain_hint response_mode]



      def client
        options.scope = option.scope
        options.base_azure_url = BASE_AZURE_URL

        options.client_options.authorize_url = "#{options.base_azure_url}/#{options.tenant_id}/oauth2/v2.0/authorize"
        options.client_options.token_url = "#{options.base_azure_url}/#{options.tenant_id}/oauth2/v2.0/token"
        super
      end

      uid { raw_info['id'] }

      info do
        {
          'email' => raw_info['mail'],
          'first_name' => raw_info['givenName'],
          'last_name' => raw_info['surname'],
          'name' => [raw_info['givenName'], raw_info['surname']].join(' '),
          'nickname' => raw_info['displayName']
        }
      end

      extra do
        {
          'raw_info' => raw_info,
          'memberships' => memberships,
          'extensions' => extensions,
          'params' => access_token.params
        }
      end

      def raw_info
        @raw_info ||= access_token.get('https://graph.microsoft.com/v1.0/me').parsed
      end

      def memberships
        @memberships ||= access_token.get('https://graph.microsoft.com/v1.0/me/memberOf?$select=displayName').parsed
      end
      def extensions
        if option.extensions
         Rails.logger.warn "extensions:" + option.extensions
         @extensions ||= access_token.get('https://graph.microsoft.com/v1.0/me?$select=' + option.extensions).parsed
         Rails.logger.warn "extensions:" + @extension
        end
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
