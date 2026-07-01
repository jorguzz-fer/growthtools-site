# Growth Tools × Coratti — Landing

Site estático (`v1.html`) empacotado como imagem Nginx, pronto para deploy no **Coolify**.

## Deploy no Coolify (via VPS)

Pré-requisito: Coolify já instalado e rodando na sua VPS, com o domínio apontando (registro A) para o IP do servidor.

1. No painel do Coolify, crie um **New Resource → Application**.
2. Fonte: **Public/Private Repository** → conecte este repositório
   (`jorguzz-fer/growthtools-site`) e escolha a branch (`main`).
3. **Build Pack: Dockerfile** — o Coolify detecta o `Dockerfile` da raiz
   automaticamente. Nenhum comando de build extra é necessário.
4. **Port**: `80` (o container Nginx expõe a porta 80).
5. Em **Domains**, informe o seu domínio (ex.: `https://proposta.seudominio.com`).
   O Coolify provisiona o certificado TLS via Let's Encrypt automaticamente.
6. Clique em **Deploy**.

A cada `git push` na branch configurada, o Coolify pode refazer o deploy
automaticamente (habilite o webhook em *Settings → Webhooks* se quiser CI/CD).

## Testar localmente

```bash
docker build -t growthtools-site .
docker run --rm -p 8080:80 growthtools-site
# abra http://localhost:8080
```

## Estrutura

- `v1.html` — o site (single-page, sem dependências de build).
- `Dockerfile` — imagem `nginx:alpine` que serve o site.
- `nginx.conf` — config do servidor (serve `v1.html` na raiz, headers, gzip).
