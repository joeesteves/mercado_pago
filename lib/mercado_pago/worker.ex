defmodule MercadoPago.Worker do
  use Agent

  def start_link(_args) do
    Agent.start_link(fn -> %{} end, name: :mp_tokens)
  end
end
