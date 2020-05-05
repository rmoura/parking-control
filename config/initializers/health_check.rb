# frozen_string_literal: true

HealthCheck.setup do |config|
  # uri prefix (no leading slash)
  config.uri = 'status'

  # Text output upon success
  config.success = 'OK'

  # Timeout in seconds used when checking smtp server
  config.smtp_timeout = 5.0

  # http status code used when plain text error message is output
  # Set to 200 if you want your want to distinguish between partial
  # (text does not include success) and total failure of rails
  # application (http status of 500 etc)

  config.http_status_for_error_text = 500

  # http status code used when an error object is output (json or xml)
  # Set to 200 if you want your want to distinguish between partial
  # (healthy property == false) and total failure of rails
  # application (http status of 500 etc)

  config.http_status_for_error_object = 500

  # You can customize which checks happen on a standard health check,
  # eg to set an explicit list use:
  # config.standard_checks = %w[database migrations]

  # Or to exclude one check:
  # config.standard_checks -= %w[emailconf]

  # You can set what tests are run with the 'full' or 'all' parameter
  #
  # Email was removed due to a bug within healthcheck. healthcheck tries to
  # open a TCPSocket against the SMTP server to check for connection, this
  # connection is never closed by the server, thefore, the connection stales
  # until timeout
  config.full_checks = %w[database migration cache site]

  # Add one or more custom checks that return a blank string if ok, or
  # an error message if there is an error
  # config.add_custom_check do
  #   CustomHealthCheck.perform_check
  #   # any code that returns blank on success and non blank string upon failure
  # end

  # Add another custom check with a name, so you can call just specific
  # custom checks. This can also be run using the standard 'custom' check.
  # You can define multiple tests under the same name - they will
  # be run one after the other.
  # config.add_custom_check('sometest') do
  #   CustomHealthCheck.perform_another_check
  #   # any code that returns blank on success and non blank string upon failure
  # end

  # max-age of response in seconds
  # cache-control is public when max_age > 1 and basic_auth_username is not set
  # You can force private without authentication for longer max_age by
  # setting basic_auth_username but not basic_auth_password
  config.max_age = 5 * 60 # 5 minutes

  # Protect health endpoints with basic auth
  # These default to nil and the endpoint is not protected
  # config.basic_auth_username = 'my_username'
  # config.basic_auth_password = 'my_password'

  # Whitelist requesting IPs
  # Defaults to blank and allows any IP
  # config.origin_ip_whitelist = %w[123.123.123.123]

  # http status code used when the ip is not allowed for the request
  config.http_status_for_ip_whitelist_error = 403

  # When redis url is non-standard
  # config.redis_url = 'redis_url'
end
