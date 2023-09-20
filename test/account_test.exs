defmodule XRPLTest.AccountTest do
  use ExUnit.Case

  alias XRPL.Account
  alias XRPL.Account, as: Account

  @account "rh1HPuRVsYYvThxG2Bs1MfjmrVC73S16Fb"
  @destination_account "r9Co1BjUUGcZSxdQ7Zie8dTkXxhs4QhHjo"

  describe "account_info/1" do
    test "returns information about an account" do
      {:ok, response} = Account.account_info(@account)
      assert response.body["result"]["status"] == "success"
    end
  end

  describe "account_lines/1" do
    test "returns information about an account's trust lines" do
      {:ok, response} = Account.account_lines(@account)
      assert response.body["result"]["status"] == "success"
    end
  end

  describe "account_channels/1" do
    test "returns information about an account's Payment Channels" do
      {:ok, response} = Account.account_channels(@account, @destination_account)
      assert response.body["result"]["status"] == "success"
    end
  end

  describe "account_objects/1" do
    test "returns information about an account's objects" do
      {:ok, response} = Account.account_objects(@account)
      assert response.body["result"]["status"] == "success"
    end
  end

  describe "account_offers/1" do
    test "returns information about an account's offers" do
      {:ok, response} = Account.account_offers(@account)
      assert response.body["result"]["status"] == "success"
    end
  end

  describe "account_tx/1" do
    test "returns information about an account's transactions" do
      {:ok, response} = Account.account_tx(@account)
      assert response.body["result"]["status"] == "success"
    end
  end
end
