# Unistream

This code helps to reproduce `{:error, %GRPC.RPCError{message: ":stream_error: :closed", status: 13}}` error while sending message with `0` values


## Steps to reproduce

1. Start Polar lightning
2. Download and import network configuration https://www.dropbox.com/s/e9nhv482wyhwx3r/Simnet.polar.zip
3. Start `Simnet` network 
4. Clone `git@github.com:lessless/unistream.git`
5. Fetch dependencies `mix deps.get`
5. Edit TLS  and Macaroon file locations if necessary in [lib/unistream.ex](https://github.com/lessless/unistream/blob/master/lib/unistream.ex)
6. Start app `iex -S mix`
7. Run `Unistream.working_subscription` and observe `{:ok, <Stream>}` tuple
8. Run `Unistream.crashing_subscription` and observe error

