defmodule XRPL.ClioTest do
  use ExUnit.Case, async: true

  alias XRPL.Clio

  describe "server_info/0" do
    test "server_info/0" do
      assert {:ok, %{"info" => _}} = Clio.server_info()
    end
  end

  describe "ledger/1" do
    test "validated ledger" do
      assert {:ok, %{"ledger" => _, "ledger_hash" => _}} =
               Clio.ledger(%{ledger_index: "validated"})
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
    test "use an existing nft_id" do
      nft_id = "00080000B4F4AFC5FBCBD76873F18006173D2193467D3EE70000099B00000000"

      assert {:ok, %{"nft_id" => received_nft_id}} =
               Clio.nft_history(%{nft_id: nft_id})

      assert(nft_id == received_nft_id)
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
      nft_id = "000817024409AFED2C9EC5604D4095464C0F0DC015198D2F3E04AFA90000090D"

      assert {:ok, %{"nft_id" => received_nft_id}} =
               Clio.nft_info(%{nft_id: nft_id})

      assert nft_id == received_nft_id
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
