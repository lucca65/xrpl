defmodule XRPL.UtilityTest do
  use ExUnit.Case, async: true

  import XRPL.Utility

  describe "ping/0" do
    test "ping/0" do
      assert {:ok, %{"status" => "success"}} = ping()
    end
  end

  describe "random/0" do
    test "random/0" do
      assert {:ok, %{"random" => _, "status" => "success"}} = random()
    end
  end
end
