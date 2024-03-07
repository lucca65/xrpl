defmodule XRPL.Account do
  @moduledoc """
  XRPL.Account is a module to interact with accounts on the XRP Ledger.
  An account in the XRP Ledger represents a holder of XRP and a sender of transactions. Use these methods to work with account info.

  Official RPC documentation https://xrpl.org/account-methods.html
  """

  use XRPL

  @doc """
  The account_channels method returns information about an account's Payment Channels.
  This includes only channels where the specified account is the channel's source, not the destination. (A channel's "source" and "owner" are the same.)
  All information retrieved is relative to a particular version of the ledger.

  Official documentation: https://xrpl.org/account_channels.html
  """
  def account_channels(params) do
    xrpl("account_channels", params)
  end

  def account_channels!(params), do: params |> account_channels() |> unwrap_or_raise()

  defparams "account_channels" do
    required(:account, :string, format: XRPL.account_address_regex())
    optional(:destination_account, :string, format: XRPL.account_address_regex())
    optional(:ledger_hash, :string, format: XRPL.ledger_hash_regex())
    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
    optional(:limit, :integer, min: 10, max: 400, default: 200)
    optional(:marker, :string)
  end

  @doc """
  The account_currencies command retrieves a list of currencies that an account can send or receive, based on its trust lines

  Official documentation: https://xrpl.org/account_currencies.html
  """
  def account_currencies(params) do
    xrpl("account_currencies", params)
  end

  def account_currencies!(params), do: params |> account_currencies() |> unwrap_or_raise()

  defparams "account_currencies" do
    required(:account, :string, format: XRPL.account_address_regex())
    optional(:ledger_hash, :string, format: XRPL.ledger_hash_regex())
    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
  end

  @doc """
  The account_info command retrieves information about an account, its activity, and its XRP balance.
  All information retrieved is relative to a particular version of the ledger.

  Official documentation: https://xrpl.org/account_info.html
  """
  def account_info(params) do
    xrpl("account_info", params)
  end

  def account_info!(params), do: params |> account_info() |> unwrap_or_raise()

  defparams "account_info" do
    required(:account, :string, format: XRPL.account_address_regex())
    optional(:ledger_hash, :string, format: XRPL.ledger_hash_regex())
    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
    optional(:queue, :boolean)
    optional(:signer_lists, :boolean)
  end

  @doc """
  The account_lines command returns information about an account's trust lines, including balances in all non-XRP currencies and assets.
  All information retrieved is relative to a particular version of the ledger.

  Official documentation: https://xrpl.org/account_lines.html
  """
  def account_lines(params) do
    xrpl("account_lines", params)
  end

  def account_lines!(params), do: params |> account_lines() |> unwrap_or_raise()

  defparams "account_lines" do
    required(:account, :string, format: XRPL.account_address_regex())
    optional(:ledger_hash, :string, format: XRPL.ledger_hash_regex())
    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
    optional(:peer, :string, format: XRPL.account_address_regex())
    optional(:limit, :integer, min: 10, max: 400, default: 200)
    optional(:marker, :string)
  end

  @doc """
  The account_nfts method returns a list of NFToken objects for the specified account.

  Official documentation: https://xrpl.org/account_nfts.html
  """
  def account_nfts(params) do
    xrpl("account_nfts", params)
  end

  def account_nfts!(params), do: params |> account_nfts() |> unwrap_or_raise()

  defparams "account_nfts" do
    required(:account, :string, format: XRPL.account_address_regex())
    optional(:ledger_hash, :string, format: XRPL.ledger_hash_regex())
    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
    optional(:limit, :integer, min: 10, max: 400, default: 200)
    optional(:marker, :string)
  end

  @doc """
  The account_objects command returns the raw ledger format for all objects owned by an account.
  For a higher-level view of an account's trust lines and balances, see the account_lines method instead.

  Ref: https://xrpl.org/account_objects.html
  """
  def account_objects(params) do
    xrpl("account_objects", params)
  end

  def account_objects!(params), do: params |> account_objects() |> unwrap_or_raise()

  defparams "account_objects" do
    required(:account, :string, format: XRPL.account_address_regex())
    optional(:deletion_blockers_only, :boolean, default: false)
    optional(:ledger_hash, :string, format: XRPL.ledger_hash_regex())
    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
    optional(:limit, :integer, min: 10, max: 400, default: 200)
    optional(:marker, :string)

    optional(:type, :enum,
      values: [
        "check",
        "deposit_preauth",
        "escrow",
        "nft_offer",
        "nft_page",
        "offer",
        "payment_channel",
        "signer_list",
        "state",
        "ticket"
      ]
    )
  end

  @doc """
  The account_offers method retrieves a list of offers made by a given account that are outstanding as of a particular ledger version.

  Ref: https://xrpl.org/account_offers.html
  """
  def account_offers(params) do
    xrpl("account_offers", params)
  end

  def account_offers!(params), do: params |> account_offers() |> unwrap_or_raise()

  defparams "account_offers" do
    required(:account, :string, format: XRPL.account_address_regex())
    optional(:ledger_hash, :string, format: XRPL.ledger_hash_regex())
    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
    optional(:limit, :integer, min: 10, max: 400, default: 200)
    optional(:marker, :string)
  end

  @doc """
  The account_tx method retrieves a list of transactions that involved the specified account.

  Ref: https://xrpl.org/account_tx.html
  """
  def account_tx(params) do
    xrpl("account_tx", params)
  end

  def account_tx!(params), do: params |> account_tx() |> unwrap_or_raise()

  defparams "account_tx" do
    required(:account, :string, format: XRPL.account_address_regex())

    optional(:tx_type, :enum,
      values: [
        "AccountSet",
        "AccountDelete",
        "AMMBid",
        "AMMCreate",
        "AMMDelete",
        "AMMDeposit",
        "AMMVote",
        "AMMWithdraw",
        "CheckCancel",
        "CheckCash",
        "CheckCreate",
        "Clawback",
        "DepositPreauth",
        "DIDDelete",
        "DIDSet",
        "EscrowCancel",
        "EscrowCreate",
        "EscrowFinish",
        "NFTokenAcceptOffer",
        "NFTokenBurn",
        "NFTokenCancelOffer",
        "NFTokenCreateOffer",
        "NFTokenMint",
        "OfferCancel",
        "OfferCreate",
        "Payment",
        "PaymentChannelClaim",
        "PaymentChannelCreate",
        "PaymentChannelFund",
        "SetRegularKey",
        "SignerListSet",
        "TicketCreate",
        "TrustSet",
        "XChainAccountCreateCommit",
        "XChainAddAccountCreateAttestation",
        "XChainAddClaimAttestation",
        "XChainClaim",
        "XChainCommit",
        "XChainCreateBridge",
        "XChainCreateClaimID",
        "XChainModifyBridge"
      ]
    )

    optional(:ledger_index_min, :integer)
    optional(:ledger_index_max, :integer)
    optional(:ledger_hash, :string, format: XRPL.ledger_hash_regex())
    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
    optional(:binary, :boolean, default: false)
    optional(:forward, :boolean, default: false)
    optional(:limit, :integer, min: 10, max: 400, default: 200)
    optional(:marker, :string)
  end

  @doc """
  The gateway_balances command calculates the total balances issued by a given account, optionally excluding amounts held by operational addresses.

  Ref: https://xrpl.org/gateway_balances.html
  """
  def gateway_balances(params) do
    xrpl("gateway_balances", params)
  end

  def gateway_balances!(params), do: params |> gateway_balances() |> unwrap_or_raise()

  defparams "gateway_balances" do
    required(:account, :string, format: XRPL.account_address_regex())
    optional(:strict, :boolean, default: false)
    optional(:hotwallet, :string, format: XRPL.account_address_regex())
    optional(:ledger_hash, :string, format: XRPL.ledger_hash_regex())
    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
  end

  @doc """
  The noripple_check command provides a quick way to check the status of the Default Ripple field for an account and the No Ripple flag of its trust lines, compared with the recommended settings.

  Ref: https://xrpl.org/noripple_check.html
  """
  def noripple_check(params) do
    xrpl("noripple_check", params)
  end

  def noripple_check!(params), do: params |> noripple_check() |> unwrap_or_raise()

  defparams "noripple_check" do
    required(:account, :string, format: XRPL.account_address_regex())
    required(:role, :enum, values: ~w[gateway user])
    optional(:transactions, :boolean, default: false)
    optional(:limit, :integer, default: 300)
    optional(:ledger_hash, :string, format: XRPL.ledger_hash_regex())
    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
  end
end
