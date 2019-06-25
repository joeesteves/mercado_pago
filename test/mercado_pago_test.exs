defmodule MercadoPagoTest do
  use ExUnit.Case
  doctest MercadoPago

  test "Gets Valid Payment Link" do
    {:ok, url} = MercadoPago.get_payment_link("test title", "test description", 150)

    String.match?(url, ~r/mercadopago.*\/checkout\/start\?pref_id/)
    |> assert
  end
end

#TODO: Add feature test with wallaby
