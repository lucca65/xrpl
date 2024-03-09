defmodule XRPL.Utility do
  @moduledoc """
  Use these methods to perform convenient tasks, such as ping and random number generation.

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/utility-methods/
  """

  use XRPL

  def ping, do: xrpl("ping", %{})
  def ping!, do: unwrap_or_raise(ping())

  defparams("ping") do
  end

  def random, do: xrpl("random", %{})
  def random!, do: unwrap_or_raise(random())

  defparams "random" do
  end
end
