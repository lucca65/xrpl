defmodule XRPL.PathOrderbookTest do
  use ExUnit.Case

  alias XRPL.PathOrderbook

  describe "amm_info/2 and amm/3" do
    test "use amm_account address" do
      assert_raise RuntimeError, fn ->
        PathOrderbook.amm_info(nil, nil, nil)
      end
    end

    test "use asset and asset1" do
      assert_raise RuntimeError, fn ->
        PathOrderbook.amm_info(nil, nil, nil)
      end
    end
  end

  describe "book_offers/3" do
    test "use taker_gets_currency, taker_pays_currency, taker_pays_issuer" do
      assert {:ok, %Tesla.Env{status: 200}} =
               PathOrderbook.book_offers("XRP", "USD", "rvYAfWj5gh67oV6fW32ZzP3Aw4Eubs59B")
    end
  end

  describe "deposit_authorized/2" do
    # Test failing in the original documentation as well
    @tag :skip
    test "send optional ledger_index" do
      assert {:ok, %Tesla.Env{status: 200}} =
               PathOrderbook.deposit_authorized(
                 "rEhxGqkqPPSxQ3P25J66ft5TwpzV14k2de",
                 "rsUiUMpnrgxQp24dJYZDhmV4bE3aBtQyt8",
                 "validated"
               )
    end
  end

  describe "nft_buy_offers/1" do
    # Test failing in the original documentation as well
    @tag :skip
    test "uses ledger_index" do
      assert {:ok, %Tesla.Env{status: 200}} =
               PathOrderbook.nft_buy_offers(
                 "00090000D0B007439B080E9B05BF62403911301A7B1F0CFAA048C0A200000007",
                 "validated"
               )
    end
  end

  describe "nft_sell_offers/1" do
    # Test failing in the original documentation as well
    @tag :skip
    test "uses ledger_index" do
      assert {:ok, %Tesla.Env{status: 200}} =
               PathOrderbook.nft_sell_offers(
                 "00090000D0B007439B080E9B05BF62403911301A7B1F0CFAA048C0A200000007",
                 "validated"
               )
    end
  end
end
