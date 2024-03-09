import Config

# Networks
# https://xrpl.org/public-servers.html

config :xrpl,
  network: :mainnet,
  mainnet: "https://s2.ripple.com:51234/",
  testnet: "https://s.altnet.rippletest.net:51234/",
  devnet: "https://s.devnet.rippletest.net:51234/"

config :logger, :console, level: :warning, format: "[$level] $message\n", metadata: [:request_id, :url, :body, :details]

config :goal,
  ledger_index_regex: ~r/^(\d+|current|closed|validated)$/,
  ledger_entry_regex: ~r/^[a-fA-F0-9]{64}$/,
  currency_regex: ~r/^[a-zA-Z0-9?!\@#\$%\^&*\>\<\(\)\{\}\[\]\|]{3}$/,
  public_key_regex: ~r/^n[1-9a-np-zA-NP-Z]{1,53}$/,
  account_address_regex: ~r/^(?!.*(0|O|I|l))[rR][a-zA-Z1-9]{24,34}$/
