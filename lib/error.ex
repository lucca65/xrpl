defmodule XRPL.Error do
  require Logger

  defexception [:reason, :url]

  def exception(reason, url \\ "")
  def exception(reason, url), do: %__MODULE__{reason: reason, url: url}

  def message(%__MODULE__{reason: reason, url: url}) do
    message = "EOSRPC call failed: #{reason}"
    Logger.error(message, url: url)
    message
  end
end
