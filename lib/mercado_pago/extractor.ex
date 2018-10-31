defmodule MercadoPago.Extract do
  def form_action(body) do
    Regex.named_captures(~r/form action=.(?<url>https[\w,\/,:,?,=,.]+)/, body)["url"]
  end

  def input(body, name) do

    name == "rej64" && File.write!("body.html", body)
    [[_, value] | _] = Regex.scan(~r/name="#{name}".*value="([\w, \-, \|, \=, \+, \/]*)"/, body)
    value
  end

  def cookies(headers) do
    cookies = Enum.filter(headers, fn
    {key, _} -> String.match?(key, ~r/\Aset-cookie\z/i)
    end)
    |> Enum.map(fn {_, str} -> str end)
  end

end
