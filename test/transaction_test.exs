defmodule XRPL.TransactionTest do
  use ExUnit.Case

  alias XRPL.Transaction

  describe "submit/2" do
    test "submits a transaction to the network" do
      assert {:ok, %Tesla.Env{status: 200}} =
               Transaction.submit(%{
                 "tx_blob" =>
                   "1200002280000000240000000361D4838D7EA4C6800000000000000000000000000055534400000000004B4E9C06F24296074F7BC48F92A97916C6DC5EA968400000000000000A732103AB40A0490F9B7ED8DF29D246BF2D6269820A0EE7742ACDD457BEA7C7D0931EDB74473045022100D184EB4AE5956FF600E7536EE459345C7BBCF097A84CC61A93B9AF7197EDB98702201CEA8009B7BEEBAA2AACC0359B41C427C1C5B550A4CA4B80CF2174AF2D6D5DCE81144B4E9C06F24296074F7BC48F92A97916C6DC5EA983143E9D4A2B8AA0780F682D136F7A56D6724EF53754",
                 "fail_hard" => false
               })
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = Transaction.submit(%{})

      assert errors == [tx_blob: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        Transaction.submit!(%{})
      end
    end
  end

  describe "submit_multisigned/1" do
    # This test is failing in the original documentation as well
    @tag :skip
    test "accepts a tx_json and submits it to the network" do
      tx_json = %{
        "Account" => "rEuLyBCvcw4CFmzv8RepSiAoNgF8tTGJQC",
        "Fee" => "30000",
        "Flags" => 262_144,
        "LimitAmount" => %{
          "currency" => "USD",
          "issuer" => "rHb9CJAWyB4rj91VRWn96DkukG4bwdtyTh",
          "value" => "0"
        },
        "Sequence" => 4,
        "Signers" => [
          %{
            "Signer" => %{
              "Account" => "rsA2LpzuawewSBQXkiju3YQTMzW13pAAdW",
              "SigningPubKey" => "02B3EC4E5DD96029A647CFA20DA07FE1F85296505552CCAC114087E66B46BD77DF",
              "TxnSignature" =>
                "3045022100CC9C56DF51251CB04BB047E5F3B5EF01A0F4A8A549D7A20A7402BF54BA744064022061EF8EF1BCCBF144F480B32508B1D10FD4271831D5303F920DE41C64671CB5B7"
            }
          },
          %{
            "Signer" => %{
              "Account" => "raKEEVSGnKSD9Zyvxu4z6Pqpm4ABH8FS6n",
              "SigningPubKey" => "03398A4EDAE8EE009A5879113EAA5BA15C7BB0F612A87F4103E793AC919BD1E3C1",
              "TxnSignature" =>
                "3045022100FEE8D8FA2D06CE49E9124567DCA265A21A9F5465F4A9279F075E4CE27E4430DE022042D5305777DA1A7801446780308897699412E4EDF0E1AEFDF3C8A0532BDE4D08"
            }
          }
        ],
        "SigningPubKey" => "",
        "TransactionType" => "TrustSet",
        "hash" => "81A477E2A362D171BB16BE17B4120D9F809A327FA00242ABCA867283BEA2F4F8"
      }

      assert {:ok, %Tesla.Env{status: 200}} = Transaction.submit_multisigned(%{tx_json: tx_json})
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = Transaction.submit_multisigned(%{})

      assert errors == [tx_json: {"can't be blank", [validation: :required]}]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        Transaction.submit_multisigned!(%{})
      end
    end
  end

  describe "transaction_entry/3" do
    test "sends tx_hash and ledger_index" do
      assert {:ok, %Tesla.Env{status: 200}} =
               Transaction.transaction_entry(%{
                 tx_hash: "C53ECF838647FA5A4C780377025FEC7999AB4182590510CA461444B207AB74A9",
                 ledger_index: "56865245"
               })
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = Transaction.transaction_entry(%{})

      assert errors == [
               tx_hash: {"can't be blank", [validation: :required]}
             ]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        Transaction.transaction_entry!(%{})
      end
    end
  end

  describe "tx/1" do
    test "sends transaction hash" do
      assert {:ok, %Tesla.Env{status: 200}} =
               Transaction.tx(%{
                 transaction: "C53ECF838647FA5A4C780377025FEC7999AB4182590510CA461444B207AB74A9",
                 binary: false
               })
    end

    test "sends ctid" do
      assert {:ok, %Tesla.Env{status: 200}} =
               Transaction.tx(%{
                 ctid: "C005523E00000000",
                 binary: false
               })
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = Transaction.tx(%{})

      assert errors == [
               transaction: {"can't be blank", [validation: :required]}
             ]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        Transaction.tx!(%{})
      end
    end
  end

  describe "tx_history/1" do
    # This is deprecated on the mainnet public server
    @tag :skip
    test "tx_history/1" do
      assert {:ok, %Tesla.Env{status: 200}} =
               Transaction.tx_history(%{start: 0})
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = Transaction.tx_history(%{})

      assert errors == [
               start: {"can't be blank", [validation: :required]}
             ]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        Transaction.tx_history!(%{})
      end
    end
  end
end
