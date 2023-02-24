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
  Returns information about an account.

  ## Sample from documentation https://xrpl.org/account_info.html

  {
    "method": "account_info",
    "params": [
        {
            "account": "rG1QQv2nh2gr7RCZ1P8YYcBUKCCN633jCn",
            "strict": true,
            "ledger_index": "current",
            "queue": true
        }
    ]
  }
  """
  def account_info(public_key) do
    post(
      "/",
      %{
        method: "account_info",
        params: [
          %{
            account: public_key,
            strict: true,
            ledger_index: "current",
            queue: true
          }
        ]
      }
    )
  end

  def account_info!(public_key), do: unwrap_or_raise(account_info(public_key))
end
