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
    required(:index, :string, format: :ledger_entry)

    optional(:ledger_index, :string, format: :ledger_index)
    optional(:ledger_hash, :string, format: :ledger_entry)
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
    required(:account_root, :string, format: :account_address)

    optional(:ledger_index, :string, format: :ledger_index)
    optional(:ledger_hash, :string, format: :ledger_entry)
    optional(:binary, :boolean, default: false)
  end

  @doc """
  Retrieve an Automated Market-Maker (AMM) object from the ledger. This is similar to amm_info method, but the ledger_entry version returns only the ledger entry as stored.

  Official documentation: https://xrpl.org/ledger_entry.html#get-amm-object
  """
  def amm(%{amm: amm} = params) when is_map(amm) do
    xrpl("ledger_entry", "amm_string", params)
  end

  def amm(%{amm: amm} = params) when is_binary(amm) do
    xrpl("ledger_entry", "amm_object", params)
  end

  def amm(params) do
    xrpl("ledger_entry", "amm_string", params)
  end

  def amm!(params), do: params |> amm() |> unwrap_or_raise()

  defparams "amm_string" do
    required(:amm, :string, format: :ledger_entry)

    optional(:ledger_index, :string, format: :ledger_index)
    optional(:ledger_hash, :string, format: :ledger_entry)
    optional(:binary, :boolean, default: false)
  end

  defparams "amm_object" do
    required :amm, :map do
      required :asset, :map do
        required(:currency, :string, format: :currency)
      end

      required :asset2, :map do
        required(:currency, :string, format: :currency)
        required(:issuer, :string, format: :account_address)
      end
    end

    optional(:ledger_index, :string, format: :ledger_index)
    optional(:ledger_hash, :string, format: :ledger_entry)
    optional(:binary, :boolean, default: false)
  end

  @doc """
  Retrieve a DirectoryNode, which contains a list of other ledger objects. Can be provided as string (object ID of the Directory) or as an object.

  Official documentation: https://xrpl.org/ledger_entry.html#get-directorynode-object
  """
  def directory_node(%{directory: directory} = params) when is_binary(directory) do
    xrpl("ledger_entry", "directory_node_string", params)
  end

  def directory_node(%{directory: directory} = params) when is_map(directory) do
    xrpl("ledger_entry", "directory_node_object", params)
  end

  def directory_node(params) do
    xrpl("ledger_entry", "directory_node_string", params)
  end

  def directory_node!(params), do: params |> directory_node() |> unwrap_or_raise()

  defparams "directory_node_string" do
    required(:directory, :string, format: :ledger_entry)

    optional(:ledger_index, :string, format: :ledger_index)
    optional(:ledger_hash, :string, format: :ledger_entry)
    optional(:binary, :boolean, default: false)
  end

  defparams "directory_node_object" do
    required :directory, :map do
      optional(:dir_root, :string, format: :ledger_entry)
      optional(:owner, :string, format: :account_address)
      optional(:sub_index, :integer)
    end

    optional(:ledger_index, :string, format: :ledger_index)
    optional(:ledger_hash, :string, format: :ledger_entry)
    optional(:binary, :boolean, default: false)
  end

  @doc """
  Retrieve an Offer entry, which defines an offer to exchange currency. Can be provided as string (unique index of the Offer) or as an object.

  Official documentation: https://xrpl.org/ledger_entry.html#get-offer-object
  """
  def offer(%{offer: offer} = params) when is_binary(offer) do
    xrpl("ledger_entry", "offer_string", params)
  end

  def offer(%{offer: offer} = params) when is_map(offer) do
    xrpl("ledger_entry", "offer_object", params)
  end

  def offer(params) do
    xrpl("ledger_entry", "offer_string", params)
  end

  def offer!(params), do: params |> offer() |> unwrap_or_raise()

  defparams "offer_string" do
    required(:offer, :string, format: :ledger_entry)
    optional(:ledger_index, :string, format: :ledger_index)
    optional(:ledger_hash, :string, format: :ledger_entry)
    optional(:binary, :boolean, default: false)
  end

  defparams "offer_object" do
    required :offer, :map do
      required(:account, :string, format: :account_address)
      required(:seq, :integer)
    end

    optional(:ledger_index, :string, format: :ledger_index)
    optional(:ledger_hash, :string, format: :ledger_entry)
    optional(:binary, :boolean, default: false)
  end

  @doc """
  Retrieve a RippleState entry, which tracks a (non-XRP) currency balance between two accounts.

  Official documentation: https://xrpl.org/ledger_entry.html#get-ripplestate-object
  """
  def ripple_state(params) do
    xrpl("ledger_entry", "ripple_state", params)
  end

  def ripple_state!(params), do: params |> ripple_state() |> unwrap_or_raise()

  defparams "ripple_state" do
    required(:ripple_state, :map) do
      required(:accounts, {:array, :string})
      required(:currency, :string, format: :currency)
    end

    optional(:ledger_index, :string, format: :ledger_index)
    optional(:ledger_hash, :string, format: :ledger_entry)
    optional(:binary, :boolean, default: false)
  end

  @doc """
  Retrieve a Check entry, which is a potential payment that can be cashed by its recipient.

  Official documentation: https://xrpl.org/ledger_entry.html#get-check-object
  """
  def check(params) do
    xrpl("ledger_entry", "check", params)
  end

  def check!(params), do: params |> check() |> unwrap_or_raise()

  defparams "check" do
    required(:check, :string, format: :ledger_entry)

    optional(:ledger_index, :string, format: :ledger_index)
    optional(:ledger_hash, :string, format: :ledger_entry)
    optional(:binary, :boolean, default: false)
  end

  @doc """
  Retrieve an Escrow entry, which holds XRP until a specific time or condition is met. Can be provided as string (object ID of the Escrow) or as an object.

  Official documentation: https://xrpl.org/ledger_entry.html/#get-escrow-object
  """
  def escrow(%{escrow: escrow} = params) when is_binary(escrow) do
    xrpl("ledger_entry", "escrow_string", params)
  end

  def escrow(%{escrow: escrow} = params) when is_map(escrow) do
    xrpl("ledger_entry", "escrow_object", params)
  end

  def escrow(params) do
    xrpl("ledger_entry", "escrow_string", params)
  end

  def escrow!(params), do: params |> escrow() |> unwrap_or_raise()

  defparams "escrow_string" do
    required(:escrow, :string, format: :ledger_entry)

    optional(:ledger_index, :string, format: :ledger_index)
    optional(:ledger_hash, :string, format: :ledger_entry)
    optional(:binary, :boolean, default: false)
  end

  defparams "escrow_object" do
    required :escrow, :map do
      required(:owner, :string, format: :account_address)
      required(:seq, :integer)
    end

    optional(:ledger_index, :string, format: :ledger_index)
    optional(:ledger_hash, :string, format: :ledger_entry)
    optional(:binary, :boolean, default: false)
  end

  @doc """
  Retrieve a PayChannel entry, which holds XRP for asynchronous payments.

  Official documentation: https://xrpl.org/ledger_entry.html#get-paychannel-object
  """
  def payment_channel(params) do
    xrpl("ledger_entry", "payment_channel", params)
  end

  def payment_channel!(params), do: params |> payment_channel() |> unwrap_or_raise()

  defparams "payment_channel" do
    required(:payment_channel, :string, format: :ledger_entry)

    optional(:ledger_index, :string, format: :ledger_index)
    optional(:ledger_hash, :string, format: :ledger_entry)
    optional(:binary, :boolean, default: false)
  end

  @doc """
  Retrieve a DepositPreauth entry, which tracks preauthorization for payments to accounts requiring Deposit Authorization.

  Official documentation: https://xrpl.org/ledger_entry.html#get-depositpreauth-object
  """
  def deposit_preauth(%{deposit_preauth: deposit_preauth} = params) when is_binary(deposit_preauth) do
    xrpl("ledger_entry", "deposit_preauth_string", params)
  end

  def deposit_preauth(%{deposit_preauth: deposit_preauth} = params) when is_map(deposit_preauth) do
    xrpl("ledger_entry", "deposit_preauth_object", params)
  end

  def deposit_preauth(params) do
    xrpl("ledger_entry", "deposit_preauth_string", params)
  end

  def deposit_preauth!(params), do: params |> deposit_preauth() |> unwrap_or_raise()

  defparams "deposit_preauth_string" do
    required(:deposit_preauth, :string, format: :ledger_entry)

    optional(:ledger_index, :string, format: :ledger_index)
    optional(:ledger_hash, :string, format: :ledger_entry)
    optional(:binary, :boolean, default: false)
  end

  defparams "deposit_preauth_object" do
    required(:deposit_preauth, :map) do
      required(:owner, :string, format: :account_address)
      required(:authorized, :string, format: :account_address)
    end

    optional(:ledger_index, :string, format: :ledger_index)
    optional(:ledger_hash, :string, format: :ledger_entry)
    optional(:binary, :boolean, default: false)
  end

  @doc """
  Retrieve a Ticket entry, which represents a sequence number set aside for future use. (Added by the TicketBatch amendment)

  Official documentation: https://xrpl.org/ledger_entry.html#get-ticket-object
  """
  def ticket(%{ticket: ticket} = params) when is_binary(ticket) do
    xrpl("ledger_entry", "ticket_string", params)
  end

  def ticket(%{ticket: ticket} = params) when is_map(ticket) do
    xrpl("ledger_entry", "ticket_object", params)
  end

  def ticket(params) do
    xrpl("ledger_entry", "ticket_string", params)
  end

  def ticket!(params), do: params |> ticket() |> unwrap_or_raise()

  defparams "ticket_string" do
    required(:ticket, :string, format: :ledger_entry)
    optional(:ledger_index, :string, format: :ledger_index)
    optional(:ledger_hash, :string, format: :ledger_entry)
    optional(:binary, :boolean, default: false)
  end

  defparams "ticket_object" do
    required(:ticket, :map) do
      required(:account, :string, format: :account_address)
      required(:ticket_seq, :integer)
    end

    optional(:ledger_index, :string, format: :ledger_index)
    optional(:ledger_hash, :string, format: :ledger_entry)
    optional(:binary, :boolean, default: false)
  end

  @doc """
  Return an NFT Page in its raw ledger format.

  Official documentation: https://xrpl.org/ledger_entry.html#get-nft-page
  """
  def nft_page(params) do
    xrpl("ledger_entry", "nft_page", params)
  end

  def nft_page!(params), do: params |> nft_page() |> unwrap_or_raise()

  defparams "nft_page" do
    required(:nft_page, :string, format: :ledger_entry)
    optional(:ledger_index, :string, format: :ledger_index)
    optional(:ledger_hash, :string, format: :ledger_entry)
    optional(:binary, :boolean, default: false)
  end
end
