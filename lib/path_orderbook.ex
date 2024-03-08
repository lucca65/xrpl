defmodule XRPL.PathOrderbook do
  @moduledoc """
  XRPL.PathOrderbook is a module to interact with orderbook modules on the XRP Ledger.

  Paths define a way for payments to flow through intermediary steps on their way from sender to receiver.
  Paths enable cross-currency payments by connecting sender and receiver through order books.
  Use these methods to work with paths and other books.

  Official RPC documentation https://xrpl.org/path-and-order-book-methods.html
  """

  use XRPL

  @doc """
  The amm_info method retrieves information about an Automated Market Maker (AMM) account.

  Official documentation: https://xrpl.org/amm_info.html
  """
  def amm_info(%{asset: asset, asset2: asset2} = params) when is_binary(asset) and is_binary(asset2) do
    xrpl("amm_info", "amm_info_string_string", params)
  end

  def amm_info(%{asset: asset, asset2: asset2} = params) when is_map(asset) and is_binary(asset2) do
    xrpl("amm_info", "amm_info_object_string", params)
  end

  def amm_info(%{asset: asset, asset2: asset2} = params) when is_binary(asset) and is_map(asset2) do
    xrpl("amm_info", "amm_info_string_object", params)
  end

  def amm_info(%{asset: asset, asset2: asset2} = params) when is_map(asset) and is_map(asset2) do
    xrpl("amm_info", "amm_info_object_object", params)
  end

  def amm_info(_) do
    {:error, :invalid_params}
  end

  def amm_info!(params), do: params |> amm_info() |> unwrap_or_raise()

  defparams "amm_info_string_string" do
    optional(:account, :string, format: XRPL.account_address_regex())
    optional(:amm_account, :string, format: XRPL.account_address_regex())
    optional(:asset, :string, format: XRPL.currency_regex())
    optional(:asset2, :string, format: XRPL.currency_regex())
  end

  defparams "amm_info_object_string" do
    optional(:account, :string, format: XRPL.account_address_regex())
    optional(:amm_account, :string, format: XRPL.account_address_regex())

    optional(:asset, :map) do
      required(:currency, :string, format: XRPL.currency_regex())
      optional(:issuer, :string, format: XRPL.account_address_regex())
    end

    optional(:asset2, :string)
  end

  defparams "amm_info_string_object" do
    optional(:account, :string, format: XRPL.account_address_regex())
    optional(:amm_account, :string, format: XRPL.account_address_regex())

    optional(:asset, :string)

    optional(:asset2, :map) do
      required(:currency, :string, format: XRPL.currency_regex())
      optional(:issuer, :string, format: XRPL.account_address_regex())
    end
  end

  defparams "amm_info_object_object" do
    optional(:account, :string, format: XRPL.account_address_regex())
    optional(:amm_account, :string, format: XRPL.account_address_regex())

    optional(:asset, :map) do
      required(:currency, :string, format: XRPL.currency_regex())
      optional(:issuer, :string, format: XRPL.account_address_regex())
    end

    optional(:asset2, :map) do
      required(:currency, :string, format: XRPL.currency_regex())
      optional(:issuer, :string, format: XRPL.account_address_regex())
    end
  end

  @doc """
  The book_offers method retrieves a list of Offers between two currencies, also known as an order book.
  The response omits unfunded Offers and reports how much of each remaining Offer's total is currently funded.

  Official documentation: https://xrpl.org/book_offers.html
  """
  def book_offers(params) do
    xrpl("book_offers", params)
  end

  def book_offers!(params), do: params |> book_offers() |> unwrap_or_raise()

  defparams "book_offers" do
    required(:taker_gets, :map) do
      required(:currency, :string, format: XRPL.currency_regex())
      optional(:issuer, :string, format: XRPL.account_address_regex())
    end

    required(:taker_pays, :map) do
      required(:currency, :string, format: XRPL.currency_regex())
      optional(:issuer, :string, format: XRPL.account_address_regex())
    end

    optional(:ledger_hash, :string, format: XRPL.ledger_hash_regex())
    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
    optional(:limit, :integer)
    optional(:taker, :string, format: XRPL.account_address_regex())
  end

  @doc """
  The deposit_authorized command indicates whether one account is authorized to send payments directly to another. See Deposit Authorization for information on how to require authorization to deliver money to your account.

  Official documentation: https://xrpl.org/deposit_authorized.html
  """
  def deposit_authorized(params) do
    xrpl("deposit_authorized", params)
  end

  def deposit_authorized!(params), do: params |> deposit_authorized() |> unwrap_or_raise()

  defparams "deposit_authorized" do
    required(:source_account, :string, format: XRPL.account_address_regex())
    required(:destination_account, :string, format: XRPL.account_address_regex())
    optional(:ledger_hash, :string, format: XRPL.ledger_hash_regex())
    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
  end

  @doc """
  The nft_buy_offers method returns a list of buy offers for a given NFToken object.

  Official documentation: https://xrpl.org/nft_buy_offers.html
  """
  def nft_buy_offers(params) do
    xrpl("nft_buy_offers", params)
  end

  def nft_buy_offers!(params), do: params |> nft_buy_offers() |> unwrap_or_raise()

  defparams "nft_buy_offers" do
    required(:nft_id, :string)
    optional(:ledger_hash, :string, format: XRPL.ledger_hash_regex())
    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
    optional(:limit, :integer)
    optional(:marker, :string)
  end

  @doc """
  The nft_sell_offers method returns a list of sell offers for a given NFToken object.

  Official documentation: https://xrpl.org/nft_sell_offers.html
  """
  def nft_sell_offers(params) do
    xrpl("nft_sell_offers", params)
  end

  def nft_sell_offers!(params), do: params |> nft_sell_offers() |> unwrap_or_raise()

  defparams "nft_sell_offers" do
    required(:nft_id, :string)
    optional(:ledger_hash, :string, format: XRPL.ledger_hash_regex())
    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
    optional(:limit, :integer)
    optional(:marker, :string)
  end

  @doc """
  The ripple_path_find method is a simplified version of the path_find method that provides a single response with a payment path you can use right away. It is available in both the WebSocket and JSON-RPC APIs. However, the results tend to become outdated as time passes. Instead of making multiple calls to stay updated, you should instead use the path_find method to subscribe to continued updates where possible.

  Although the rippled server tries to find the cheapest path or combination of paths for making a payment, it is not guaranteed that the paths returned by this method are, in fact, the best paths.

  Official documentation: https://xrpl.org/ripple_path_find.html
  """
  def ripple_path_find(params) do
    xrpl("ripple_path_find", params)
  end

  def ripple_path_find!(params), do: params |> ripple_path_find() |> unwrap_or_raise()

  defparams "ripple_path_find" do
    required(:source_account, :string, format: XRPL.account_address_regex())
    required(:destination_account, :string, format: XRPL.account_address_regex())

    required(:destination_amount, :map) do
      required(:currency, :string, format: XRPL.currency_regex())
      optional(:issuer, :string, format: XRPL.account_address_regex())
      required(:value, :string)
    end

    optional(:source_currencies, :list)
  end
end
