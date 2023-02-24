defmodule XRPL do
  @moduledoc """
  XRPL is a library for interacting with the XRP Ledger.
  """

  defmacro unwrap_or_raise(call) do
    quote do
      case unquote(call) do
        {:ok, value} -> value
        {:error, env} -> raise XRPL.Error, reason: env.body, url: env.url
      end
    end
  end
end
