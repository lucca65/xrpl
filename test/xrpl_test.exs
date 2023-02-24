defmodule XrplTest do
  use ExUnit.Case
  doctest Xrpl

  test "greets the world" do
    assert Xrpl.hello() == :world
  end
end
