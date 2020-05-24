defmodule Unistream do
  def working_subscription() do
    chan = setup()
    {:ok, stream} =  Lnrpc.Lightning.Stub.subscribe_invoices(chan, Lnrpc.InvoiceSubscription.new(add_index: 1, settle_index: 1), metadata: %{macaroon: macaroon()}) 
    Enum.into(stream, [])
  end

  def crashing_subscription() do
    chan = setup()
    Lnrpc.Lightning.Stub.subscribe_invoices(chan, Lnrpc.InvoiceSubscription.new(add_index: 0, settle_index: 0), metadata: %{macaroon: macaroon()}) 
  end
  
  defp setup() do
    {:ok, chan} = GRPC.Stub.connect("localhost:10001", cred: creds())
    Lnrpc.Lightning.Stub.add_invoice(chan, Lnrpc.Invoice.new(%{value: 1000, memo: "THIS INVOICE WILL BE IN OPEN STATE"}), metadata: %{macaroon: macaroon()})
    {:ok, invoice} = Lnrpc.Lightning.Stub.add_invoice(chan, Lnrpc.Invoice.new(%{value: 1000, memo: "THIS INVOICE WILL NOT BE SHOWN"}), metadata: %{macaroon: macaroon()})
    Invoicesrpc.Invoices.Stub.cancel_invoice(chan, Invoicesrpc.CancelInvoiceMsg.new(payment_hash: invoice.r_hash), metadata: %{macaroon: macaroon()})

    chan
  end
  
  defp creds() do
    GRPC.Credential.new(ssl: [cacertfile: System.user_home() <> "/.polar/networks/1/volumes/lnd/alice/tls.cert"]) 

  end
  
  defp macaroon() do
    File.read!(System.user_home() <> "/.polar/networks/1/volumes/lnd/alice/data/chain/bitcoin/regtest/admin.macaroon") |> Base.encode16()

  end
end
