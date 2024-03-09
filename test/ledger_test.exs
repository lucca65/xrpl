defmodule XRPL.LedgerTest do
  use ExUnit.Case, async: true

  alias XRPL.Ledger

  describe "ledger/2" do
    test "returns ledger info for a given index" do
      assert({:ok, _} = Ledger.ledger(%{ledger_index: "validated"}))
    end

    test "returns error for invalid index" do
      assert {:error, %{errors: errors}} = Ledger.ledger(%{ledger_index: "invalid_index"})

      assert errors == [ledger_index: {"has invalid format", [validation: :format]}]
    end
  end

  describe "ledger_closed/0" do
    test "returns ledger info for the latest closed index" do
      assert {:ok, _} = Ledger.ledger_closed()
    end
  end

  describe "ledger_current/0" do
    test "returns current in-progress index" do
      assert {:ok, _} = Ledger.ledger_current()
    end
  end

  describe "ledger_data/1" do
    test "returns contents for a given ledger index" do
      assert {:ok, _} = Ledger.ledger_data(%{ledger_index: "validated"})
    end

    test "uses type to filter results" do
      assert {:ok, _} =
               Ledger.ledger_data(%{ledger_index: "validated", type: "account"})
    end

    test "invalid type return error" do
      assert {:error, %{errors: [type: {"is invalid", _}]}} =
               Ledger.ledger_data(%{ledger_index: "validated", type: "invalid_type"})
    end
  end
end
