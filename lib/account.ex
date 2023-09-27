defmodule XRPL.Account do
  @moduledoc """
  XRPL.Account is a module to interact with accounts on the XRP Ledger.
  An account in the XRP Ledger represents a holder of XRP and a sender of transactions. Use these methods to work with account info.

  Official RPC documentation https://xrpl.org/account-methods.html
  """

  import XRPL

  @doc """
  The account_channels method returns information about an account's Payment Channels.
  This includes only channels where the specified account is the channel's source, not the destination. (A channel's "source" and "owner" are the same.)
  All information retrieved is relative to a particular version of the ledger.

  Official documentation: https://xrpl.org/account_channels.html
  """
  @spec account_channels(String.t(), String.t()) :: Tesla.Env.result()
  def account_channels(account, destination_account) do
    xrpl("account_channels", %{
      account: account,
      destination_account: destination_account,
      ledger_index: "validated"
    })
  end

  def account_channels!(account, destination_account),
    do: unwrap_or_raise(account_channels(account, destination_account))

  @doc """
  The account_currencies command retrieves a list of currencies that an account can send or receive, based on its trust lines

  Official documentation: https://xrpl.org/account_currencies.html
  """
  @spec account_currencies(String.t(), Keyword.t()) :: Tesla.Env.result()
  def account_currencies(account, opts \\ []) do
    opts = Keyword.validate!(opts, [:ledger_hash, :ledger_index])

    xrpl("account_currencies", Map.merge(%{account: account}, Map.new(opts)))
  end

  def account_currencies!(account), do: unwrap_or_raise(account_currencies(account))

  @doc """
  The account_info command retrieves information about an account, its activity, and its XRP balance.
  All information retrieved is relative to a particular version of the ledger.

  Official documentation: https://xrpl.org/account_info.html
  """
  @spec account_info(String.t(), Keyword.t()) :: Tesla.Env.result()
  def account_info(account, opts \\ []) do
    opts = Keyword.validate!(opts, [:ledger_hash, :ledger_index, :queue, :signer_list])

    xrpl("account_info", Map.merge(%{account: account}, Map.new(opts)))
  end

  def account_info!(account), do: unwrap_or_raise(account_info(account))

  @doc """
  The account_lines command returns information about an account's trust lines, including balances in all non-XRP currencies and assets.
  All information retrieved is relative to a particular version of the ledger.

  Official documentation: https://xrpl.org/account_lines.html
  """
  @spec account_lines(String.t()) :: Tesla.Env.result()
  def account_lines(account) do
    xrpl("account_lines", %{account: account})
  end

  def account_lines!(account), do: unwrap_or_raise(account_lines(account))

  @doc """
  The account_nfts method returns a list of NFToken objects for the specified account.

  Official documentation: https://xrpl.org/account_nfts.html
  """
  @spec account_nfts(String.t(), Keyword.t()) :: Tesla.Env.result()
  def account_nfts(account, opts \\ []) do
    opts = Keyword.validate!(opts, [:ledger_hash, :ledger_index, :limit, :marker])
    xrpl("account_nfts", Map.merge(%{account: account}, Map.new(opts)))
  end

  def account_nfts!(account), do: unwrap_or_raise(account_nfts(account))

  @doc """
  The account_objects command returns the raw ledger format for all objects owned by an account.
  For a higher-level view of an account's trust lines and balances, see the account_lines method instead.

  Ref: https://xrpl.org/account_objects.html
  """
  def account_objects(account, opts \\ []) do
    opts =
      Keyword.validate!(opts, [
        :deletion_blockers_only,
        :ledger_hash,
        :ledger_index,
        :limit,
        :marker,
        :type
      ])

    xrpl("account_objects", Map.merge(%{account: account}, Map.new(opts)))
  end

  def account_objects!(account, opts),
    do: unwrap_or_raise(account_objects(account, opts))

  @doc """
  The account_offers method retrieves a list of offers made by a given account that are outstanding as of a particular ledger version.

  Ref: https://xrpl.org/account_offers.html
  """
  @spec account_offers(String.t(), Keyword.t()) :: Tesla.Env.result()
  def account_offers(account, opts \\ []) do
    opts = Keyword.validate!(opts, [:ledger_hash, :ledger_index, :limit, :marker])
    xrpl("account_offers", Map.merge(%{account: account}, Map.new(opts)))
  end

  def account_offers!(account, opts), do: unwrap_or_raise(account_offers(account, opts))

  @doc """
  The account_tx method retrieves a list of transactions that involved the specified account.

  Ref: https://xrpl.org/account_tx.html
  """
  @spec account_tx(String.t(), integer, integer, Keyword.t()) :: Tesla.Env.result()
  def account_tx(account, index_min \\ -1, index_max \\ -1, opts \\ []) do
    opts =
      Keyword.validate!(opts, [
        :ledger_hash,
        :ledger_index,
        :limit,
        :marker,
        binary: false,
        forward: false,
        index_min: index_min,
        index_max: index_max
      ])

    xrpl("account_tx", Map.merge(%{account: account}, Map.new(opts)))
  end

  def account_tx!(account, index_min \\ -1, index_max \\ -1, opts \\ []),
    do: unwrap_or_raise(account_tx(account, index_min, index_max, opts))

  @doc """
  The gateway_balances command calculates the total balances issued by a given account, optionally excluding amounts held by operational addresses.

  Ref: https://xrpl.org/gateway_balances.html
  """
  @spec gateway_balance(String.t(), Keyword.t()) :: Tesla.Env.result()
  def gateway_balance(account, opts \\ []) do
    opts = Keyword.validate!(opts, [:strict, :hotwallet, :ledger_hash, :ledger_index])

    xrpl("gateway_balances", Map.merge(%{account: account}, Map.new(opts)))
  end

  def gateway_balance!(account, opts \\ []),
    do: unwrap_or_raise(gateway_balance(account, opts))

  @doc """
  The noripple_check command provides a quick way to check the status of the Default Ripple field for an account and the No Ripple flag of its trust lines, compared with the recommended settings.

  Ref: https://xrpl.org/noripple_check.html
  """
  def noripple_check(account, role \\ "user", opts \\ []) do
    opts = Keyword.validate!(opts, [:ledger_hash, :ledger_index, transactions: false, limit: 300])

    xrpl("noripple_check", Map.merge(%{account: account, role: role}, Map.new(opts)))
  end

  def noripple_check!(account, role \\ "user", opts \\ []),
    do: unwrap_or_raise(noripple_check(account, role, opts))
end
