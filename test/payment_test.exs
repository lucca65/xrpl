defmodule XRPL.PaymentTest do
  use ExUnit.Case

  alias XRPL.Payment

  describe "channel_authorized/1" do
    # Cannot test without a seed / Resources
    @tag :skip
    test "channel_authorized/1" do
      assert {:ok, %Tesla.Env{status: 200}} =
               Payment.channel_authorize(%{
                 channel_id: "5DB01B7FFED6B67E6B0414DED11E051D2EE2B7619CE0EAA6286D67A3A4D5BDB3",
                 seed: "s████████████████████████████",
                 key_type: "secp256k1",
                 amount: "1000000"
               })
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, :invalid_params} = Payment.channel_authorize(%{})
      assert {:error, %{errors: errors}} = Payment.channel_authorize(%{seed: 1})

      assert Enum.sort(errors) == [
               amount: {"can't be blank", [validation: :required]},
               channel_id: {"can't be blank", [validation: :required]},
               seed: {"is invalid", [{:type, :string}, {:validation, :cast}]}
             ]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        Payment.channel_authorize!(%{})
      end
    end
  end

  describe "channel_verify/1" do
    test "channel_verify/1" do
      assert {:ok, %Tesla.Env{status: 200}} =
               Payment.channel_verify(%{
                 channel_id: "5DB01B7FFED6B67E6B0414DED11E051D2EE2B7619CE0EAA6286D67A3A4D5BDB3",
                 signature:
                   "304402204EF0AFB78AC23ED1C472E74F4299C0C21F1B21D07EFC0A3838A420F76D783A400220154FB11B6F54320666E4C36CA7F686C16A3A0456800BBC43746F34AF50290064",
                 public_key: "aB44YfzW24VDEJQ2UuLPV2PvqcPCSoLnL7y5M1EzhdW4LnK5xMS3",
                 amount: "1000000"
               })
    end

    test "it returns an error if we don't provide the required param" do
      assert {:error, %{errors: errors}} = Payment.channel_verify(%{})

      assert errors == [
               {:amount, {"can't be blank", [validation: :required]}},
               {:channel_id, {"can't be blank", [validation: :required]}},
               {:public_key, {"can't be blank", [validation: :required]}},
               {:signature, {"can't be blank", [validation: :required]}}
             ]
    end

    test "calling the ! version of the function raises an error if the request fails" do
      assert_raise XRPL.Error, "XRPL call failed: Invalid params", fn ->
        Payment.channel_verify!(%{})
      end
    end
  end
end
