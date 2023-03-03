defmodule XRPL.Account do
  @moduledoc """
  XRPL.Account is a module to interact with accounts on the XRP Ledger.

  It follows https://xrpl.org/account-methods.html
  """

  use Tesla

  import XRPL

  plug(Tesla.Middleware.BaseUrl, Application.get_env(:xrpl, :devnet))
  plug(Tesla.Middleware.JSON)
  plug(XRPL.Middleware.Error)

  @doc """
  The account_channels method returns information about an account's Payment Channels.
  This includes only channels where the specified account is the channel's source, not the destination. (A channel's "source" and "owner" are the same.)
  All information retrieved is relative to a particular version of the ledger.

  Ref: https://xrpl.org/account_channels.html
  """
  def account_channels(account, destination_account) do
    post(
      "/",
      %{
        method: "account_channels",
        params: [
          %{
            account: account,
            destination_account: destination_account,
            ledger_index: "validated"
          }
        ]
      }
    )
  end

  def account_channels!(account, destination_account),
    do: unwrap_or_raise(account_channels(account, destination_account))

  @doc """
  The account_currencies command retrieves a list of currencies that an account can send or receive, based on its trust lines

  Ref: https://xrpl.org/account_currencies.html
  """
  def account_currencies(account) do
    post(
      "/",
      %{
        method: "account_currencies",
        params: [
          %{
            account: account,
            account_index: 0,
            ledger_index: "validated",
            strict: true
          }
        ]
      }
    )
  end

  def account_currencies!(account), do: unwrap_or_raise(account_currencies(account))

  @doc """
  The account_info command retrieves information about an account, its activity, and its XRP balance.
  All information retrieved is relative to a particular version of the ledger.

  Ref: https://xrpl.org/account_info.html
  """
  def account_info(account) do
    post(
      "/",
      %{
        method: "account_info",
        params: [
          %{
            account: account,
            strict: true,
            ledger_index: "current",
            queue: true
          }
        ]
      }
    )
  end

  def account_info!(account), do: unwrap_or_raise(account_info(account))

  @doc """
  The account_lines command returns information about an account's trust lines, including balances in all non-XRP currencies and assets.
  All information retrieved is relative to a particular version of the ledger.
  """
  def account_lines(account) do
    post(
      "/",
      %{
        method: "account_lines",
        params: [
          %{
            account: account
          }
        ]
      }
    )
  end

  def account_lines!(account), do: unwrap_or_raise(account_lines(account))

  @doc """
  The account_nfts method returns a list of NFToken objects for the specified account.
  """
  def account_nfts(account) do
    post(
      "/",
      %{
        method: "account_nfts",
        params: [
          %{
            account: account,
            ledger_index: "validated"
          }
        ]
      }
    )
  end

  def account_nfts!(account), do: unwrap_or_raise(account_nfts(account))

  @doc """
  The account_objects command returns the raw ledger format for all objects owned by an account.
  For a higher-level view of an account's trust lines and balances, see the account_lines method instead.

  Ref: https://xrpl.org/account_objects.html
  """
  def account_objects(account, limit \\ 10) do
    post(
      "/",
      %{
        method: "account_objects",
        params: [
          %{
            account: account,
            ledger_index: "validated",
            type: "state",
            deletion_blockers_only: false,
            limit: limit
          }
        ]
      }
    )
  end

  def account_objects!(account, limit \\ 10),
    do: unwrap_or_raise(account_objects(account, limit))

  @doc """
  The account_offers method retrieves a list of offers made by a given account that are outstanding as of a particular ledger version.

  Ref: https://xrpl.org/account_offers.html
  """
  def account_offers(account) do
    post(
      "/",
      %{
        method: "account_offers",
        params: [
          %{
            account: account
          }
        ]
      }
    )
  end

  def account_offers!(account), do: unwrap_or_raise(account_offers(account))

  @doc """
  The account_tx method retrieves a list of transactions that involved the specified account.

  Ref: https://xrpl.org/account_tx.html
  """
  def account_tx(account, index_min \\ -1, index_max \\ -1, limit \\ 10) do
    post(
      "/",
      %{
        method: "account_tx",
        params: [
          %{
            account: account,
            ledger_index_min: index_min,
            ledger_index_max: index_max,
            binary: false,
            forward: true,
            limit: limit
          }
        ]
      }
    )
  end

  def account_tx!(account, index_min \\ -1, index_max \\ -1, limit \\ 10),
    do: unwrap_or_raise(account_tx(account, index_min, index_max, limit))

  @doc """
  The gateway_balances command calculates the total balances issued by a given account, optionally excluding amounts held by operational addresses.

  Ref: https://xrpl.org/gateway_balances.html
  """
  def gateway_balance(account, hotwallet \\ []) do
    post(
      "/",
      %{
        method: "gateway_balances",
        params: [
          %{
            account: account,
            hotwallet: hotwallet,
            strict: true,
            ledger_index: "validated"
          }
        ]
      }
    )
  end

  def gateway_balance!(account, hotwallet \\ []),
    do: unwrap_or_raise(gateway_balance(account, hotwallet))

  @doc """
  The noripple_check command provides a quick way to check the status of the Default Ripple field for an account and the No Ripple flag of its trust lines, compared with the recommended settings.

  Ref: https://xrpl.org/noripple_check.html
  """
  def noripple_check(account, role \\ "gateway", limit \\ 2) do
    post(
      "/",
      %{
        method: "noripple_check",
        params: [
          %{
            account: account,
            ledger_index: "current",
            limit: limit,
            role: role,
            transactions: true
          }
        ]
      }
    )
  end

  def noripple_check!(account, role \\ "gateway", limit \\ 2),
    do: unwrap_or_raise(noripple_check(account, role, limit))
end
