defmodule MercadoPago.Worker do
  use Agent

  def start_link(_args) do
    Agent.start_link(fn -> nil end, name: :mp_token)
  end
end
