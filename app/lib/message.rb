class Message
  class << self
    def not_found(record = 'record')
      "Sorry, #{record} not found."
    end

    def invalid_credentials
      'Invalid credentials'
    end

    def invalid_token
      'Invalid token'
    end

    def missing_token
      'Missing token'
    end

    def unauthorized
      'unauthorized request'
    end

    def account_created
      'Account created successfully'
    end

    def account_could_not_be_created
      'Account could not be created'
    end

    def expired_token
      'Sorry, your token has expired. Please log in to continue.'
    end
  end
end
