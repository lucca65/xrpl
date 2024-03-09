defmodule XRPL.ClioTest do
  use ExUnit.Case

  alias XRPL.Clio

  describe "server_info/0" do
    test "server_info/0" do
      assert {:ok, %Tesla.Env{status: 200}} = Clio.server_info()
    end
  end

  describe "ledger/1" do
    test "ledger/1" do
      assert {:ok, %Tesla.Env{status: 200}} = Clio.ledger(%{ledger_index: "validated"})
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = Clio.ledger(%{expand: "invalid"})

      assert Enum.sort(errors) == [
               expand: {"is invalid", [{:type, :boolean}, {:validation, :cast}]}
             ]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        Clio.ledger!(%{expand: "invalid"})
      end
    end
  end

  describe "nft_history/1" do
    test "nft_history/1" do
      assert {:ok, %Tesla.Env{status: 200}} =
               Clio.nft_history(%{nft_id: "00080000B4F4AFC5FBCBD76873F18006173D2193467D3EE70000099B00000000"})
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = Clio.nft_history(%{})

      assert errors == [nft_id: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        Clio.nft_history!(%{})
      end
    end
  end

  describe "nft_info/1" do
    test "nft_info/1" do
      assert {:ok, %Tesla.Env{status: 200}} =
               Clio.nft_info(%{nft_id: "000817024409AFED2C9EC5604D4095464C0F0DC015198D2F3E04AFA90000090D"})
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = Clio.nft_info(%{})

      assert errors == [nft_id: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        Clio.nft_info!(%{})
      end
    end
  end
end
