# frozen_string_literal: true

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class MicrosoftGraph < OmniAuth::Strategies::OAuth2
      BASE_AZURE_URL = 'https://login.microsoftonline.com'

      option :scopes, %w[openid profile offline_access]
      option :name, :microsoft_graph
      option :tenant_provider, nil
      args [:tenant_provider]
      option :extensions, nil

      def client
        provider = if options.tenant_provider
                     options.tenant_provider.new(self)
                   else
                     options # if pass has to config, get mapped right on to options
                   end

        options.scope = provider.scopes.join(' ')
        options.client_id = provider.client_id
        options.client_secret = provider.client_secret
        options.tenant_id =
          provider.respond_to?(:tenant_id) ? provider.tenant_id : 'common'
        options.base_azure_url =
          provider.respond_to?(:base_azure_url) ? provider.base_azure_url : BASE_AZURE_URL

        if provider.respond_to?(:authorize_params)
          options.authorize_params = provider.authorize_params
        end
        if provider.respond_to?(:domain_hint) && provider.domain_hint
          options.authorize_params.domain_hint = provider.domain_hint
        end
        if defined? request && request.params['prompt']
          options.authorize_params.prompt = request.params['prompt']
        end
        options.client_options.authorize_url = "#{options.base_azure_url}/#{options.tenant_id}/oauth2/v2.0/authorize"
        options.client_options.token_url = "#{options.base_azure_url}/#{options.tenant_id}/oauth2/v2.0/token"
        super
      end

      option :authorize_options, %i[display score auth_type scope prompt login_hint domain_hint response_mode]

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
       Rails.logger.warn "extensions:" + options[:extensions]
        if option.extensions
         @extensions ||= access_token.get('https://graph.microsoft.com/v1.0/me?$select=' + options[:extensions]).parsed
         Rails.logger.warn "extensions:" + @extension
        end
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
