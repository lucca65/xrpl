defmodule XRPLTest.LedgerTest do
  use ExUnit.Case

  alias XRPL.Ledger

  describe "ledger/2" do
    test "returns ledger info for a given index" do
      assert({:ok, %Tesla.Env{} = env} = Ledger.ledger(ledger_index: 12_345))

      assert env.status == 200
      assert env.body["result"]["ledger_index"] == 12_345
    end

    test "returns error for invalid index" do
      assert {:error, %Tesla.Env{} = env} = Ledger.ledger(ledger_index: "invalid_index")

      assert(env.status == 200)

      assert env.body["result"]["error"] == "invalidParams"
    end
  end
end
