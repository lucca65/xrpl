# XRPL

This library intends to help Elixir developers to integrate and use [XRP Ledger Blockchain](https://xrpl.org/).

It allows you to interact with its HTTP API and is organized in a manner similar to the [official documentation](https://xrpl.org/http-websocket-apis.html).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `xrpl` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:xrpl, "~> 1.0.0"}
  ]
end
```

## Usage

### Configuration

This library supports configuration through environment variables. You can set the following variables:

```elixir
config :xrpl,
  network: :mainnet, # Supports :mainnet, :testnet and :devnet
  mainnet: "https://s2.ripple.com:51234/",
  testnet: "https://s.altnet.rippletest.net:51234/",
  devnet: "https://s.devnet.rippletest.net:51234/"
```

Internally we default to `:mainnet` if no configuration is provided. You can also change the address of each network to fit your needs.

For example, you may want to use your own devnet node:

```elixir
config :xrpl,
  network: :devnet,
  devnet: "http://localhost:51234/"
```

### Params

We always use [`Map`](https://hexdocs.pm/elixir/1.16.1/Map.html)s to pass parameters to the functions. This is a design decision to make the code more readable and to avoid the need to remember the order of the parameters.

```elixir
iex> XRPL.Account.account_info(%{account: "rG1QQv2nh2gr7RCZ1P8YYcBUKCCN633jCn"})
{:ok,
 %{
   "account_data" => %{
     "Account" => "rG1QQv2nh2gr7RCZ1P8YYcBUKCCN633jCn",
     "Balance" => "10109993",
     "Flags" => 1048576,
     "LedgerEntryType" => "AccountRoot",
     "MessageKey" => "0200000000000000000000000038901D3A772963CF12FF7C0E010FE350B6CCC45D",
     "OwnerCount" => 0,
     "PreviousTxnID" => "23F8BD473F7EF336BC0A50E8270ECD3860BC403E4FB140545690B753EA3041EB",
     "PreviousTxnLgrSeq" => 84252398,
     "RegularKey" => "rhLkGGNZdjSpnHJw4XAFw1Jy7PD8TqxoET",
     "Sequence" => 192222,
     "index" => "92FA6A9FC8EA6018D5D16532D7795C91BFB0831355BDFDA177E86C8BF997985F"
   },
   "account_flags" => %{
     "allowTrustLineClawback" => false,
     "defaultRipple" => false,
     "depositAuth" => false,
     "disableMasterKey" => true,
     "disallowIncomingCheck" => false,
     "disallowIncomingNFTokenOffer" => false,
     "disallowIncomingPayChan" => false,
     "disallowIncomingTrustline" => false,
     "disallowIncomingXRP" => false,
     "globalFreeze" => false,
     "noFreeze" => false,
     "passwordSpent" => false,
     "requireAuthorization" => false,
     "requireDestinationTag" => false
   },
   "ledger_hash" => "F28F29CB91E3DD5DE2BAE9B794E48AEBD009F1AA8532BFCA391ADEBF96A498DD",
   "ledger_index" => 86500345,
   "status" => "success",
   "validated" => true
 }}
```

If you need insight into the params, we provide a quick way for you to refer back to the official documentation:

```elixir
iex> h XRPL.Account.account_info/1

                            def account_info(params)                            

The account_info command retrieves information about an account, its activity,
and its XRP balance. All information retrieved is relative to a particular
version of the ledger.

Official documentation: https://xrpl.org/account_info.html
```

Of course this also works on HexDocs: https://hexdocs.pm/xrpl/XRPL.Account.html#account_info/1


### Errors

This library will have predictable errors. If you pass something wrong, you will get an error message that is easy to understand and fix. We may give you the following errors:

- `XRPL.Error{reason: :validation_error}` if you pass invalid parameters
- `XRPL.Error{reason: :request_error}` if the request to XRPL servers fails

We also support exceptions so if you want to throw an exception instead of getting the `{:error, reason}` tuple, you can use the bang version of the functions:

```elixir
XRPL.Account.account_info!(%{account: "not_a_valid_account"})
```

We also validate the parameters you pass to the functions. Some of the parameters are required and some are optional and you will get predictable [`Ecto.Changeset`](https://hexdocs.pm/ecto/Ecto.html#module-changesets) validation errors if you pass something wrong.


### Utilities

We also provide you with a few useful regex's to validate some of the data you may encounter during development. For example, if you want an regex for a valid XRP address, you can use:

```elixir
iex(1)> XRPL.account_address_regex
~r/^(?!.*(0|O|I|l))[rR][a-zA-Z1-9]{24,34}$/
```
Of course they are available on HexDocs: https://hexdocs.pm/xrpl/XRPL.html#account_address_regex/0

Those regex's are also used internally to validate the parameters you pass to the functions.

## Thanks

This project was part of XRPL Grant Program Wave 5 and was funded by Ripple. Thanks to them for supporting open source projects. Checkout the [announcement here](https://dev.to/ripplexdev/xrpl-grants-wave-5-awardees-driving-innovation-in-the-xrpl-ecosystem-3d9c)
