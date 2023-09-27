defmodule XRPL.LedgerEntry do
  @moduledoc """
  The ledger_entry method returns a single ledger entry from the XRP Ledger in its raw format.
  See [ledger format](https://xrpl.org/ledger-object-types.html) for information on the different types of entries you can retrieve.

  Official documentation: https://xrpl.org/ledger_entry.html
  """

  import XRPL

  @doc """
  Retrieve any type of ledger object by its unique ID.

  Official documentation: https://xrpl.org/ledger_entry.html#get-ledger-object-by-id
  """
  # @spec by_id(integer | String.t(), String.t()) :: Tesla.Env.result()
  def by_id(ledger_index, index) when is_ledger_index(index) do
    post("/", %{
      method: "ledger_entry",
      params: [%{ledger_index: ledger_index, index: index}]
    })
  end

  def by_id!(ledger_index, index), do: unwrap_or_raise(by_id(ledger_index, index))

  @spec account_root(integer | String.t(), Keyword.t()) :: Tesla.Env.result()
  def account_root(account_root, ledger_index) do
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

  # def ledger_entry(:ripple_state, ledger_index, accounts, currency) do
  # end
end
