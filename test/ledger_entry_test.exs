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
end
