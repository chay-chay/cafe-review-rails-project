Rails.application.config.middleware.use OmniAuth::Builder do #intepolate our request to outside third perty
    provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], { access_type: 'online', skip_jwt: true } #able to access omniauth
end

# require './lib/token_verifier'
# OmniAuth.config.request_validation_phase = TokenVerifier.new