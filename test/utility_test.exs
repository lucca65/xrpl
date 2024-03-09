defmodule XRPL.UtilityTest do
  use ExUnit.Case

  import XRPL.Utility

  describe "ping/0" do
    test "ping/0" do
      assert {:ok, %Tesla.Env{status: 200}} = ping()
    end
  end

  describe "random/0" do
    test "random/0" do
      assert {:ok, %Tesla.Env{status: 200}} = random()
    end
  end
end
