defmodule XRPL.Ledger do
  @moduledoc """
  XRPL.Ledger is a module to interact with ledgers on the XRP Ledger.
  A ledger version contains a header, a transaction tree, and a state tree, which contain account settings, trustlines, balances, transactions, and other data.
  Use these methods to retrieve ledger info.

  Official RPC documentation: https://xrpl.org/ledger-methods.html
  """

  import XRPL

  @ledger_type ~w(account amendments amm check deposit_preauth directory escrow fee hashes nft_offer offer payment_channel signer_list state ticket)

  @type currency_without_amount ::
          %{currency: String.t()} | %{currency: String.t(), issuer: String.t()}

  @doc """
  Retrieve information about the public ledger.

  Official documentation: https://xrpl.org/ledger.html
  """
  @spec ledger(Keyword.t()) :: Tesla.Env.result()
  def ledger(opts \\ []) do
    opts =
      Keyword.validate!(opts, [
        :binary,
        :queue,
        :ledger_hash,
        :ledger_index,
        full: false,
        accounts: false,
        transactions: false,
        expand: false,
        owner_funds: false,
        type: "account"
      ])

    # Validate ledger type
    if Enum.member?(@ledger_type, Keyword.get(opts, :type)) do
      xrpl("ledger", Map.new(opts))
    else
      {:error, "Invalid ledger type"}
    end
  end

  def ledger!(opts \\ []), do: unwrap_or_raise(ledger(opts))

  @doc """
  The ledger_closed method returns the unique identifiers of the most recently closed ledger.
  (This ledger is not necessarily validated and immutable yet.)

  Official documentation: https://xrpl.org/ledger_closed.html
  """
  @spec ledger_closed() :: Tesla.Env.result()
  def ledger_closed do
    xrpl("ledger_closed", %{})
  end

  def ledger_closed!, do: unwrap_or_raise(ledger_closed())

  @doc """
  The ledger_current method returns the unique identifiers of the current in-progress ledger.

  This command is mostly useful for testing, because the ledger returned is still in flux.

  Official documentation: https://xrpl.org/ledger_current.html
  """
  @spec ledger_current() :: Tesla.Env.result()
  def ledger_current do
    xrpl("ledger_current", %{})
  end

  def ledger_current!, do: unwrap_or_raise(ledger_current())

  @doc """
  The ledger_data method retrieves contents of the specified ledger.
  You can iterate through several calls to retrieve the entire contents of a single ledger version.

  Official documentation: https://xrpl.org/ledger_data.html
  """
  @spec ledger_data(Keyword.t()) :: Tesla.Env.result()
  def ledger_data(opts \\ []) do
    limit = if Keyword.get(opts, :binary), do: 2048, else: 256

    opts =
      Keyword.validate!(opts, [
        :ledger_index,
        :ledger_hash,
        :marker,
        :type,
        binary: false,
        limit: limit
      ])

    # Check if sent type is valid
    if Keyword.has_key?(opts, :type) and not Enum.member?(@ledger_type, Keyword.get(opts, :type)) do
      {:error, "Invalid ledger type"}
    else
      xrpl("ledger_data", Map.new(opts))
    end
  end

  def ledger_data!(opts \\ []), do: unwrap_or_raise(ledger_data(opts))
end
