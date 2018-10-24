defmodule MercadoPago do
  @api_domain "https://api.mercadopago.com/"
  @ep_token @api_domain <> "oauth/token"
  @grant_type_access "client_credentials"

  def get_payment_link(title, description, amount) do
    IO.puts "GETTING LINK"
    case req_link(title, description, amount) do
      {:ok, %HTTPoison.Response{status_code: sc}} when sc >= 400 ->
        new_token()
        get_payment_link(title, description, amount)

      {:ok, %HTTPoison.Response{body: body}} ->
        Poison.decode!(body)
        |> Map.get("init_point")

      {:error, _} ->
        IO.inspect("ERROR")
    end
  end

  def get_token do
    Agent.get(:mp_token, fn state -> state end) || new_token
  end

  defp new_token() do
    case req_new_token do
      {:ok, %HTTPoison.Response{body: body}} ->
        Poison.decode!(body)
        |> save_token

      {:error, _} ->
        IO.puts("Error retriving token... trying again in 10 secs")
        :timer.sleep(10000)
        new_token()
    end
  end

  defp req_new_token do
    HTTPoison.post(
      @ep_token,
      token_payload
    )
  end

  defp token_payload do
    {:form,
     [
       client_id: Application.get_env(:mercado_pago, :client_id) || missing_conf_error("client_id"),
       client_secret: Application.get_env(:mercado_pago, :client_secret) || missing_conf_error("client_secret"),
       grant_type: @grant_type_access
     ]}
  end

  defp req_link(title, description, amount) do
    HTTPoison.post(
      end_point_url(get_token()),
      link_payload(title, description, amount) |> Poison.encode!(),
      [{"Content-Type", "application/json"}]
    )
  end

  defp link_payload(title, description, amount) do
    %{
      items: [
        %{
          title: title,
          description: description,
          quantity: 1,
          currency_id: "ARS",
          unit_price: amount
        }
      ],
      payment_methods: %{
        default_payment_method_id: "pagofacil"
      }
    }
  end

  defp save_token(token) do
    Agent.update(:mp_token, fn _ -> token["access_token"] end)
    token["access_token"]
  end

  defp end_point_url(token) do
    "https://api.mercadopago.com/checkout/preferences?access_token=#{token}"
  end

  defp missing_conf_error(key) do
    IO.puts "#{key} config missing"
  end
end
