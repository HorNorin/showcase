Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "KZa9ECYh5ASx9SbKslUIgSfoX", "RZWzy1oDe3zBq9CwgdSnr1mYVus6BvAQjaLgqASbG78J2ClFVL"
  provider :facebook, "1103977139618823", "749874082c12f80daea33b51f582ddac"
end
