defmodule XRPL.Middleware.ErrorTest do
  use ExUnit.Case, async: false

  defmodule VanillaClient do
    use Tesla

    adapter(fn env ->
      case env.url do
        "/200" ->
          {:ok, %{env | status: 200, body: "All good"}}

        "/500" ->
          {:ok, %{env | status: 500, body: "All bad"}}

        "/error" ->
          {:ok, %{env | status: 200, body: %{"result" => %{"error" => "invalidParams"}}}}
      end
    end)
  end

  defmodule CustomClient do
    use Tesla

    plug(XRPL.Middleware.Error)

    adapter(fn env ->
      case env.url do
        "/200" ->
          {:ok, %{env | status: 200, body: %{"result" => %{"result" => "All good"}}}}

        "/500" ->
          {:ok, %{env | status: 500, body: %{"result" => %{"result" => "All bad"}}}}

        "/error" ->
          {:ok, %{env | status: 200, body: %{"result" => %{"error" => "invalidParams"}}}}
      end
    end)
  end

  describe "Match errors with HTTP verbs" do
    test "get/1" do
      assert {:ok, env} = VanillaClient.get("/200")
      assert env.status == 200

      assert {:ok, env} = CustomClient.get("/200")
      assert env.status == 200
    end

    test "get/1 with error" do
      assert {:ok, env} = VanillaClient.get("/500")
      assert env.status == 500

      assert {:error, env} = CustomClient.get("/500")
      assert env.status == 500
    end

    test "get!/1" do
      assert env = VanillaClient.get!("/200")
      assert env.status == 200

      assert env = CustomClient.get!("/200")
      assert env.status == 200
    end

    test "get!/1 with error" do
      assert _env = VanillaClient.get!("/200")

      assert_raise Tesla.Error, fn ->
        CustomClient.get!("/500")
      end
    end
  end

  describe "Match errors with body response" do
    test "get/1" do
      assert {:ok, env} = VanillaClient.get("/200")
      assert env.status == 200

      assert {:ok, env} = CustomClient.get("/200")
      assert env.status == 200
    end

    test "get/1 with error" do
      assert {:ok, env} = VanillaClient.get("/500")
      assert env.status == 500

      assert {:error, env} = CustomClient.get("/500")
      assert env.status == 500
    end
  end
end
