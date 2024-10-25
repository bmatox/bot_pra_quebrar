defmodule BotPraQuebrar do
  use Nostrum.Consumer
  alias Nostrum.Api
  import HTTPoison

  def handle_event({:MESSAGE_CREATE, %Nostrum.Struct.Message{content: content} = msg, _ws_state}) do
    case content do

      "!cep " <> cep ->
      case obter_endereco(cep) do
        {:ok, endereco} ->
          mensagem = "Endereço: #{endereco.rua}, #{endereco.bairro}, #{endereco.cidade} - #{endereco.estado}, #{endereco.cep}"
          Api.create_message(msg.channel_id, mensagem)

        {:error, erro} ->
          Api.create_message(msg.channel_id, erro)
      end

      "!cnpj " <> cnpj ->
      case obter_cnpj(cnpj) do
        {:ok, cnpj_info} ->
          mensagem = "CNPJ: #{cnpj_info.cnpj}\nRazão Social: #{cnpj_info.razao_social}\nNome Fantasia: #{cnpj_info.nome_fantasia}\nSituação Cadastral: #{cnpj_info.situacao_cadastral}\nData da Situação Cadastral: #{cnpj_info.data_situacao_cadastral}\nEndereço: #{cnpj_info.endereco}\nTelefone: #{cnpj_info.telefone}"
          Api.create_message(msg.channel_id, mensagem)

        {:error, erro} ->
          Api.create_message(msg.channel_id, erro)
      end

     "!gerarostoIA" ->
      case obter_foto_aleatoria() do
        {:ok, caminho_arquivo} ->
          Api.create_message(msg.channel_id, %{
            file: caminho_arquivo,
            content: ""
          })
        {:error, erro} ->
          Api.create_message(msg.channel_id, erro)
      end

      _ ->
        :ignore
    end
  end

  defp obter_endereco(cep) do
    url = "https://brasilapi.com.br/api/cep/v1/#{cep}"
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        endereco_data = Jason.decode!(body)
        endereco = %{
          cep: endereco_data["cep"],
          estado: endereco_data["state"],
          cidade: endereco_data["city"],
          bairro: endereco_data["neighborhood"],
          rua: endereco_data["street"],
          servico: endereco_data["service"]
        }
        {:ok, endereco}

      {:ok, %HTTPoison.Response{status_code: status_code}} when status_code in 400..499 ->
        {:error, "Erro ao buscar endereço. Verifique o CEP."}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Erro ao obter dados: #{reason}."}
    end
  end

  defp obter_cnpj(cnpj) do
    url = "https://brasilapi.com.br/api/cnpj/v1/#{cnpj}"
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        cnpj_data = Jason.decode!(body)
        cnpj_info = %{
          cnpj: cnpj_data["cnpj"],
          descricao_matriz_filial: cnpj_data["descricao_matriz_filial"],
          razao_social: cnpj_data["razao_social"],
          nome_fantasia: cnpj_data["nome_fantasia"],
          situacao_cadastral: cnpj_data["descricao_situacao_cadastral"],
          data_situacao_cadastral: cnpj_data["data_situacao_cadastral"],
          endereco: "#{cnpj_data["descricao_tipo_de_logradouro"]} #{cnpj_data["logradouro"]}, #{cnpj_data["numero"]}, #{cnpj_data["complemento"]}, #{cnpj_data["bairro"]}, #{cnpj_data["municipio"]} - #{cnpj_data["uf"]}, #{cnpj_data["cep"]}",
          telefone: cnpj_data["ddd_telefone_1"]
        }
        {:ok, cnpj_info}

      {:ok, %HTTPoison.Response{status_code: status_code}} when status_code in 400..499 ->
        {:error, "Erro ao buscar informações do CNPJ. Verifique o CNPJ."}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Erro ao obter dados: #{reason}."}
    end
  end

  defp obter_foto_aleatoria do
    url = "https://thispersondoesnotexist.com"
    caminho_arquivo = "C:/Users/Bruno Matos/Pictures/SalvaTemp/face.jpg"
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        File.write!(caminho_arquivo, body)
        {:ok, caminho_arquivo}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Erro ao obter dados: #{reason}."}
    end
  end


end
