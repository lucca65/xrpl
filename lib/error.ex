defmodule XRPL.Error do
  @moduledoc false
  require Logger

  defexception [:reason, :details]

  @impl true
  def exception({reason, %Ecto.Changeset{} = details}) do
    %__MODULE__{reason: reason, details: mapper(details)}
  end

  def exception({reason, details}) do
    %__MODULE__{reason: reason, details: inspect(details)}
  end

  @impl true
  def message(%__MODULE__{reason: :validation_error, details: details}) do
    message = "XRPL call failed: Invalid params"
    Logger.info(message, details: inspect(details))
    message
  end

  def message(%__MODULE__{reason: :request_error, details: %{body: body, url: url}}) do
    message = "XRPL call failed: Request error"
    Logger.info(message, url: url, body: body)
    message
  end

  defp mapper(%Ecto.Changeset{} = changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", _to_string(value))
      end)
    end)
    |> Enum.reduce("", fn {k, v}, acc ->
      joined_errors = Enum.join(v, "; ")
      "#{acc} #{k}: #{joined_errors}"
    end)
    |> String.trim_leading()
  end

  defp _to_string(val) when is_list(val) do
    Enum.join(val, ",")
  end

  defp _to_string(val), do: to_string(val)
end
