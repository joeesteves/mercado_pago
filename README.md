# MercadoPago

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `mercado_pago` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mercado_pago, "~> 0.1.0"}
  ]
end
```
#Config

On your proyect go to config/config.exs and add mercado pago api credentials (basic checkout). [If you need to know how to do it visit this link](https://ceibo.co/2018/07/14/mercadopago-como-generar-un-link-de-pago-dinamico/)

```elixir
config :mercado_pago, client_id: System.get_env("MP_CLIENT_ID")
config :mercado_pago, client_secret: System.get_env("MP_CLIENT_SECRET")
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/mercado_pago](https://hexdocs.pm/mercado_pago).
