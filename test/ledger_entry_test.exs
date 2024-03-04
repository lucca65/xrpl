defmodule XRPLTest.LedgerEntryTest do
  use ExUnit.Case

  alias XRPL.LedgerEntry

  @index "7DB0788C020F02780A673DC74757F23823FA3014C1866E72CC4CD8B226CD6EF4"

  describe "by_id/2" do
    test "returns ledger entry for a given index" do
      assert(
        {:ok, %Tesla.Env{} = env} =
          LedgerEntry.by_id(
            "validated",
            @index
          )
      )

      assert env.status == 200
    end
  end

  describe "account_root/2" do
    test "returns account root for a given index" do
      assert(
        {:ok, %Tesla.Env{} = env} =
          LedgerEntry.account_root("validated", "rf1BiGeXwwQoi8Z2ueFYTEXSwuJYfV2Jpn")
      )

      assert env.status == 200
    end
  end

  describe "amm/3" do
    # As of march 3rd, AMM is not enabled in the mainnet
    @tag :skip
    test "returns ledger entry by using object ID" do
      assert(
        {:ok, %Tesla.Env{} = env} =
          LedgerEntry.amm(
            "current",
            "C525F9E300010000"
          )
      )

      assert env.status == 200
    end

    # As of march 3rd, AMM is not enabled in the mainnet
    @tag :skip
    test "returns ledger entry for a given index" do
      assert(
        {:ok, %Tesla.Env{} = env} =
          LedgerEntry.amm(
            "current",
            "XRP",
            "FOO",
            "rf1BiGeXwwQoi8Z2ueFYTEXSwuJYfV2Jpn"
          )
      )

      assert env.status == 200
    end
  end

  describe "directory_node/2" do
    test "search using directory object with optional fields" do
      assert(
        {:ok, %Tesla.Env{} = env} =
          LedgerEntry.directory_node("validated",
            owner: "rf1BiGeXwwQoi8Z2ueFYTEXSwuJYfV2Jpn",
            sub_index: 0
          )
      )

      assert env.status == 200
    end
  end

  describe "offer/2" do
    test "returns offer by sending offer object" do
      assert(
        {:ok, %Tesla.Env{} = env} =
          LedgerEntry.offer("validated", "rf1BiGeXwwQoi8Z2ueFYTEXSwuJYfV2Jpn", 359)
      )

      assert env.status == 200
    end
  end

  describe "ripple_state/3" do
    test "returns ripple state by sending ripple state object" do
      assert(
        {:ok, %Tesla.Env{} = env} =
          LedgerEntry.ripple_state(
            "validated",
            [
              "rf1BiGeXwwQoi8Z2ueFYTEXSwuJYfV2Jpn",
              "rsA2LpzuawewSBQXkiju3YQTMzW13pAAdW"
            ],
            "USD"
          )
      )

      assert env.status == 200
    end
  end

  describe "check/2" do
    test "returns check by sending check object" do
      assert(
        {:ok, %Tesla.Env{} = env} =
          LedgerEntry.check("validated", "C4A46CCD8F096E994C4B0DEAB6CE98E722FC17D7944C28B95127C2659C47CBEB")
      )

      assert env.status == 200
    end
  end

  describe "escrow/2 and escrow/3" do
    test "escrow/2" do
      assert(
        {:ok, %Tesla.Env{} = env} =
          LedgerEntry.escrow(
            "validated",
            "917ACF1324F06D19239A03E4A6A3FE24F9313BB23337ECB801BDAD013BE27F83"
          )
      )

      assert env.status == 200
    end

    test "escrow/3" do
      assert(
        {:ok, %Tesla.Env{} = env} =
          LedgerEntry.escrow(
            "validated",
            "rL4fPHi2FWGwRGRQSH7gBcxkuo2b9NTjKK",
            126
          )
      )

      assert env.status == 200
    end
  end

  describe "payment_channel/2" do
    test "returns payment channel by sending payment channel object" do
      assert(
        {:ok, %Tesla.Env{} = env} =
          LedgerEntry.payment_channel(
            "validated",
            "C7F634794B79DB40E87179A9D1BF05D05797AE7E92DF8E93FD6656E8C4BE3AE7"
          )
      )

      assert env.status == 200
    end
  end

  describe "deposit_preauth/2 and deposit_preauth/3" do
    test "deposit_preauth/2" do
      assert(
        {:ok, %Tesla.Env{} = env} =
          LedgerEntry.deposit_preauth(
            "validated",
            "A43898B685C450DE8E194B24D9D54E62530536A770CCB311BFEE15A27381ABB2"
          )
      )

      assert env.status == 200
    end

    test "deposit_preauth/3" do
      assert(
        {:ok, %Tesla.Env{} = env} =
          LedgerEntry.deposit_preauth(
            "validated",
            "rf1BiGeXwwQoi8Z2ueFYTEXSwuJYfV2Jpn",
            "ra5nK24KXen9AHvsdFTKHSANinZseWnPcX"
          )
      )

      assert env.status == 200
    end
  end

  describe "ticket/2 and ticket/3" do
    test "ticket/2" do
      assert(
        {:ok, %Tesla.Env{} = env} =
          LedgerEntry.ticket("validated", "B603682BC36F474F708E1A150B7C034C6C13D838C3F2F135CDB7BEA6E5B5ACEF")
      )

      assert env.status == 200
    end

    test "ticket/3" do
      assert({:ok, %Tesla.Env{} = env} = LedgerEntry.ticket("validated", "rf1BiGeXwwQoi8Z2ueFYTEXSwuJYfV2Jpn", 389))

      assert env.status == 200
    end
  end

  describe "nft_page/2" do
    test "returns nft by sending ledger entry ID" do
      assert(
        {:ok, %Tesla.Env{} = env} =
          LedgerEntry.nft_page("validated", "255DD86DDF59D778081A06D02701E9B2C9F4F01DFFFFFFFFFFFFFFFFFFFFFFFF")
      )

      assert env.status == 200
    end
  end
end
