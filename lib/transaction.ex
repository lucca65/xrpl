defmodule XRPL.Transaction do
  @moduledoc """
  XRPL.Transaction is a module to interact with transaction modules on the XRP Ledger.
  Transactions are the only thing that can modify the shared state of the XRP Ledger. All business on the XRP Ledger takes the form of transactions. Use these methods to work with transactions.

  Official RPC documentation https://xrpl.org/transaction-methods.html
  """

  import XRPL

  @doc """
  A submit-only request includes the following parameters:

    - `tx_blob` (String) - The signed transaction to submit, encoded as hex
    - `fail_hard` (Boolean) - If true, the transaction fails if it cannot be applied immediately. Otherwise, the transaction is queued. (Optional; defaults to false)

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/transaction-methods/submit/#submit
  """
  def submit(tx_blob, fail_hard \\ false) do
    post("/", %{
      method: "submit",
      params: [%{tx_blob: tx_blob, fail_hard: fail_hard}]
    })
  end

  @doc """
  The submit_multisigned command applies a multi-signed transaction and sends it to the network to be included in future ledgers.
  (You can also submit multi-signed transactions in binary form using the submit command in submit-only mode.)

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/transaction-methods/submit_multisigned/#submit_multisigned
  """
  def submit_multisigned(tx_json) do
    post("/", %{
      method: "submit_multisigned",
      params: [%{tx_json: tx_json}]
    })
  end

  @doc """
  The transaction_entry method retrieves information on a single transaction from a specific ledger version. (The tx method, by contrast, searches all ledgers for the specified transaction. We recommend using that method instead.)

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/transaction-methods/transaction_entry/#transaction_entry
  """
  def transaction_entry(tx_hash, ledger_index \\ nil, ledger_hash \\ nil) do
    params = %{tx_hash: tx_hash}

    params =
      if ledger_index != nil,
        do: Map.put(params, :ledger_index, ledger_index),
        else: params

    params =
      if ledger_hash != nil,
        do: Map.put(params, :ledger_hash, ledger_hash),
        else: params

    post("/", %{
      method: "transaction_entry",
      params: [params]
    })
  end

  @doc """
  The tx method retrieves information on a single transaction, by its identifying hash or its CTID.

  Official documentation: https://xrpl.org/docs/references/http-websocket-apis/public-api-methods/transaction-methods/tx/#tx
  """
  def tx(ctid_or_transaction, binary \\ false)

  def tx(ctid_or_transaction, binary) do
    params =
      if String.length(ctid_or_transaction) == 64 do
        %{transaction: ctid_or_transaction, binary: binary}
      else
        %{ctid: ctid_or_transaction, binary: binary}
      end

    post("/", %{
      method: "tx",
      params: [params]
    })
  end

  def tx(ctid_or_transaction, min_ledger, max_ledger, binary \\ false) do
    params =
      if String.length(ctid_or_transaction) == 64 do
        %{transaction: ctid_or_transaction}
      else
        %{ctid: ctid_or_transaction}
      end

    params =
      Map.merge(params, %{
        min_ledger: min_ledger,
        max_ledger: max_ledger,
        binary: binary
      })

    post("/", %{
      method: "tx",
      params: [params]
    })
  end
end
