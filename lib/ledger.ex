defmodule XRPL.Ledger do
  @moduledoc """
  XRPL.Ledger is a module to interact with ledgers on the XRP Ledger.

  Official RPC documentation: https://xrpl.org/ledger-methods.html
  """

  use Tesla

  import XRPL

  plug(Tesla.Middleware.BaseUrl, Application.get_env(:xrpl, :devnet))
  plug(Tesla.Middleware.JSON)
  plug(XRPL.Middleware.Error)

  @ledger_type ~w(account amendments amm check deposit_preauth directory escrow fee hashes nft_offer offer payment_channel signer_list state ticket)

  @type currency_without_amount ::
          %{currency: String.t()} | %{currency: String.t(), issuer: String.t()}

  @doc """
  Retrieve information about the public ledger.

  Official documentation: https://xrpl.org/ledger.html
  """
  @spec ledger(integer | String.t(), Keyword.t()) :: Tesla.Env.result()
  def ledger(ledger_index, opts \\ []) do
    opts =
      Keyword.validate!(opts,
        full: false,
        accounts: false,
        transactions: false,
        expand: false,
        owner_funds: false,
        binary: false,
        queue: false,
        type: "account"
      )

    # Validate ledger type
    Enum.any?(@ledger_type, &(&1 == Keyword.get(opts, :type))) || raise("Invalid ledger index")

    post(
      "/",
      %{
        method: "ledger",
        params: [Map.merge(%{ledger_index: ledger_index}, Map.new(opts))]
      }
    )
  end

  def ledger!(ledger_index, opts \\ []), do: unwrap_or_raise(ledger(ledger_index, opts))

  @doc """
  The ledger_closed method returns the unique identifiers of the most recently closed ledger.
  (This ledger is not necessarily validated and immutable yet.)

  Official documentation: https://xrpl.org/ledger_closed.html
  """
  @spec ledger_closed() :: Tesla.Env.result()
  def ledger_closed() do
    post("/", %{method: "ledger_closed", params: %{}})
  end

  def ledger_closed!(), do: unwrap_or_raise(ledger_closed())

  @doc """
  The ledger_current method returns the unique identifiers of the current in-progress ledger.

  This command is mostly useful for testing, because the ledger returned is still in flux.

  Official documentation: https://xrpl.org/ledger_current.html
  """
  @spec ledger_current() :: Tesla.Env.result()
  def ledger_current() do
    post("/", %{method: "ledger_current", params: %{}})
  end

  def ledger_current!(), do: unwrap_or_raise(ledger_current())

  @doc """
  The ledger_data method retrieves contents of the specified ledger.
  You can iterate through several calls to retrieve the entire contents of a single ledger version.

  Official documentation: https://xrpl.org/ledger_data.html
  """
  @spec ledger_data(integer | String.t(), Keyword.t()) :: Tesla.Env.result()
  def ledger_data(ledger_index, opts \\ []) do
    limit = if Keyword.get(opts, :binary), do: 2048, else: 256
    opts = Keyword.validate!(opts, limit: limit, binary: false, marker: nil, type: "account")

    Enum.any?(@ledger_type, &(&1 == Keyword.get(opts, :type))) || raise("Invalid ledger index")

    post("/", %{
      method: "ledger_data",
      params: [Map.merge(%{ledger_index: ledger_index}, Map.new(opts))]
    })
  end

  def ledger_data!(ledger_index, opts \\ []), do: unwrap_or_raise(ledger_data(ledger_index, opts))

  @doc """
  The ledger_entry method returns a single ledger entry from the XRP Ledger in its raw format.
  See [ledger format](https://xrpl.org/ledger-object-types.html) for information on the different types of entries you can retrieve.

  Official documentation: https://xrpl.org/ledger_entry.html
  """
  @spec ledger_entry(:by_id, integer | String.t(), Keyword.t()) :: Tesla.Env.result()
  def ledger_entry(:by_id, ledger_index, index) do
    post("/", %{
      method: "ledger_entry",
      params: [%{ledger_index: ledger_index, index: index}]
    })
  end

  @spec ledger_entry(:account_root, integer | String.t(), Keyword.t()) :: Tesla.Env.result()
  def ledger_entry(:account_root, account_root, ledger_index) do
    post("/", %{
      method: "ledger_entry",
      params: [
        %{
          account_root: account_root,
          ledger_index: ledger_index
        }
      ]
    })
  end

  def ledger_entry(:amm, ledger_index, asset) when is_binary(asset) do
    post("/", %{
      method: "ledger_entry",
      params: [
        %{
          amm: %{asset: asset},
          ledger_index: ledger_index
        }
      ]
    })
  end

  def ledger_entry(:amm, ledger_index, %{asset: asset, asset2: asset2}) do
    post("/", %{
      method: "ledger_entry",
      amm: %{
        asset: asset,
        asset2: asset2
      },
      ledger_index: ledger_index
    })
  end

  def ledger_entry(:directory_node, ledger_index, directory) when is_binary(directory) do
    post("/", %{
      method: "ledger_entry",
      params: [%{directory: directory, ledger_index: ledger_index}]
    })
  end

  def ledger_entry(:directory_node, ledger_index, opts) do
    opts =
      Keyword.filter(opts, &Enum.any?([:subindex, :dir_root, :owner], &1))

    post("/", %{
      method: "ledger_entry",
      params: [%{ledger_index: ledger_index, directory: Map.new(opts)}]
    })
  end

  def ledger_entry(:offer, ledger_index, offer) when is_binary(offer) do
    post("/", %{
      method: "ledger_entry",
      params: [%{offer: offer, ledger_index: ledger_index}]
    })
  end

  def ledger_entry(:offer, ledger_index, account, seq) do
    post("/", %{
      method: "ledger_entry",
      params: [%{offer: %{account: account, seq: seq}, ledger_index: ledger_index}]
    })
  end
end
