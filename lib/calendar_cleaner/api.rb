# frozen_string_literal: true

require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
APPLICATION_NAME = 'Calendar Cleaner'
CREDENTIALS_PATH = 'credentials.json'
# The file token.yaml stores the user's access and refresh tokens, and is
# created automatically when the authorization flow completes for the first
# time.
TOKEN_PATH = 'token.yaml'
SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR

module CalendarCleaner
  class Api
    attr_accessor :items

    def initialize(options)
      # Initialize the API
      @service = Google::Apis::CalendarV3::CalendarService.new
      @service.client_options.application_name = APPLICATION_NAME
      @service.authorization = authorize

      # Fetch the next 10 events for the user
      @calendar_id = options[:calendar]
      response = @service.list_events(@calendar_id,
                                      max_results: options[:limit],
                                      single_events: true,
                                      order_by: 'startTime',
                                      time_min: options[:start].iso8601,
                                      time_max: options[:end].iso8601)
      @items = response.items
    end

    ##
    # Ensure valid credentials, either by restoring from the saved credentials
    # files or intitiating an OAuth2 authorization. If authorization is required,
    # the user's default browser will be launched to approve the request.
    #
    # @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
    def authorize
      client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
      token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
      authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
      user_id = 'default'
      credentials = authorizer.get_credentials(user_id)
      if credentials.nil?
        url = authorizer.get_authorization_url(base_url: OOB_URI)
        puts 'Open the following URL in the browser and enter the ' \
            "resulting code after authorization:\n" + url
        code = gets
        credentials = authorizer.get_and_store_credentials_from_code(
          user_id: user_id, code: code, base_url: OOB_URI
        )
      end
      credentials
    end

    def update_event(event)
      @service.update_event(@calendar_id, event.id, event)
    end

    def delete_event(event)
      @service.delete_event(@calendar_id, event.id)
    end
  end
end
