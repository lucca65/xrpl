defmodule XRPL.LedgerTest do
  use ExUnit.Case

  alias XRPL.Ledger

  describe "ledger/2" do
    test "returns ledger info for a given index" do
      assert({:ok, %Tesla.Env{} = env} = Ledger.ledger(ledger_index: "validated"))

      assert env.status == 200
    end

    test "returns error for invalid index" do
      assert {:error, %Tesla.Env{} = env} = Ledger.ledger(ledger_index: "invalid_index")
      assert(env.status == 200)
      assert env.body["result"]["error"] == "invalidParams"
    end
  end

  describe "ledger_closed/0" do
    test "returns ledger info for the latest closed index" do
      assert {:ok, %Tesla.Env{} = env} = Ledger.ledger_closed()
      assert env.body["result"]["status"] == "success"
    end
  end

  describe "ledger_current/0" do
    test "returns current in-progress index" do
      assert {:ok, %Tesla.Env{} = env} = Ledger.ledger_current()
      assert env.body["result"]["status"] == "success"
    end
  end

  describe "ledger_data/1" do
    test "returns contents for a given ledger index" do
      assert {:ok, %Tesla.Env{} = env} = Ledger.ledger_data(ledger_index: "validated")
      assert env.body["result"]["status"] == "success"
    end

    test "uses type to filter results" do
      assert {:ok, %Tesla.Env{} = env} =
               Ledger.ledger_data(ledger_index: "validated", type: "account")

      assert env.body["result"]["status"] == "success"
    end

    test "invalid type return error" do
      assert {:error, "Invalid ledger type"} =
               Ledger.ledger_data(ledger_index: "validated", type: "invalid_type")
    end
  end
end
