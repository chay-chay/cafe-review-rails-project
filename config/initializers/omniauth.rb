Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
end

# require './lib/token_verifier'
# OmniAuth.config.request_validation_phase = TokenVerifier.new