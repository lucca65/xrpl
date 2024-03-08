defmodule XRPL.ServerInfoTest do
  use ExUnit.Case

  alias XRPL.ServerInfo

  describe "fee/0" do
    test "fee/0" do
      assert {:ok, %Tesla.Env{status: 200}} = ServerInfo.fee()
    end
  end

  describe "manifest/1" do
    test "manifest/1" do
      assert {:ok, %Tesla.Env{status: 200}} =
               ServerInfo.manifest(%{public_key: "nHUFE9prPXPrHcG3SkwP1UzAQbSphqyQkQK9ATXLZsfkezhhda3p"})
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = ServerInfo.manifest(%{})

      assert Enum.sort(errors) == [
               public_key: {"can't be blank", [validation: :required]}
             ]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        ServerInfo.manifest!(%{})
      end
    end
  end

  describe "server_definitions/0" do
    test "server_definitions/0" do
      assert {:ok, %Tesla.Env{status: 200}} = ServerInfo.server_definitions()
    end
  end

  describe "server_info/0" do
    test "server_info/0" do
      assert {:ok, %Tesla.Env{status: 200}} = ServerInfo.server_info()
    end
  end

  describe "server_state/1" do
    test "server_state/1" do
      assert {:ok, %Tesla.Env{status: 200}} = ServerInfo.server_state(%{counters: true})
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} =
               ServerInfo.server_state(%{ledger_index: 1})

      assert Enum.sort(errors) == [
               ledger_index: {"is invalid", [type: :string, validation: :cast]}
             ]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        ServerInfo.server_state!(%{ledger_index: 1})
      end
    end
  end
end
