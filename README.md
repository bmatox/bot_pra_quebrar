# Bot do Discord em Elixir

Um bot para Discord desenvolvido em **Elixir**, utilizando diversas APIs públicas e gratuitas para oferecer funcionalidades úteis aos usuários. Este projeto foi uma oportunidade para explorar o paradigma da programação funcional e experimentar tecnologias fora da zona de conforto do Java.

## Índice

- [Funcionalidades](#funcionalidades)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Pré-requisitos](#pré-requisitos)
- [Instalação](#instalação)
- [Observações](#observações)

## Funcionalidades

1. **Consulta de Endereço por CEP**

   - **Comando:** `!cep <cep>`
   - **Descrição:** Busca informações detalhadas de um endereço a partir do CEP informado.
   - **API Utilizada:** [BrasilAPI - CEP](https://brasilapi.com.br/docs#tag/CEP)

2. **Informações de Empresas pelo CNPJ**

   - **Comando:** `!cnpj <cnpj>`
   - **Descrição:** Obtém dados importantes de empresas usando o CNPJ.
   - **API Utilizada:** [BrasilAPI - CNPJ](https://brasilapi.com.br/docs#tag/CNPJ)

3. **Gerar Rostos Aleatórios com IA**

   - **Comando:** `!gerarostoIA`
   - **Descrição:** Gera uma imagem realista de um rosto humano utilizando inteligência artificial.
   - **API Utilizada:** [This Person Does Not Exist](https://thispersondoesnotexist.com/)

4. **Busca de Palavras por Prefixo**

   - **Comando:** `!prefixo <prefixo>`
   - **Descrição:** Busca palavras que começam com o prefixo informado, trazendo o significado de cada uma.
   - **API Utilizada:** [Dicionário Aberto](https://dicionario-aberto.net/)

5. **Consulta de Dados de Veículos por Código FIPE**

   - **Comando:** `!fipe <codigo_fipe>`
   - **Descrição:** Oferece informações detalhadas sobre veículos utilizando o código FIPE.
   - **API Utilizada:** [BrasilAPI - FIPE](https://brasilapi.com.br/docs#tag/FIPE)

## Tecnologias Utilizadas

- **Linguagem:** Elixir
- **Paradigma:** Programação Funcional
- **Biblioteca para Discord:** [Nostrum](https://github.com/Kraigie/nostrum)
- **Cliente HTTP:** [HTTPoison](https://github.com/edgurgel/httpoison)
- **Parser JSON:** [Jason](https://github.com/michalmuskala/jason)

## Pré-requisitos

- [Elixir](https://elixir-lang.org/install.html) instalado em sua máquina.
- [Erlang/OTP](https://www.erlang.org/downloads)
- **Token do Bot do Discord:** Você precisará criar um bot no [Discord Developer Portal](https://discord.com/developers/applications) e obter o token.

## Instalação

1. **Clone o repositório:**

   ```bash
   git clone https://github.com/seu_usuario/seu_repositorio.git
   cd seu_repositorio
2. **Instale as dependências:**
   ```bash
   mix deps.get
3. **Configuração**

   Crie um arquivo config/config.exs e adicione o seguinte:
   
```elixir
use Mix.Config

config :nostrum,
  token: "SEU_TOKEN_DO_DISCORD",
  num_shards: :auto
`````
4. **Executando o Bot:**

Inicie o bot com o comando:

```bash
mix run --no-halt
`````

## Observações

### Caminho para Salvamento de Imagens:

Na funcionalidade `!gerarostoIA`, a imagem é salva em um caminho específico.

Certifique-se de ajustar o `caminho_arquivo` no código para um diretório válido em seu sistema.

```elixir
caminho_arquivo = "/seu/caminho/para/face.jpg"
`````


