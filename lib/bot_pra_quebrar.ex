defmodule BotPraQuebrar do
  use Nostrum.Consumer
  alias Nostrum.Api
  import HTTPoison

  def handle_event({:MESSAGE_CREATE, %Nostrum.Struct.Message{content: content} = msg, _ws_state}) do
    case content do
      "!ping" ->
        Api.create_message(msg.channel_id, "Pong!")

      "!cachorro" ->
        resposta = obter_cachorro()
        Api.create_message(msg.channel_id, resposta)

      _ ->
        :ignore
    end
  end

  defp obter_cachorro do
    url = "https://dog.ceo/api/breeds/image/random"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        cachorro_data = Jason.decode!(body)
        image_url = cachorro_data["message"]
      {:ok, %HTTPoison.Response{status_code: status_code}} when status_code in 400..499 ->
        "Erro ao buscar imagem de cachorro. Verifique a URL."
      {:error, %HTTPoison.Error{reason: reason}} ->
        "Erro ao obter dados: #{reason}."
    end
  end
end
