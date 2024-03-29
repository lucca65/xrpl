defmodule XRPL do
  @moduledoc """
  XRPL is a library for interacting with the XRP Ledger.
  """

  use Tesla

  @network Application.compile_env(:xrpl, :network)
  plug(Tesla.Middleware.BaseUrl, Application.get_env(:xrpl, @network))
  plug(XRPL.Middleware.Error)
  plug(Tesla.Middleware.JSON)

  defmacro __using__(_opts \\ []) do
    quote location: :keep do
      use Goal

      import XRPL

      def xrpl(method, params) do
        xrpl(method, method, params)
      end

      def xrpl(method, validator, params) do
        case validate(validator, params) do
          {:ok, attrs} ->
            case post("/", %{method: method, params: [attrs]}) do
              {:ok, %{status: 200, body: body}} ->
                {:ok, body["result"]}

              {:error, %{status: 200, body: body}} ->
                {:error, body["result"]}
            end

          {:error, %Ecto.Changeset{errors: error} = changeset} ->
            {:error, changeset}
        end
      end
    end
  end

  defmacro unwrap_or_raise(call) do
    quote do
      case unquote(call) do
        {:ok, value} ->
          value

        {:error, %Ecto.Changeset{errors: _} = error} ->
          raise XRPL.Error, {:validation_error, error}

        {:error, :invalid_params} ->
          raise XRPL.Error, {:validation_error, :invalid_params}

        {:error, env} ->
          raise XRPL.Error, {:request_error, %{body: env.body, url: env.url}}
      end
    end
  end

  @doc """
  Accounts in the XRP Ledger are identified by an address in the XRP Ledger's [base58][] format. The address is derived from the account's master public key, which is in turn derived from a secret key. An address is represented as a string in JSON and has the following characteristics:

  Between 25 and 35 characters in length
  Starts with the character r
  Uses alphanumeric characters, excluding the number "0" capital letter "O", capital letter "I", and lowercase letter "l"
  Case-sensitive

  Official documentation: https://xrpl.org/docs/references/protocol/data-types/basic-data-types/#addresses
  """
  def account_address_regex, do: Application.get_env(:goal, :account_address_regex)

  def public_key_regex, do: Application.get_env(:goal, :public_key_regex)

  @doc """
  Each ledger entry has a unique ID. The ID is derived by hashing important contents of the entry, along with a namespace identifier. The ledger entry type determines the namespace identifier to use and which contents to include in the hash. This ensures every ID is unique. The hash function is SHA-512Half.

  Generally, a ledger entry's ID is returned as the index field in JSON, at the same level as the object's contents. In transaction metadata, the ledger object's ID in JSON is LedgerIndex.

  Offer directories have special IDs, where part of the hash is replaced with the exchange rate of Offers in that directory.


  Official documentation: https://xrpl.org/docs/references/protocol/ledger-data/common-fields/
  """
  def ledger_entry_regex, do: Application.get_env(:goal, :ledger_entry_regex)

  def ledger_hash_regex, do: ledger_entry_regex()

  @doc """
  A ledger index is a 32-bit unsigned integer used to identify a ledger. The ledger index is sometimes known as the ledger's sequence number. (This is different from an account sequence.) The very first ledger was ledger index 1, and each new ledger has a ledger index that is 1 higher than the ledger index of the ledger immediately before it.

  The ledger index indicates the order of the ledgers; the [Hash][] value identifies the exact contents of the ledger. Two ledgers with the same hash are always the same. For validated ledgers, hash values and ledger indexes are equally valid and correlate 1:1. However, this is not true for in-progress ledgers:

  Two different rippled servers may have different contents for a current ledger with the same ledger index, due to latency in propagating transactions throughout the network.
  There may be multiple closed ledger versions competing to be validated by consensus. These ledger versions have the same ledger index but different contents (and different hashes). Only one of these closed ledgers can become validated.
  The current open ledger's hash is not calculated. This is because a current ledger's contents change over time, which would cause its hash to change, even though its ledger index stays the same. The hash of a ledger is only calculated when the ledger is closed.
  Specifying Ledgers
  Many API methods require you to specify an instance of the ledger, with the data retrieved being considered up-to-date as of that particular version of the shared ledger. The commands that accept a ledger version all work the same way. There are three ways you can specify which ledger you want to use:

  Specify a ledger by its Ledger Index in the ledger_index parameter. Each closed ledger has a ledger index that is 1 higher than the previous ledger. (The very first ledger had ledger index 1.)



  "ledger_index": 61546724
  Specify a ledger by its Hash value in the ledger_hash parameter.



  "ledger_hash": "8BB204CE37CFA7A021A16B5F6143400831C4D1779E6FE538D9AC561ABBF4A929"
  Specify a ledger by one of the following shortcuts, in the ledger_index parameter:

  validated for the most recent ledger that has been validated by consensus



  "ledger_index": "validated"
  closed for the most recent ledger that has been closed for modifications and proposed for validation

  current for the server's current working version of the ledger.

  There is also a deprecated ledger parameter which accepts any of the above three formats. Do not use this parameter; it may be removed without further notice.

  If you do not specify a ledger, the server decides which ledger to use to serve the request. By default, the server chooses the current (in-progress) ledger. In Reporting Mode, the server uses the most recent validated ledger instead. Do not provide more than one field specifying ledgers.

  Note: Do not rely on the default behavior for specifying a ledger; it is subject to change. Always specify a ledger version in the request if you can.

  Reporting Mode does not record ledger data until it has been validated. If you make a request to a Reporting Mode server for the current or closed ledger, the server forwards the request to a P2P Mode server. If you request a ledger index or hash that is not validated, a Reporting Mode server responds with a lgrNotFound error.
  Official documentation: https://xrpl.org/docs/references/protocol/data-types/basic-data-types/#ledger-index
  """
  def ledger_index_regex, do: Application.get_env(:goal, :ledger_index_regex)

  @doc """
  The HTTP / WebSocket APIs support two formats of currency code:

  Standard Currency Codes: As a 3-character string such as "EUR" or "USD".
  Nonstandard Currency Codes: As a 160-bit hexadecimal string, such as "0158415500000000C1F76FF6ECB0BAC600000000". This is uncommon.
  Tokens with the same code can ripple across connected trust lines. Currency codes have no other behavior built into the XRP Ledger.

  Official documentation: https://xrpl.org/docs/references/protocol/data-types/currency-formats/#currency-codes
  """
  def currency_regex, do: Application.get_env(:goal, :currency_regex)
end
