# Unistream

This code helps to reproduce `{:error, %GRPC.RPCError{message: ":stream_error: :closed", status: 13}}` errors while talking to SubscribeInvoices endpoint.

## Steps to reproduce crashing subscription due to `[ERR] INVC: unknown invoice state: Canceled`

1. Start Polar lightning
2. Create new network called `Simnet` with at least one LND node  
3. Start `Simnet` network 
4. Clone and navigate into project folder  `git@github.com:lessless/unistream.git && cd unistream`
5. Fetch dependencies `mix deps.get`
5. Edit TLS  and Macaroon file locations if necessary in [lib/unistream.ex](https://github.com/lessless/unistream/blob/master/lib/unistream.ex)
6. Start app in a REPL shell `iex -S mix`
7. Run `Unistream.working_subscription` and observe `{:ok, <Stream>}` tuple
8. Run `Unistream.crashing_subscription` and observe error
9. Check node logs and there will be an `[ERR] INVC: unknown invoice state: Canceled` error


## Steps to reproduce crashing subscription due to `[ERR] INVC: unable to deliver backlog invoice notifications: there are no existing invoices`


1. Start Polar lightning
2. Create new network called `Simnet` with at least one LND node  
3. Start `Simnet` network 
4. Clone and navigate into project folder  `git@github.com:lessless/unistream.git && cd unistream`
5. Fetch dependencies `mix deps.get`
5. Edit TLS  and Macaroon file locations if necessary in [lib/unistream.ex](https://github.com/lessless/unistream/blob/master/lib/unistream.ex)
6. Start app in a REPL shell `iex -S mix`
7. Run `Unistream.subscribe_without_invoices` and observe error
9. Check node logs and there will be an `[ERR] INVC: unable to deliver backlog invoice notifications: there are no existing invoices` error