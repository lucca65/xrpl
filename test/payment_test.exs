defmodule XRPL.PaymentTest do
  use ExUnit.Case

  alias XRPL.Payment

  describe "channel_authorized" do
    @tag :skip
    test "provide channel_id, seed, key_type, amount" do
      # assert {:ok, %Tesla.Env{status: 200}} =
      #          Payment.channel_authorized(
      #            "1000000",
      #            "5DB01B7FFED6B67E6B0414DED11E051D2EE2B7619CE0EAA6286D67A3A4D5BDB3",

      #          )
    end
  end

  describe "channel_verify/4" do
    test "provide channel_id, amount, signature, public_key" do
      assert {:ok, %Tesla.Env{status: 200}} =
               Payment.channel_verify(
                 "1000000",
                 "5DB01B7FFED6B67E6B0414DED11E051D2EE2B7619CE0EAA6286D67A3A4D5BDB3",
                 "304402204EF0AFB78AC23ED1C472E74F4299C0C21F1B21D07EFC0A3838A420F76D783A400220154FB11B6F54320666E4C36CA7F686C16A3A0456800BBC43746F34AF50290064",
                 "aB44YfzW24VDEJQ2UuLPV2PvqcPCSoLnL7y5M1EzhdW4LnK5xMS3"
               )
    end
  end
end
