defmodule XRPL.Payment do
  @moduledoc """
  XRPL.Payment is a module to interact with payment modules on the XRP Ledger.

  Payment channels are a tool for facilitating repeated, unidirectional payments, or temporary credit between two parties.
  Use these methods to work with payment channels.

  Official documentation: https://xrpl.org/payment-channel-methods.html
  """

  import XRPL

  def channel_verify(amount, channel_id, signature, public_key) do
    post("/", %{
      method: "channel_verify",
      params: [
        %{
          amount: amount,
          channel_id: channel_id,
          signature: signature,
          public_key: public_key
        }
      ]
    })
  end
end
