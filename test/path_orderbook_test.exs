defmodule XRPL.PathOrderbookTest do
  use ExUnit.Case

  alias XRPL.PathOrderbook

  describe "amm_info/1" do
    # As of march 3rd, AMM is not enabled in the mainnet
    @tag :skip
    test "use asset as string and asset2 as string" do
      assert {:ok, %Tesla.Env{status: 200}} =
               PathOrderbook.amm_info(%{
                 asset: "XRP",
                 asset2: "FOO"
               })
    end

    # As of march 3rd, AMM is not enabled in the mainnet
    @tag :skip
    test "use asset as string and asset2 as object" do
      assert {:ok, %Tesla.Env{status: 200}} =
               PathOrderbook.amm_info(%{
                 asset: "XRP",
                 asset2: %{currency: "FOO", issuer: "rP9jPyP5kyvFRb6ZiRghAGw5u8SGAmU4bd"}
               })
    end

    # As of march 3rd, AMM is not enabled in the mainnet
    @tag :skip
    test "use asset as object and asset2 as object" do
      assert {:ok, %Tesla.Env{status: 200}} =
               PathOrderbook.amm_info(%{
                 asset: %{currency: "XRP"},
                 asset2: %{currency: "FOO", issuer: "rP9jPyP5kyvFRb6ZiRghAGw5u8SGAmU4bd"}
               })
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, :invalid_params} = PathOrderbook.amm_info(%{})
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        PathOrderbook.amm_info!(%{})
      end
    end
  end

  describe "book_offers/1" do
    test "book_offers" do
      assert {:ok, %Tesla.Env{status: 200}} =
               PathOrderbook.book_offers(%{
                 taker: "r9cZA1mLK5R5Am25ArfXFmqgNwjZgnfk59",
                 taker_gets: %{
                   currency: "XRP"
                 },
                 taker_pays: %{
                   currency: "USD",
                   issuer: "rvYAfWj5gh67oV6fW32ZzP3Aw4Eubs59B"
                 },
                 limit: 10
               })
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = PathOrderbook.book_offers(%{})

      assert errors == [
               taker_pays: {"can't be blank", [validation: :required]},
               taker_gets: {"can't be blank", [validation: :required]}
             ]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        PathOrderbook.book_offers!(%{})
      end
    end
  end

  describe "deposit_authorized/1" do
    # Test failing in the original documentation as well
    @tag :skip
    test "deposit_authorized/1" do
      assert {:ok, %Tesla.Env{status: 200}} =
               PathOrderbook.deposit_authorized(%{
                 source_account: "rEhxGqkqPPSxQ3P25J66ft5TwpzV14k2de",
                 destination_account: "rsUiUMpnrgxQp24dJYZDhmV4bE3aBtQyt8",
                 ledger_index: "validated"
               })
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = PathOrderbook.deposit_authorized(%{})

      assert Enum.sort(errors) == [
               destination_account: {"can't be blank", [validation: :required]},
               source_account: {"can't be blank", [validation: :required]}
             ]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        PathOrderbook.deposit_authorized!(%{})
      end
    end
  end

  describe "nft_buy_offers/1" do
    # Test failing in the original documentation as well
    @tag :skip
    test "uses ledger_index" do
      assert {:ok, %Tesla.Env{status: 200}} =
               PathOrderbook.nft_buy_offers(%{
                 nft_id: "00090000D0B007439B080E9B05BF62403911301A7B1F0CFAA048C0A200000007",
                 ledger_index: "validated"
               })
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = PathOrderbook.nft_buy_offers(%{})

      assert errors == [nft_id: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        PathOrderbook.nft_buy_offers!(%{})
      end
    end
  end

  describe "nft_sell_offers/1" do
    # Test failing in the original documentation as well
    @tag :skip
    test "uses ledger_index" do
      assert {:ok, %Tesla.Env{status: 200}} =
               PathOrderbook.nft_sell_offers(%{
                 nft_id: "00090000D0B007439B080E9B05BF62403911301A7B1F0CFAA048C0A200000007",
                 ledger_index: "validated"
               })
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = PathOrderbook.nft_sell_offers(%{})

      assert errors == [
               nft_id: {"can't be blank", [validation: :required]}
             ]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        PathOrderbook.nft_sell_offers!(%{})
      end
    end
  end

  describe "ripple_path_find" do
    test "ripple_path_find/1" do
      assert {:ok, %Tesla.Env{status: 200}} =
               PathOrderbook.ripple_path_find(%{
                 source_account: "r9cZA1mLK5R5Am25ArfXFmqgNwjZgnfk59",
                 destination_account: "r9cZA1mLK5R5Am25ArfXFmqgNwjZgnfk59",
                 destination_amount: %{
                   currency: "USD",
                   issuer: "rvYAfWj5gh67oV6fW32ZzP3Aw4Eubs59B",
                   value: "100"
                 }
               })
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = PathOrderbook.ripple_path_find(%{})

      assert Enum.sort(errors) == [
               {:destination_account, {"can't be blank", [validation: :required]}},
               {:destination_amount, {"can't be blank", [validation: :required]}},
               {:source_account, {"can't be blank", [validation: :required]}}
             ]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        PathOrderbook.ripple_path_find!(%{})
      end
    end
  end
end
