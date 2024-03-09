defmodule XRPL.Clio do
  @moduledoc """
  Use these methods to retrieve information using Clio server APIs.

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/clio-server/
  """

  use XRPL

  @doc """
  The server_info command asks the Clio server for a human-readable version of various information about the Clio server being queried. For rippled servers, see server_info (rippled) instead.

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/clio-methods/server_info-clio/#server_info
  """
  def server_info, do: xrpl("server_info", %{})
  def server_info!, do: unwrap_or_raise(server_info())

  defparams("server_info") do
  end

  @doc """
  The ledger command retrieves information about the public ledger.

  Note that the Clio server returns validated ledger data by default.

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/clio-methods/ledger-clio/#ledger
  """
  def ledger(params), do: xrpl("ledger", params)
  def ledger!(params), do: unwrap_or_raise(ledger(params))

  defparams "ledger" do
    optional(:ledger_hash, :string, format: XRPL.ledger_hash_regex())
    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
    optional(:transactions, :boolean, default: false)
    optional(:expand, :boolean, default: false)
    optional(:owner_funds, :boolean, default: false)
    optional(:binary, :boolean)
    optional(:diff, :boolean)
  end

  @doc """
  The nft_history command asks the Clio server for past transaction metadata for the NFT being queried. New in: Clio v1.1.0

  Note nft_history returns only successful transactions associated with the NFT.

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/clio-methods/nft_history/
  """
  def nft_history(params), do: xrpl("nft_history", params)
  def nft_history!(params), do: unwrap_or_raise(nft_history(params))

  defparams "nft_history" do
    required(:nft_id, :string)
    optional(:ledger_index_min, :integer)
    optional(:ledger_index_max, :integer)
    optional(:ledger_hash, :string, format: XRPL.ledger_hash_regex())
    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
    optional(:binary, :boolean, default: false)
    optional(:forward, :boolean, default: false)
    optional(:limit, :integer)
    optional(:marker, :string)
  end

  @doc """
  The nft_info command asks the Clio server for information about the NFT being queried.

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/clio-methods/nft_info/
  """
  def nft_info(params), do: xrpl("nft_info", params)
  def nft_info!(params), do: unwrap_or_raise(nft_info(params))

  defparams "nft_info" do
    required(:nft_id, :string)
    optional(:ledger_hash, :string, format: XRPL.ledger_hash_regex())
    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
  end
end
