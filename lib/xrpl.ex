defmodule XRPL do
  @moduledoc """
  XRPL is a library for interacting with the XRP Ledger.
  """

  use Tesla

  plug(Tesla.Middleware.BaseUrl, Application.get_env(:xrpl, :devnet))
  plug(XRPL.Middleware.Error)
  plug(Tesla.Middleware.JSON)

  defmacro unwrap_or_raise(call) do
    quote do
      case unquote(call) do
        {:ok, value} -> value
        {:error, env} -> raise XRPL.Error, reason: env.body, url: env.url
      end
    end
  end

  @doc """
  Many objects in the XRP Ledger, particularly transactions and ledgers, are uniquely identified by a 256-bit hash value.
  This value is typically calculated as a "SHA-512Half", which calculates a SHA-512 hash from some contents, then takes the first half of the output (That's 256 bits, which is 32 bytes, or 64 characters of the hexadecimal representation).
  Since the hash of an object is derived from the contents in a way that is extremely unlikely to produce collisions, two objects with the same hash can be considered the same.

  Official documentation: https://xrpl.org/basic-data-types.html#hashes
  """
  defguard is_hash(value) when is_binary(value) and byte_size(value) == 64

  defguard is_ledger_index_shortcut(value) when value in ~w(current closed validated)

  @doc """
  Ledger Index is a type on the XRPL blockchain, usually expressed by an Int, a Hash or a String.

  Official documentation: https://xrpl.org/basic-data-types.html#ledger-index
  """
  defguard is_ledger_index(value)
           when is_hash(value) or
                  is_binary(value) or
                  is_integer(value) or
                  is_ledger_index_shortcut(value)

  def xrpl(method, params) do
    post("/", %{method: method, params: [params]})
  end
end
