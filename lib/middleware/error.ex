defmodule XRPL.Middleware.Error do
  @moduledoc """
  Makes requests that don't respond to HTTP Success codes to return as a error


  ### Example usage
  ```
  defmodule MyClient do
    use Tesla

    plug(XRPL.Middleware.Error)
  end
  ```
  """

  @behaviour Tesla.Middleware

  def call(env, next, _options) do
    env
    |> Tesla.run(next)
    |> check_status()
    |> check_body()
  end

  def check_status({:ok, env}) do
    case env.status do
      s when s in [200, 201, 202, 203, 204] ->
        {:ok, env}

      _ ->
        {:error, env}
    end
  end

  def check_body({:error, error}), do: {:error, error}

  def check_body({:ok, env}) do
    if Map.has_key?(env.body["result"], "error") do
      {:error, env}
    else
      {:ok, env}
    end
  end
end
