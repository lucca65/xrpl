# XRPL

This library intends to help Elixir developers to integrate and use [XRP Ledger Blockchain](https://xrpl.org/).

It allows you to interact with its HTTP API and is organized in a manner similar to the [official documentation](https://xrpl.org/http-websocket-apis.html).


## ⚠️ BEWARE still in development

This is currently a work in progress and there is still a lot to do. Any help is welcome!

- [x] Account methods
- [x] Ledger methods
- [x] Transaction methods
- [x] Path and Order Book methods
- [x] Payment methods
- [x] Server methods
- [ ] Clio methods
- [ ] Utility methods

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `xrpl` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:xrpl, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/xrpl>.

