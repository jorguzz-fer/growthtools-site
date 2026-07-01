# Growth Tools × Coratti — Landing

Site estático (`v1.html`) empacotado como imagem Nginx, pronto para deploy no **Coolify**.

**URL de produção:** https://proposals.growthtools.com.br/coratti

## Cenário

O subdomínio `proposals.growthtools.com.br` **já existe** no Coolify (DNS e TLS
já resolvidos). Este site é uma **nova aplicação** publicada no mesmo subdomínio,
sob o caminho `/coratti` — roteamento por caminho (path-based routing) via Traefik.

## Deploy no Coolify

1. No painel do Coolify, crie um **New Resource → Application**.
2. Fonte: conecte este repositório (`jorguzz-fer/growthtools-site`), branch `main`.
3. **Build Pack: Dockerfile** — detectado automaticamente na raiz.
4. **Port**: `80`.
5. Em **Domains**, informe o domínio **com o caminho**:
   `https://proposals.growthtools.com.br/coratti`
6. Clique em **Deploy**.

### Roteamento por caminho (importante)

- Como o subdomínio já hospeda outra app na raiz (`/`), o Traefik precisa rotear
  `/coratti` para esta aplicação. O Coolify faz isso automaticamente ao informar
  o caminho no campo Domains; o prefixo `/coratti` é mais específico que `/`, então
  tem prioridade sobre a app da raiz.
- **Não é preciso** mexer no DNS nem gerar novo certificado — o subdomínio já existe
  e o TLS já cobre `proposals.growthtools.com.br`.
- O container serve `v1.html` em **qualquer caminho**, então funciona mesmo que o
  Coolify remova ou mantenha o prefixo `/coratti` ao encaminhar a requisição — sem
  risco de loop de redirecionamento.

## Testar localmente

```bash
docker build -t growthtools-site .
docker run --rm -p 8080:80 growthtools-site
# abra http://localhost:8080          (raiz)
# abra http://localhost:8080/coratti  (mesmo conteúdo, valida o path)
```

## Estrutura

- `v1.html` — o site (single-page, sem dependências de build).
- `Dockerfile` — imagem `nginx:alpine` que serve o site.
- `nginx.conf` — config do servidor (serve `v1.html` em qualquer caminho, headers, gzip).
