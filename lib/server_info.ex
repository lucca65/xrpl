defmodule XRPL.ServerInfo do
  @moduledoc """
  XRPL.ServerInfo is a module to interact with server_info modules on the XRP Ledger.

  Use these methods to retrieve information about the current state of the rippled server.

  Official documentation: https://xrpl.org/server-info-methods.html
  """

  use XRPL

  @doc """
  The fee command reports the current state of the open-ledger requirements for the transaction cost. This requires the FeeEscalation amendment to be enabled.

  This is a public command available to unprivileged users.

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/server-info-methods/fee/
  """
  def fee, do: xrpl("fee", %{})
  def fee!, do: unwrap_or_raise(fee())

  defparams "fee" do
  end

  @doc """
  The manifest method reports the current "manifest" information for a given validator public key. The "manifest" is a block of data that authorizes an ephemeral signing key with a signature from the validator's master key pair.

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/server-info-methods/manifest/
  """
  def manifest(params), do: xrpl("manifest", params)
  def manifest!(params), do: unwrap_or_raise(manifest(params))

  defparams "manifest" do
    required(:public_key, :string, format: XRPL.public_key_regex())
  end

  @doc """
  The server_definitions command returns an SDK-compatible definitions.json, generated from the rippled instance currently running. You can use this to query a node in a network, quickly receiving the definitions necessary to serialize/deserialize its binary data.

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/server-info-methods/server-definitions/
  """
  def server_definitions, do: xrpl("server_definitions", %{})

  def server_definitions!, do: unwrap_or_raise(server_definitions())

  defparams "server_definitions" do
  end

  @doc """
  The server_info command asks the server for a human-readable version of various information about the rippled server being queried. For Clio servers, see server_info (Clio) instead.

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/server-info-methods/server-info/
  """
  def server_info, do: xrpl("server_info", %{})
  def server_info!, do: unwrap_or_raise(server_info())

  defparams "server_info" do
    optional(:counters, :boolean, default: false)
  end

  @doc """
  The server_state command asks the server for various machine-readable information about the rippled server's current state. The response is almost the same as the server_info method, but uses units that are easier to process instead of easier to read. (For example, XRP values are given in integer drops instead of scientific notation or decimal values, and time is given in milliseconds instead of seconds.)

  The Clio server does not support server_state directly, but you can ask for the server_state of the rippled server that Clio is connected to. Specify "ledger_index": "current" (WebSocket) or "params": [{"ledger_index": "current"}] (JSON-RPC).

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/server-info-methods/server_state/
  """
  def server_state(params), do: xrpl("server_state", params)
  def server_state!(params), do: unwrap_or_raise(server_state(params))

  defparams "server_state" do
    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
  end
end
