defmodule XRPL.Ledger do
  @moduledoc """
  XRPL.Ledger is a module to interact with ledgers on the XRP Ledger.
  A ledger version contains a header, a transaction tree, and a state tree, which contain account settings, trustlines, balances, transactions, and other data.
  Use these methods to retrieve ledger info.

  Official RPC documentation: https://xrpl.org/ledger-methods.html
  """

  use XRPL

  @doc """
  Retrieve information about the public ledger.

  Official documentation: https://xrpl.org/ledger.html
  """
  def ledger(params) do
    xrpl("ledger", params)
  end

  def ledger!(params), do: params |> ledger() |> unwrap_or_raise()

  defparams "ledger" do
    optional(:ledger_hash, :string, format: XRPL.is_hash())
    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
    optional(:transactions, :boolean, default: false)
    optional(:expand, :boolean, default: false)
    optional(:owner_funds, :boolean, default: false)
    optional(:binary, :boolean)
    optional(:queue, :boolean)
  end

  @doc """
  The ledger_closed method returns the unique identifiers of the most recently closed ledger.
  (This ledger is not necessarily validated and immutable yet.)

  Official documentation: https://xrpl.org/ledger_closed.html
  """
  def ledger_closed do
    xrpl("ledger_closed", %{})
  end

  def ledger_closed!, do: unwrap_or_raise(ledger_closed())

  defparams "ledger_closed" do
  end

  @doc """
  The ledger_current method returns the unique identifiers of the current in-progress ledger.

  This command is mostly useful for testing, because the ledger returned is still in flux.

  Official documentation: https://xrpl.org/ledger_current.html
  """
  def ledger_current do
    xrpl("ledger_current", %{})
  end

  def ledger_current!, do: unwrap_or_raise(ledger_current())

  defparams "ledger_current" do
  end

  @doc """
  The ledger_data method retrieves contents of the specified ledger.
  You can iterate through several calls to retrieve the entire contents of a single ledger version.

  Official documentation: https://xrpl.org/ledger_data.html
  """
  def ledger_data(params) do
    xrpl("ledger_data", params)
  end

  def ledger_data!(params), do: params |> ledger_data() |> unwrap_or_raise()

  defparams "ledger_data" do
    optional(:ledger_hash, :string, format: XRPL.is_hash())
    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
    optional(:binary, :boolean, default: false)
    optional(:limit, :integer, max: 256, default: 256)
    optional(:marker, :string)

    optional(:type, :enum,
      values: [
        "account",
        "amendments",
        "amm",
        "check",
        "deposit_preauth",
        "directory",
        "escrow",
        "fee",
        "hashes",
        "nft_offer",
        "offer",
        "payment_channel",
        "signer_list",
        "state",
        "ticket"
      ]
    )
  end
end
