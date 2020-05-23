defmodule Unistream do
  def subscribe do
    {:ok, chan} = GRPC.Stub.connect("localhost:10001", cred: creds()) |> IO.inspect(label: "connect: ")
    
    Lnrpc.Lightning.Stub.subscribe_invoices(chan, Lnrpc.InvoiceSubscription.new(), metadata: %{macaroon: macaroon()})
  end
  
  def creds() do
    GRPC.Credential.new(ssl: [cacertfile: System.user_home() <> "/.polar/networks/1/volumes/lnd/alice/tls.cert"]) 

  end
  
  def macaroon() do
    File.read!(System.user_home() <> "/.polar/networks/1/volumes/lnd/alice/data/chain/bitcoin/regtest/admin.macaroon") |> Base.encode16()

  end
end
