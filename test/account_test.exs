defmodule XRPL.AccountTest do
  use ExUnit.Case, async: true

  alias XRPL.Account
  alias XRPL.Account, as: Account

  @account "rf1BiGeXwwQoi8Z2ueFYTEXSwuJYfV2Jpn"
  @destination_account "ra5nK24KXen9AHvsdFTKHSANinZseWnPcX"

  describe "account_channels/1" do
    test "returns information about an account's Payment Channels" do
      params = %{account: @account, destination_account: @destination_account}

      assert {:ok, %{"account" => @account}} =
               Account.account_channels(params)
    end

    test "it returns an error if we don't provide the required param" do
      params = %{destination_account: @destination_account}
      assert {:error, %{errors: errors}} = Account.account_channels(params)
      assert errors == [account: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        Account.account_channels!(%{destination_account: @destination_account})
      end
    end
  end

  describe "account_currencies/1" do
    test "returns information about account currencies" do
      assert {:ok, _} =
               Account.account_currencies(%{account: @account})
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = Account.account_currencies(%{})
      assert errors == [account: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        Account.account_currencies!(%{})
      end
    end
  end

  describe "account_info/1" do
    test "returns information about an account" do
      assert {:ok, %{"account_data" => %{"Account" => @account}}} =
               Account.account_info(%{account: @account})
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = Account.account_info(%{})
      assert errors == [account: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        Account.account_info!(%{})
      end

      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        Account.account_info!(%{account: "not_an_account"})
      end
    end
  end

  describe "account_lines/1" do
    test "returns information about an account's trust lines" do
      assert {:ok, %{"account" => @account}} =
               Account.account_lines(%{account: @account})
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = Account.account_lines(%{})
      assert errors == [account: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        Account.account_lines!(%{})
      end
    end
  end

  describe "account_nfts/1" do
    test "returns information about an account's nfts" do
      assert {:ok, %{"account" => @account}} =
               Account.account_nfts(%{account: @account})
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = Account.account_nfts(%{})
      assert errors == [account: {"can't be blank", [validation: :required]}]

      assert {:error, %{errors: errors}} = Account.account_nfts(%{account: "not_an_account"})
      assert errors == [account: {"has invalid format", [validation: :format]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        Account.account_nfts!(%{})
      end
    end
  end

  describe "account_objects/1" do
    test "returns information about an account's objects" do
      assert {:ok, %{"account" => @account}} =
               Account.account_objects(%{account: @account})
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = Account.account_objects(%{})
      assert errors == [account: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        Account.account_objects!(%{})
      end
    end
  end

  describe "account_offers/1" do
    test "returns information about an account's offers" do
      assert {:ok, %{"account" => @account}} =
               Account.account_offers(%{account: @account})
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = Account.account_offers(%{})
      assert errors == [account: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        Account.account_offers!(%{})
      end
    end
  end

  describe "account_tx/1" do
    test "returns information about an account's transactions" do
      assert {:ok, %{"account" => @account}} =
               Account.account_tx(%{account: @account})
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = Account.account_tx(%{})
      assert errors == [account: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        Account.account_tx!(%{})
      end
    end
  end
end
