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
          LedgerEntry.account_root("rheRQ63CzckoqrV1nDZG7fYDjMjGHUH7SF", "validated")
      )

      assert env.status == 200
    end
  end

  describe "amm/3" do
    test "returns ledger entry for a given index" do
      assert(
        {:ok, %Tesla.Env{} = env} =
          LedgerEntry.amm(
            "validated",
            "XRP",
            "FMM",
            "rMuA7vLhXgZDSkC2AfeUu52rm18yAmcfme"
          )
      )

      assert env.status == 200
    end
  end

  describe "directory_node/2" do
    test "search by directory using string object ID" do
      assert(
        {:ok, %Tesla.Env{} = env} =
          LedgerEntry.directory_node("validated", "rMuA7vLhXgZDSkC2AfeUu52rm18yAmcfme")
      )

      assert env.status == 200
    end

    test "search using directory object with optional fields" do
      assert(
        {:ok, %Tesla.Env{} = env} =
          LedgerEntry.directory_node("validated",
            owner: "rMuA7vLhXgZDSkC2AfeUu52rm18yAmcfme",
            sub_index: 0
          )
      )

      assert env.status == 200
    end
  end

  describe "offer/2" do
    test "returns offer by sending an ledger entry ID" do
      assert(
        {:ok, %Tesla.Env{} = env} =
          LedgerEntry.offer("validated", "rMuA7vLhXgZDSkC2AfeUu52rm18yAmcfme")
      )

      assert env.status == 200
    end

    test "returns offer by sending offer object" do
      assert(
        {:ok, %Tesla.Env{} = env} =
          LedgerEntry.offer("validated", "rMuA7vLhXgZDSkC2AfeUu52rm18yAmcfme", 3)
      )

      assert env.status == 200
    end
  end
end
