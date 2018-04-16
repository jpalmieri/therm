class JsonWebToken
  # secret to encode and decode token
  HMAC_SECRET = "1234"

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    # sign token with application secret
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    # get payload; first index in decoded Array
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new(body)
  rescue JWT::DecodeError => e
    raise ExceptionHandler::InvalidToken, e.message
  end
end
