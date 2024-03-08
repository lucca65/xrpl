defmodule XRPL.LedgerEntryTest do
  use ExUnit.Case

  alias XRPL.LedgerEntry

  @index "7DB0788C020F02780A673DC74757F23823FA3014C1866E72CC4CD8B226CD6EF4"

  describe "by_id/1" do
    test "returns ledger entry for a given index" do
      assert(
        {:ok, %Tesla.Env{status: 200}} =
          LedgerEntry.by_id(%{
            ledger_index: "validated",
            index: @index
          })
      )
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = LedgerEntry.by_id(%{})
      assert errors == [index: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        LedgerEntry.by_id!(%{})
      end
    end
  end

  describe "account_root/1" do
    test "returns account root for a given index" do
      assert(
        {:ok, %Tesla.Env{status: 200}} =
          LedgerEntry.account_root(%{ledger_index: "validated", account_root: "rf1BiGeXwwQoi8Z2ueFYTEXSwuJYfV2Jpn"})
      )
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = LedgerEntry.account_root(%{})
      assert errors == [account_root: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        LedgerEntry.account_root!(%{})
      end
    end
  end

  describe "amm/1" do
    # As of march 3rd, AMM is not enabled in the mainnet
    @tag :skip
    test "returns ledger entry for a given index" do
      assert(
        {:ok, %Tesla.Env{status: 200}} =
          LedgerEntry.amm(%{
            amm: %{
              asset: %{currency: "XRP"},
              asset2: %{currency: "FOO", issuer: "rf1BiGeXwwQoi8Z2ueFYTEXSwuJYfV2Jpn"}
            },
            ledger_index: "validated"
          })
      )
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = LedgerEntry.amm(%{})
      assert errors == [amm: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        LedgerEntry.amm!(%{})
      end
    end
  end

  describe "directory_node/1" do
    test "search using directory object with optional fields" do
      assert(
        {:ok, %Tesla.Env{status: 200}} =
          LedgerEntry.directory_node(%{
            ledger_index: "validated",
            directory: %{
              owner: "rf1BiGeXwwQoi8Z2ueFYTEXSwuJYfV2Jpn",
              sub_index: 0
            }
          })
      )
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = LedgerEntry.directory_node(%{})
      assert errors == [directory: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        LedgerEntry.directory_node!(%{})
      end
    end
  end

  describe "offer/1" do
    test "returns offer by sending offer object" do
      assert(
        {:ok, %Tesla.Env{status: 200}} =
          LedgerEntry.offer(%{
            ledger_index: "validated",
            offer: %{account: "rf1BiGeXwwQoi8Z2ueFYTEXSwuJYfV2Jpn", seq: 359}
          })
      )
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = LedgerEntry.offer(%{})
      assert errors == [offer: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        LedgerEntry.offer!(%{})
      end
    end
  end

  describe "ripple_state/1" do
    test "returns ripple state by sending ripple state object" do
      assert(
        {:ok, %Tesla.Env{status: 200}} =
          LedgerEntry.ripple_state(%{
            ripple_state: %{
              accounts: [
                "rf1BiGeXwwQoi8Z2ueFYTEXSwuJYfV2Jpn",
                "rsA2LpzuawewSBQXkiju3YQTMzW13pAAdW"
              ],
              currency: "USD"
            },
            ledger_index: "validated"
          })
      )
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = LedgerEntry.ripple_state(%{})
      assert errors == [ripple_state: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        LedgerEntry.ripple_state!(%{})
      end
    end
  end

  describe "check/1" do
    test "returns check by sending check object" do
      assert(
        {:ok, %Tesla.Env{status: 200}} =
          LedgerEntry.check(%{
            ledger_index: "validated",
            check: "C4A46CCD8F096E994C4B0DEAB6CE98E722FC17D7944C28B95127C2659C47CBEB"
          })
      )
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = LedgerEntry.check(%{})
      assert errors == [check: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        LedgerEntry.check!(%{})
      end
    end
  end

  describe "escrow/1" do
    test "escrow/1" do
      assert(
        {:ok, %Tesla.Env{status: 200}} =
          LedgerEntry.escrow(%{
            ledger_index: "validated",
            escrow: %{
              owner: "rL4fPHi2FWGwRGRQSH7gBcxkuo2b9NTjKK",
              seq: 126
            }
          })
      )
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = LedgerEntry.escrow(%{})
      assert errors == [escrow: {"can't be blank", [validation: :required]}]
    end
  end

  describe "payment_channel/1" do
    test "returns payment channel by sending payment channel object" do
      assert(
        {:ok, %Tesla.Env{status: 200}} =
          LedgerEntry.payment_channel(%{
            ledger_index: "validated",
            payment_channel: "C7F634794B79DB40E87179A9D1BF05D05797AE7E92DF8E93FD6656E8C4BE3AE7"
          })
      )
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = LedgerEntry.payment_channel(%{})
      assert errors == [payment_channel: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        LedgerEntry.payment_channel!(%{})
      end
    end
  end

  describe "deposit_preauth/1" do
    test "deposit_preauth/1" do
      assert(
        {:ok, %Tesla.Env{status: 200}} =
          LedgerEntry.deposit_preauth(%{
            ledger_index: "validated",
            deposit_preauth: %{
              owner: "rf1BiGeXwwQoi8Z2ueFYTEXSwuJYfV2Jpn",
              authorized: "ra5nK24KXen9AHvsdFTKHSANinZseWnPcX"
            }
          })
      )
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = LedgerEntry.deposit_preauth(%{})
      assert errors == [deposit_preauth: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        LedgerEntry.deposit_preauth!(%{})
      end
    end
  end

  describe "ticket/1" do
    test "ticket/1" do
      assert(
        {:ok, %Tesla.Env{status: 200}} =
          LedgerEntry.ticket(%{
            ticket: %{
              account: "rf1BiGeXwwQoi8Z2ueFYTEXSwuJYfV2Jpn",
              ticket_seq: 389
            },
            ledger_index: "validated"
          })
      )
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = LedgerEntry.ticket(%{})
      assert errors == [ticket: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        LedgerEntry.ticket!(%{})
      end
    end
  end

  describe "nft_page/1" do
    test "returns nft by sending ledger entry ID" do
      assert(
        {:ok, %Tesla.Env{status: 200}} =
          LedgerEntry.nft_page(%{
            ledger_index: "validated",
            nft_page: "255DD86DDF59D778081A06D02701E9B2C9F4F01DFFFFFFFFFFFFFFFFFFFFFFFF"
          })
      )
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = LedgerEntry.nft_page(%{})
      assert errors == [nft_page: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        LedgerEntry.nft_page!(%{})
      end
    end
  end
end
