import Config

# Networks
# https://xrpl.org/public-servers.html

config :xrpl,
  mainnet: "https://s2.ripple.com:51234/",
  testnet: "https://s.altnet.rippletest.net:51234/",
  devnet: "https://s.devnet.rippletest.net:51234/"

config :logger, :console, format: "[$level] $message\n", metadata: [:request_id, :url]
