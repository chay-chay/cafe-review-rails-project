class TokenVerifier
    include ActiveSupport::Configurable
    include ActionController::RequestForgeryProtection

    # `ActionController::RequestForgeryProtection` contains a few
    # configurable options. As we want to make sure that our configuration is
    # the same as what being set in `ActionController::Base`, we should make
    # all out configuration methods to delegate to `ActionController::Base`.
    config.each_key do |configuration_name|
      undef_method configuration_name
      define_method configuration_name do
        ActionController::Base.config[configuration_name]
      end
    end

    def call(env)
      @request = ActionDispatch::Request.new(env.dup)

      unless verified_request?
        raise ActionController::InvalidAuthenticityToken
      end
    end
  
    private
    attr_reader :request
    delegate :params, :session, to: :request
  end