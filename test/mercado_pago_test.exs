defmodule MercadoPagoTest do
  use ExUnit.Case
  doctest MercadoPago

  test "Gets Valid Payment Link" do
    MercadoPago.get_payment_link("test title", "test description", 150)
    |> String.match?(~r/mercadopago.*\/checkout\/start\?pref_id/)
    |> assert
  end
end
