defmodule XRPL.LedgerEntry do
  @moduledoc """
  The ledger_entry method returns a single ledger entry from the XRP Ledger in its raw format.
  See [ledger format](https://xrpl.org/ledger-object-types.html) for information on the different types of entries you can retrieve.

  Official documentation: https://xrpl.org/ledger_entry.html
  """

  use XRPL

  @doc """
  Retrieve any type of ledger object by its unique ID.

  Official documentation: https://xrpl.org/ledger_entry.html#get-ledger-object-by-id
  """
  def by_id(params) do
    xrpl("ledger_entry", "by_id", params)
  end

  def by_id!(params), do: params |> by_id() |> unwrap_or_raise()

  defparams "by_id" do
    required(:index, :string, format: XRPL.ledger_entry_regex())

    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
    optional(:ledger_hash, :string, format: XRPL.ledger_hash_regex())
    optional(:binary, :boolean, default: false)
  end

  @doc """
  Retrieve an AccountRoot entry by its address. This is roughly equivalent to the account_info method.

  Official documentation: https://xrpl.org/ledger_entry.html#get-accountroot-object
  """
  def account_root(params) do
    xrpl("ledger_entry", "account_root", params)
  end

  def account_root!(params), do: params |> account_root() |> unwrap_or_raise()

  defparams "account_root" do
    required(:account_root, :string, format: XRPL.is_account())

    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
    optional(:ledger_hash, :string, format: XRPL.ledger_hash_regex())
    optional(:binary, :boolean, default: false)
  end

  @doc """
  Retrieve an Automated Market-Maker (AMM) object from the ledger. This is similar to amm_info method, but the ledger_entry version returns only the ledger entry as stored.

  Official documentation: https://xrpl.org/ledger_entry.html#get-amm-object
  """
  def amm(params) do
    xrpl("ledger_entry", "amm", params)
  end

  def amm!(params), do: params |> amm() |> unwrap_or_raise()

  defparams "amm" do
    # TODO: finish this

    optional(:ledger_index, :string, format: XRPL.ledger_index_regex())
    optional(:ledger_hash, :string, format: XRPL.ledger_hash_regex())
    optional(:binary, :boolean, default: false)
  end

  @doc """
  Retrieve a DirectoryNode, which contains a list of other ledger objects. Can be provided as string (object ID of the Directory) or as an object.

  Official documentation: https://xrpl.org/ledger_entry.html#get-directorynode-object
  """
  def directory_node(ledger_index, opts) do
    opts =
      Keyword.filter(opts, fn {key, _val} ->
        Enum.any?([:sub_index, :dir_root, :owner], &(key == &1))
      end)

    post("/", %{
      method: "ledger_entry",
      params: [%{ledger_index: ledger_index, directory: Map.new(opts)}]
    })
  end

  @doc """
  Retrieve an Offer entry, which defines an offer to exchange currency. Can be provided as string (unique index of the Offer) or as an object.

  Official documentation: https://xrpl.org/ledger_entry.html#get-offer-object
  """
  def offer(ledger_index, account, seq) do
    post("/", %{
      method: "ledger_entry",
      params: [%{offer: %{account: account, seq: seq}, ledger_index: ledger_index}]
    })
  end

  @doc """
  Retrieve a RippleState entry, which tracks a (non-XRP) currency balance between two accounts.

  Official documentation: https://xrpl.org/ledger_entry.html#get-ripplestate-object
  """
  def ripple_state(ledger_index, accounts, currency) do
    post("/", %{
      method: "ledger_entry",
      params: [
        %{ripple_state: %{accounts: accounts, currency: currency}, ledger_index: ledger_index}
      ]
    })
  end

  @doc """
  Retrieve a Check entry, which is a potential payment that can be cashed by its recipient.

  Official documentation: https://xrpl.org/ledger_entry.html#get-check-object
  """
  def check(ledger_index, object_id) do
    post("/", %{
      method: "ledger_entry",
      params: [%{check: object_id, ledger_index: ledger_index}]
    })
  end

  @doc """
  Retrieve an Escrow entry, which holds XRP until a specific time or condition is met. Can be provided as string (object ID of the Escrow) or as an object.

  Official documentation: https://xrpl.org/ledger_entry.html/#get-escrow-object
  """
  def escrow(params) do
    xrpl("ledger_entry", "escrow", params)
  end

  def escrow!(params), do: params |> escrow() |> unwrap_or_raise()

  @doc """
  Retrieve a PayChannel entry, which holds XRP for asynchronous payments.

  Official documentation: https://xrpl.org/ledger_entry.html#get-paychannel-object
  """
  def payment_channel(ledger_index, object_id) do
    post("/", %{
      method: "ledger_entry",
      params: [%{payment_channel: object_id, ledger_index: ledger_index}]
    })
  end

  @doc """
  Retrieve a DepositPreauth entry, which tracks preauthorization for payments to accounts requiring Deposit Authorization.

  Official documentation: https://xrpl.org/ledger_entry.html#get-depositpreauth-object
  """
  def deposit_preauth(ledger_index, object_id) do
    post("/", %{
      method: "ledger_entry",
      params: [%{deposit_preauth: object_id, ledger_index: ledger_index}]
    })
  end

  def deposit_preauth(ledger_index, owner, authorized) do
    post("/", %{
      method: "ledger_entry",
      params: [%{deposit_preauth: %{owner: owner, authorized: authorized}, ledger_index: ledger_index}]
    })
  end

  @doc """
  Retrieve a Ticket entry, which represents a sequence number set aside for future use. (Added by the TicketBatch amendment)

  Official documentation: https://xrpl.org/ledger_entry.html#get-ticket-object
  """
  def ticket(ledger_index, ledger_entry_id) do
    post("/", %{
      method: "ledger_entry",
      params: [%{ticket: ledger_entry_id, ledger_index: ledger_index}]
    })
  end

  def ticket(ledger_index, account, seq) do
    post("/", %{
      method: "ledger_entry",
      params: [%{ticket: %{account: account, ticket_seq: seq}, ledger_index: ledger_index}]
    })
  end

  @doc """
  Return an NFT Page in its raw ledger format.

  Official documentation: https://xrpl.org/ledger_entry.html#get-nft-page
  """
  def nft_page(ledger_index, ledger_entry_id) do
    post("/", %{
      method: "ledger_entry",
      params: [%{nft_page: ledger_entry_id, ledger_index: ledger_index}]
    })
  end
end
