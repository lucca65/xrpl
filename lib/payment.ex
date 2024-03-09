defmodule XRPL.Payment do
  @moduledoc """
  XRPL.Payment is a module to interact with payment modules on the XRP Ledger.

  Payment channels are a tool for facilitating repeated, unidirectional payments, or temporary credit between two parties.
  Use these methods to work with payment channels.

  Official documentation: https://xrpl.org/payment-channel-methods.html
  """

  use XRPL

  @doc """
  The channel_authorize method creates a signature that can be used to redeem a specific amount of XRP from a payment channel.

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/payment-channel-methods/channel_authorize/
  """
  def channel_authorize(%{secret: _} = params) do
    xrpl("channel_authorize", "channel_authorize_with_secret", params)
  end

  def channel_authorize(%{seed: _} = params) do
    xrpl("channel_authorize", "channel_authorize_with_seed", params)
  end

  def channel_authorize(%{seed_hex: _} = params) do
    xrpl("channel_authorize", "channel_authorize_with_seed_hex", params)
  end

  def channel_authorize(%{passphrase: _} = params) do
    xrpl("channel_authorize", "channel_authorize_with_passphrase", params)
  end

  def channel_authorize(_params) do
    {:error, :invalid_params}
  end

  def channel_authorize!(params), do: params |> channel_authorize() |> unwrap_or_raise()

  defparams "channel_authorize_with_secret" do
    required(:channel_id, :string)
    required(:amount, :string)
    required(:secret, :string)
    optional(:key_type, :enum, values: ["ed25519", "secp256k1"], default: "secp256k1")
  end

  defparams "channel_authorize_with_seed" do
    required(:channel_id, :string)
    required(:amount, :string)
    required(:seed, :string)
    optional(:key_type, :enum, values: ["ed25519", "secp256k1"], default: "secp256k1")
  end

  defparams "channel_authorize_with_seed_hex" do
    required(:channel_id, :string)
    required(:amount, :string)
    required(:seed_hex, :string)
    optional(:key_type, :enum, values: ["ed25519", "secp256k1"], default: "secp256k1")
  end

  defparams "channel_authorize_with_passphrase" do
    required(:channel_id, :string)
    required(:amount, :string)
    required(:passphrase, :string)
    optional(:key_type, :enum, values: ["ed25519", "secp256k1"], default: "secp256k1")
  end

  @doc """
  The channel_verify method verifies a signature that can be used to redeem a specific amount of XRP from a payment channel.

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/payment-channel-methods/channel_verify/
  """
  def channel_verify(params) do
    xrpl("channel_verify", params)
  end

  def channel_verify!(params), do: params |> channel_verify() |> unwrap_or_raise()

  defparams "channel_verify" do
    required(:channel_id, :string)
    required(:amount, :string)
    required(:public_key, :string)
    required(:signature, :string)
  end
end
