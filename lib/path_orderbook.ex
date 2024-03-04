defmodule XRPL.PathOrderbook do
  @moduledoc """
  XRPL.PathOrderbook is a module to interact with orderbook modules on the XRP Ledger.

  Paths define a way for payments to flow through intermediary steps on their way from sender to receiver.
  Paths enable cross-currency payments by connecting sender and receiver through order books.
  Use these methods to work with paths and other books.

  Official RPC documentation https://xrpl.org/path-and-order-book-methods.html
  """

  import XRPL

  @doc """
  The amm_info method retrieves information about an Automated Market Maker (AMM) account.

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/path-and-order-book-methods/amm_info/#amm_info
  """
  def amm_info(_, _, _) do
    raise "Not implemented. Requires amendments. More info: https://xrpl.org/resources/known-amendments/#amm"
  end

  @doc """
  The book_offers method retrieves a list of Offers between two currencies, also known as an order book.
  The response omits unfunded Offers and reports how much of each remaining Offer's total is currently funded.

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/path-and-order-book-methods/book_offers/#book_offers
  """
  def book_offers(
        taker_gets_currency,
        taker_pays_currency,
        taker_pays_issuer,
        ledger_hash \\ nil,
        ledger_index \\ nil,
        limit \\ nil,
        taker \\ nil
      ) do
    params = %{
      taker_gets: %{currency: taker_gets_currency},
      taker_pays: %{currency: taker_pays_currency, issuer: taker_pays_issuer}
    }

    params = if taker, do: Map.put(params, :taker, taker), else: params
    params = if ledger_hash, do: Map.put(params, :ledger_hash, ledger_hash), else: params
    params = if ledger_index, do: Map.put(params, :ledger_index, ledger_index), else: params
    params = if limit, do: Map.put(params, :limit, limit), else: params

    post("/", %{
      method: "book_offers",
      params: [params]
    })
  end

  @doc """
  The deposit_authorized command indicates whether one account is authorized to send payments directly to another. See Deposit Authorization for information on how to require authorization to deliver money to your account.

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/path-and-order-book-methods/deposit_authorized/#deposit_authorized
  """
  def deposit_authorized(source_account, destination_account, ledger_index \\ nil, ledger_hash \\ nil) do
    params = %{
      source_account: source_account,
      destination_account: destination_account
    }

    params = if ledger_hash, do: Map.put(params, :ledger_hash, ledger_hash), else: params
    params = if ledger_index, do: Map.put(params, :ledger_index, ledger_index), else: params

    post("/", %{
      method: "deposit_authorized",
      params: [params]
    })
  end

  @doc """
  The nft_buy_offers method returns a list of buy offers for a given NFToken object.

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/path-and-order-book-methods/nft_buy_offers/#nft_buy_offers
  """
  def nft_buy_offers(nft_id, ledger_index \\ nil, ledger_hash \\ nil, limit \\ nil, maker \\ nil) do
    params = %{
      nft_id: nft_id
    }

    params = if ledger_hash, do: Map.put(params, :ledger_hash, ledger_hash), else: params
    params = if ledger_index, do: Map.put(params, :ledger_index, ledger_index), else: params
    params = if limit, do: Map.put(params, :limit, limit), else: params
    params = if maker, do: Map.put(params, :maker, maker), else: params

    post("/", %{
      method: "nft_buy_offers",
      params: [params]
    })
  end

  def nft_sell_offers(nft_id, ledger_index \\ nil, ledger_hash \\ nil, limit \\ nil, taker \\ nil) do
    params = %{
      nft_id: nft_id
    }

    params = if ledger_hash, do: Map.put(params, :ledger_hash, ledger_hash), else: params
    params = if ledger_index, do: Map.put(params, :ledger_index, ledger_index), else: params
    params = if limit, do: Map.put(params, :limit, limit), else: params
    params = if taker, do: Map.put(params, :taker, taker), else: params

    post("/", %{
      method: "nft_sell_offers",
      params: [params]
    })
  end
end
