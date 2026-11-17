# Raízes — Livraria & Café Cristão

Projeto web instalável (PWA) com catálogo, filtros, carrinho, fluxo de entrega na mesa/balcão/presente, pedidos de demonstração e painel administrativo.

## Publicar
1. Crie um repositório no GitHub e envie o conteúdo desta pasta (sem `node_modules`).
2. Na Vercel, clique **Add New → Project**, importe o repositório e use framework **Vite**; Build Command `npm run build`, Output Directory `dist`.
3. Clique Deploy. A Vercel atribuirá uma URL disponível `*.vercel.app`.
4. Para dados reais, crie projeto Supabase e execute `schema.sql` no SQL Editor.
5. Na Vercel → Project → Settings → Environment Variables, defina `VITE_SUPABASE_URL` e `VITE_SUPABASE_PUBLISHABLE_KEY`. Faça redeploy.
6. Em Supabase Auth, crie usuário de funcionário e atribua `admin` conforme comentário final do SQL. No app, entre na aba **Equipe**.

## Limitações deliberadas de segurança
- **Não há cobrança real.** Pix, cartão e caixa são opções simuladas, sem gateway nem aprovação de pagamentos.
- Pedidos de clientes no modo demonstração são locais ao navegador; não são gravados no banco e não aparecem em outros tablets.
- O banco Supabase disponibiliza catálogo real e painel autenticado para leitura de pedidos, mas **não** permite inserção pública de pedidos. Para produção, implemente backend autenticado com reserva atômica de estoque, validação de preços, proteção contra spam, integração de pagamento e webhooks verificados.
- Capas e amostras somente quando fornecidas por fontes licenciadas. Textos e preços de exemplo não representam estoque/preços reais.
- Nunca coloque `service_role` ou segredo de pagamento em variável `VITE_`.
- PWA instalável: manifest incluído. Ícone SVG; compatibilidade de instalação varia por navegador.

## Desenvolvimento
`npm install` e `npm run dev`.

## Novo: leitor de texto e áudio (v1.1)
- Abra um livro e clique **Ler ou ouvir degustação**. Em modo demonstração, o conteúdo é texto original criado para o app, não o capítulo real da obra.
- O botão **Ouvir** usa a API Web Speech (`speechSynthesis`) e tenta selecionar uma voz `pt-BR` instalada no navegador/dispositivo. A qualidade e disponibilidade da voz variam. Não há geração ou hospedagem de MP3.
- Controles de ouvir/pausar/parar, velocidades 0,75x, 1x, 1,25x, 1,5x, acompanhamento por trecho e retomada no mesmo navegador via `localStorage`.
- Botões de comprar e presentear levam ao checkout de demonstração existente.
- Para Supabase já configurado, execute `migration_audio.sql` no SQL Editor; para projeto novo, use `schema.sql`.
- Para cadastrar uma amostra licenciada, o administrador do banco pode preencher `books.sample_text` pelo Table Editor do Supabase. Somente publique texto com autorização ou em domínio público. A interface atual não oferece upload de áudio gravado nem sincronização palavra por palavra.
- Se a leitura não funcionar, confirme que o dispositivo oferece voz em português brasileiro e que o navegador permite síntese de fala.

## Novo: QR Code individual (v1.2)
- Cada página de livro apresenta QR Code gerado localmente com o pacote `qrcode` e link no formato `https://SEU-SITE.vercel.app/?livro=ID`.
- Ao escanear, o celular abre diretamente a página do título. O botão **Ler ou ouvir degustação** abre o leitor de texto/voz, quando existe amostra autorizada; caso contrário o livro continua acessível sem prévia.
- Botões **Copiar link** e **Imprimir etiqueta** disponíveis na página de detalhes. Para imprimir a etiqueta correta, abra o título e use **Imprimir etiqueta**.
- **Atenção:** os códigos devem ser impressos SOMENTE a partir do endereço definitivo publicado na Vercel. QR Codes gerados no `localhost`, no domínio de preview ou em um domínio antigo não funcionarão como esperado nos celulares dos clientes.
- O progresso de leitura é salvo no navegador de cada aparelho e não é sincronizado entre aparelhos. A voz pt-BR depende do navegador/sistema operacional.
- Não há necessidade de alterar o esquema SQL para esta atualização.
