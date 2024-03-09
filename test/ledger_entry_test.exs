defmodule XRPL.LedgerEntryTest do
  use ExUnit.Case, async: true

  alias XRPL.LedgerEntry

  @index "7DB0788C020F02780A673DC74757F23823FA3014C1866E72CC4CD8B226CD6EF4"

  describe "by_id/1" do
    test "returns ledger entry for a given index" do
      assert(
        {:ok, %{"index" => received_index}} =
          LedgerEntry.by_id(%{
            ledger_index: "validated",
            index: @index
          })
      )

      assert @index == received_index
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
      account = "rf1BiGeXwwQoi8Z2ueFYTEXSwuJYfV2Jpn"

      assert(
        {:ok, %{"node" => %{"Account" => received_account}}} =
          LedgerEntry.account_root(%{ledger_index: "validated", account_root: account})
      )

      assert account == received_account
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
        {:ok, %{"index" => _, "ledger_hash" => _}} =
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
        {:ok, _} =
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
        {:ok, %{"validated" => true, "node" => %{"Balance" => _}}} =
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
      check = "C4A46CCD8F096E994C4B0DEAB6CE98E722FC17D7944C28B95127C2659C47CBEB"

      assert(
        {:ok, %{"node" => %{"index" => received_check}}} =
          LedgerEntry.check(%{
            ledger_index: "validated",
            check: check
          })
      )

      assert check == received_check
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
      account = "rL4fPHi2FWGwRGRQSH7gBcxkuo2b9NTjKK"

      assert(
        {:ok, %{"node" => %{"Account" => received_account}}} =
          LedgerEntry.escrow(%{
            ledger_index: "validated",
            escrow: %{
              owner: account,
              seq: 126
            }
          })
      )

      assert account == received_account
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = LedgerEntry.escrow(%{})
      assert errors == [escrow: {"can't be blank", [validation: :required]}]
    end
  end

  describe "payment_channel/1" do
    test "returns payment channel by sending payment channel object" do
      index = "C7F634794B79DB40E87179A9D1BF05D05797AE7E92DF8E93FD6656E8C4BE3AE7"

      assert(
        {:ok,
         %{
           "node" => %{
             "index" => received_index
           }
         }} =
          LedgerEntry.payment_channel(%{
            ledger_index: "validated",
            payment_channel: index
          })
      )

      assert index == received_index
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
      owner = "rf1BiGeXwwQoi8Z2ueFYTEXSwuJYfV2Jpn"
      authorized = "ra5nK24KXen9AHvsdFTKHSANinZseWnPcX"

      assert(
        {:ok, %{"node" => %{"Account" => received_account, "Authorize" => received_authorized}}} =
          LedgerEntry.deposit_preauth(%{
            ledger_index: "validated",
            deposit_preauth: %{
              owner: owner,
              authorized: authorized
            }
          })
      )

      assert owner == received_account
      assert authorized == received_authorized
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
      account = "rf1BiGeXwwQoi8Z2ueFYTEXSwuJYfV2Jpn"
      seq = 389

      assert(
        {:ok,
         %{
           "node" => %{
             "Account" => received_account,
             "TicketSequence" => received_seq
           }
         }} =
          LedgerEntry.ticket(%{
            ticket: %{
              account: account,
              ticket_seq: seq
            },
            ledger_index: "validated"
          })
      )

      assert account == received_account
      assert seq == received_seq
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
      nft_id = "255DD86DDF59D778081A06D02701E9B2C9F4F01DFFFFFFFFFFFFFFFFFFFFFFFF"

      assert(
        {:ok, %{"node" => %{"NFTokens" => [%{"NFToken" => %{"NFTokenID" => _}} | _]}}} =
          LedgerEntry.nft_page(%{
            ledger_index: "validated",
            nft_page: nft_id
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
