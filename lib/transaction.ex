defmodule XRPL.Transaction do
  @moduledoc """
  XRPL.Transaction is a module to interact with transaction modules on the XRP Ledger.
  Transactions are the only thing that can modify the shared state of the XRP Ledger. All business on the XRP Ledger takes the form of transactions. Use these methods to work with transactions.

  Official RPC documentation https://xrpl.org/transaction-methods.html
  """

  use XRPL

  @doc """
  A submit-only request includes the following parameters:

    - `tx_blob` (String) - The signed transaction to submit, encoded as hex
    - `fail_hard` (Boolean) - If true, the transaction fails if it cannot be applied immediately. Otherwise, the transaction is queued. (Optional; defaults to false)

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/transaction-methods/submit/#submit
  """
  def submit(params) do
    xrpl("submit", params)
  end

  def submit!(params), do: params |> submit() |> unwrap_or_raise()

  defparams "submit" do
    required(:tx_blob, :string)
    optional(:fail_hard, :boolean, default: false)
  end

  @doc """
  The submit_multisigned command applies a multi-signed transaction and sends it to the network to be included in future ledgers.
  (You can also submit multi-signed transactions in binary form using the submit command in submit-only mode.)

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/transaction-methods/submit_multisigned/#submit_multisigned
  """
  def submit_multisigned(params) do
    xrpl("submit_multisigned", params)
  end

  def submit_multisigned!(params), do: params |> submit_multisigned() |> unwrap_or_raise()

  defparams "submit_multisigned" do
    required(:tx_json, :map) do
      required(:Account, :string, format: :account_address)

      required(:TransactionType, :enum,
        values: [
          "AccountSet",
          "AccountDelete",
          "AMMBid",
          "AMMCreate",
          "AMMDelete",
          "AMMDeposit",
          "AMMVote",
          "AMMWithdraw",
          "CheckCancel",
          "CheckCash",
          "CheckCreate",
          "Clawback",
          "DepositPreauth",
          "DIDDelete",
          "DIDSet",
          "EscrowCancel",
          "EscrowCreate",
          "EscrowFinish",
          "NFTokenAcceptOffer",
          "NFTokenBurn",
          "NFTokenCancelOffer",
          "NFTokenCreateOffer",
          "NFTokenMint",
          "OfferCancel",
          "OfferCreate",
          "Payment",
          "PaymentChannelClaim",
          "PaymentChannelCreate",
          "PaymentChannelFund",
          "SetRegularKey",
          "SignerListSet",
          "TicketCreate",
          "TrustSet",
          "XChainAccountCreateCommit",
          "XChainAddAccountCreateAttestation",
          "XChainAddClaimAttestation",
          "XChainClaim",
          "XChainCommit",
          "XChainCreateBridge",
          "XChainCreateClaimID",
          "XChainModifyBridge"
        ]
      )

      required(:Fee, :string)
      optional(:Sequence, :integer)
      optional(:AccountTxnID, :string)
      optional(:Flags, :integer)
      optional(:LastLedgerSequence, :integer)
      optional(:Memos, {:array, :map})
      optional(:NetworkID, :integer)
      optional(:Signers, {:array, :map})
      optional(:SourceTag, :integer)
      optional(:SigningPubKey, :string)
      optional(:TicketSequence, :integer)
      optional(:TxnSignature, :string)
    end

    optional(:fail_hard, :boolean, default: false)
  end

  @doc """
  The transaction_entry method retrieves information on a single transaction from a specific ledger version. (The tx method, by contrast, searches all ledgers for the specified transaction. We recommend using that method instead.)

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/transaction-methods/transaction_entry/#transaction_entry
  """
  def transaction_entry(params) do
    xrpl("transaction_entry", params)
  end

  def transaction_entry!(params), do: params |> transaction_entry() |> unwrap_or_raise()

  defparams "transaction_entry" do
    required(:tx_hash, :string)
    optional(:ledger_index, :string)
    optional(:ledger_hash, :string)
  end

  @doc """
  The tx method retrieves information on a single transaction, by its identifying hash or its CTID.

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/transaction-methods/tx/#tx
  """
  def tx(%{ctid: _} = params), do: xrpl("tx", "tx_ctid", params)
  def tx(%{transaction: _} = params), do: xrpl("tx", "tx_transaction", params)
  def tx(params), do: xrpl("tx", "tx_transaction", params)
  def tx!(params), do: params |> tx() |> unwrap_or_raise()

  defparams "tx_ctid" do
    required(:ctid, :string)
    optional(:binary, :boolean, default: false)
    optional(:min_ledger, :integer)
    optional(:max_ledger, :integer)
  end

  defparams "tx_transaction" do
    required(:transaction, :string)
    optional(:binary, :boolean, default: false)
    optional(:min_ledger, :integer)
    optional(:max_ledger, :integer)
  end

  @doc """
  The tx_history method retrieves some of the most recent transactions made.

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/transaction-methods/tx_history
  """
  def tx_history(params), do: xrpl("tx_history", params)
  def tx_history!(params), do: params |> tx_history() |> unwrap_or_raise()

  defparams "tx_history" do
    required(:start, :integer, default: 0)
  end
end
