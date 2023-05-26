-- Deletar um Banco de Dados existente com o mesmo nome -- 
DROP DATABASE uvv;

-- Deletar nome de usuário caso exista --
DROP USER IF EXISTS jvnunes;

-- Criando um usuário --
CREATE USER     jvnunes 
WITH            CREATEDB
PASSWORD        'uvvbd';

-- Criar um Banco de Dados --
CREATE DATABASE uvv
OWNER               jvnunes
TEMPLATE            template0
ENCODING            UTF8
LC_COLLATE          'pt_BR.UTF-8'
LC_CTYPE            'pt_BR.UTF-8'
ALLOW_CONNECTIONS   true
;

-- (\c) vai conectar o usuário ao Banco de dados --
\c uvv jvnunes;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------ Criação das tabelas ----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Criação da tabelas produtos --
CREATE TABLE produtos (
    produto_id                  NUMERIC(38)     NOT NULL,
    nome                        VARCHAR(255)    NOT NULL,
    preco_unitario              NUMERIC(10,2),
    detalhes                    BYTEA,
    imagem                      BYTEA,
    imagem_mine_type            VARCHAR(512),
    imagem_arquivo              VARCHAR(512),
    imagem_charset              VARCHAR(512),
    imagem_ultima_atualizacao   DATE
);

-- Comentarios da tabela produtos -- 
COMMENT ON TABLE produtos IS 'Essa é a criação da tabela produtos';
COMMENT ON COLUMN produtos.produto_id IS 'Essa é a criação da coluna que vai mostrar o id dos produtos, sendo essa a PK';
COMMENT ON COLUMN produtos.nome IS 'Essa é a criação da coluna que vai mostrar os nomes dos produtos, não podendo estar vazia';
COMMENT ON COLUMN produtos.preco_unitario IS 'Essa é a criação da coluna que vai mostrar os preços dos produtos';

-- Criação da tabelas lojas --
CREATE TABLE lojas (
    loja_id                     NUMERIC(38)     NOT NULL,
    nome                        VARCHAR(255)    NOT NULL,
    endereco_web                VARCHAR(100),
    endereco_fisico             VARCHAR(512),
    latitude                    NUMERIC,
    longitude                   NUMERIC,
    logo                        BYTEA,
    logo_mine_type              VARCHAR(512),
    logo_arquivo                VARCHAR(512),
    logo_charset                VARCHAR(512),
    logo_ultima_atualizacao     DATE
);

-- Comentarios da tabela lojas -- 
COMMENT ON TABLE lojas IS 'Essa é a criação da tabela loja';
COMMENT ON COLUMN lojas.loja_id IS 'id das lojas';
COMMENT ON COLUMN lojas.nome IS 'Essa é a criação da coluna que vai mostrar os nomes das lojas, não podendo estar vazia';
COMMENT ON COLUMN lojas.endereco_web IS 'Essa é a criação da coluna que vai mostrar o endereço web';
COMMENT ON COLUMN lojas.endereco_fisico IS 'Essa é a criação da coluna que vai mostrar os endereços da lojas fisicas';
COMMENT ON COLUMN lojas.latitude IS 'Essa é a criação da coluna que vai mostrar os locais das lojas em latitude, sendo de 0 a -90 Sul e 0 e 90 Norte';
COMMENT ON COLUMN lojas.longitude IS 'Essa é a criação da coluna que vai mostrar os locais das lojas em longitude, sendo de 0 a -180 oeste e 0 e 180 leste';

-- Criação da tabelas estoques --
CREATE TABLE estoques (
    estoque_id      NUMERIC(38)     NOT NULL,
    loja_id         NUMERIC(38)     NOT NULL,
    produto_id      NUMERIC(38)     NOT NULL,
    quantidade      NUMERIC(38)     NOT NULL
);

-- Comentarios da tabela estoques -- 
COMMENT ON TABLE estoques IS 'Essa é a criação da tabela estoque';
COMMENT ON COLUMN estoques.estoque_id IS 'Essa é a criação da coluna que vai mostrar o id dos estoques, sendo essa a PK';
COMMENT ON COLUMN estoques.loja_id IS 'Essa é a criação da coluna que vai mostrar o id das lojas,sendo a FK e não podendo estar vazio';
COMMENT ON COLUMN estoques.produto_id IS 'Essa é a criação da coluna que vai mostrar o id dos produtos, sendo essa a FK e não podendo estar vazia';
COMMENT ON COLUMN estoques.quantidade IS 'Essa é a criação da coluna que vai mostrar a quantidade de produtos no estoque, não podendo estar vazia';

-- Criação da tabelas clientes --
CREATE TABLE clientes (
    cliente_id      NUMERIC(38)     NOT NULL,
    email           VARCHAR(255)    NOT NULL,
    nome            VARCHAR(255)    NOT NULL,
    telefone1       VARCHAR(20),
    telefone2       VARCHAR(20),
    telefone3       VARCHAR(20)
);

-- Comentarios da tabela clientes -- 
COMMENT ON TABLE clientes IS 'Essa é a criação da tabela clientes';
COMMENT ON COLUMN clientes.cliente_id IS 'Essa é a criação da coluna que vai mostrar o id dos clientes, sendo essa a PK';
COMMENT ON COLUMN clientes.email IS 'Essa é a criação da coluna que vai mostrar os email dos clientes, não podendo estar vazia';
COMMENT ON COLUMN clientes.nome IS 'Essa é a criação da coluna que vai mostrar os nomes dos clientes, não podendo estar vazia';
COMMENT ON COLUMN clientes.telefone1 IS 'Essa é a criação da coluna que vai mostrar os telefones dos clientes';
COMMENT ON COLUMN clientes.telefone2 IS 'Essa é a criação da coluna que vai mostrar os telefones dos clientes';
COMMENT ON COLUMN clientes.telefone3 IS 'Essa é a criação da coluna que vai mostrar os telefones dos clientes';

-- Criação da tabelas envios --
CREATE TABLE envios (
    envio_id            NUMERIC(38)     NOT NULL,
    loja_id             NUMERIC(38)     NOT NULL,
    cliente_id          NUMERIC(38)     NOT NULL,
    endereco_entrega    VARCHAR(512)    NOT NULL,
    status              VARCHAR(15)     NOT NULL
);

-- Comentarios da tabela envios -- 
COMMENT ON TABLE envios IS 'Essa é a criação da tabela envios';
COMMENT ON COLUMN envios.envio_id IS 'Essa é a criação da coluna que vai mostrar o id dos envios, sendo essa a PK';
COMMENT ON COLUMN envios.loja_id IS 'Essa é a criação da coluna que vai mostrar o id das lojas,sendo a FK e não podendo estar vazio';
COMMENT ON COLUMN envios.cliente_id IS 'Essa é a criação da coluna que vai mostrar o id dos clientes,sendo a FK e não podendo estar vazio';
COMMENT ON COLUMN envios.endereco_entrega IS 'Essa é a criação da coluna que vai mostrar os endereços de entregas dos envios, não podendo estar vazia';
COMMENT ON COLUMN envios.status IS 'Essa é a criação da coluna que vai mostrar o status dos envios, não podendo estar vazia';

-- Criação da tabelas pedidos --
CREATE TABLE pedidos (
    pedido_id       NUMERIC(38)     NOT NULL,
    data_hora       TIMESTAMP       NOT NULL,
    cliente_id      NUMERIC(38)     NOT NULL,
    status          VARCHAR(15)     NOT NULL,
    loja_id         NUMERIC(38)     NOT NULL
);

-- Comentarios da tabela pedidos -- 
COMMENT ON TABLE pedidos IS 'Essa é a criação da tabela pedidos';
COMMENT ON COLUMN pedidos.pedido_id IS 'Essa é a criação da coluna que vai mostrar o id dos produtos, sendo essa a PK';
COMMENT ON COLUMN pedidos.data_hora IS 'Essa é a criação da coluna que vai mostrar a data e hora dos pedidos, não podendo estar vazia';
COMMENT ON COLUMN pedidos.cliente_id IS 'Essa é a criação da coluna que vai mostrar o id dos clientes,sendo a FK e não podendo estar vazio';
COMMENT ON COLUMN pedidos.status IS 'Essa é a criação da coluna que vai mostrar o status dos pedidos, não podendo estar vazia';
COMMENT ON COLUMN pedidos.loja_id IS 'Essa é a criação da coluna que vai mostrar o id das lojas,sendo a FK e não podendo estar vazio';

-- Criação da tabelas pedidos_itens --
CREATE TABLE pedidos_itens (
    pedido_id           NUMERIC(38)     NOT NULL,
    produto_id          NUMERIC(38)     NOT NULL,
    numero_da_linha     NUMERIC(38)     NOT NULL,
    preco_unitario      NUMERIC(10,2)   NOT NULL,
    quantidade          NUMERIC(38)     NOT NULL,
    envio_id            NUMERIC(38)
);

-- Comentarios da tabela pedidos_itens -- 
COMMENT ON TABLE pedidos_itens IS 'Essa é a criação da tabela pedidos_itens';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'Essa é a criação da coluna que vai mostrar o id dos pedidos, sendo essa a PK e FK ao mesmo tempo';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'Essa é a criação da coluna que vai mostrar o id dos produtos, sendo essa a PK e FK ao mesmo tempo';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'Essa é a criação da coluna que vai mostrar o numero da linha, não podendo estar vazia';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'Essa é a criação da coluna que vai mostrar os preços dos pedidos, não podendo estar vazia';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'Essa é a criação da coluna que vai mostrar a quantidade de pedidos, não podendo estar vazia';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'Essa é a criação da coluna que vai mostrar o id dos envios, sendo essa a FK';

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------ Criação da PK ----------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- PK da tabela produtos --
ALTER TABLE produtos
ADD CONSTRAINT pk_produto_id
PRIMARY KEY (produto_id);

-- PK da tabela lojas --
ALTER TABLE lojas
ADD CONSTRAINT pk_loja_id
PRIMARY KEY (loja_id);

-- PK da tabela estoques --
ALTER TABLE estoques
ADD CONSTRAINT pk_estoque_id
PRIMARY KEY (estoque_id);

-- PK da tabela clientes --
ALTER TABLE clientes
ADD CONSTRAINT pk_cliente_id
PRIMARY KEY (cliente_id);

-- PK da tabela envios --
ALTER TABLE envios
ADD CONSTRAINT pk_envio_id
PRIMARY KEY (envio_id);

-- PK da tabela pedidos --
ALTER TABLE pedidos
ADD CONSTRAINT pk_pedido_id
PRIMARY KEY (pedido_id);

-- Pk da tabela pedidos_itens -- 
ALTER TABLE pedidos_itens
ADD CONSTRAINT pk_pedido_produto_id
PRIMARY KEY (pedido_id , produto_id);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------ Criação da FK ----------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- FK da tabela estoques --
ALTER TABLE estoques
ADD CONSTRAINT fk_produtos_estoques
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id);

ALTER TABLE estoques
ADD CONSTRAINT fk_lojas_estoques
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id);

-- FK da tabela pedidos --
ALTER TABLE pedidos 
ADD CONSTRAINT fk_lojas_pedidos
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id);

ALTER TABLE pedidos 
ADD CONSTRAINT fk_clientes_pedidos
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id);

-- FK da tabela envios --
ALTER TABLE envios 
ADD CONSTRAINT fk_lojas_envios
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id);

ALTER TABLE envios 
ADD CONSTRAINT fk_clientes_envios
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id);

-- Fk da tabela pedidos_itens --
ALTER TABLE pedidos_itens 
ADD CONSTRAINT fk_envios_pedidos_itens
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id);

ALTER TABLE pedidos_itens 
ADD CONSTRAINT fk_produtos_pedidos_itens
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id);

ALTER TABLE pedidos_itens 
ADD CONSTRAINT fk_pedidos_pedidos_itens
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------ Criação de checagem ----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Checagem na tabela envios --
ALTER TABLE envios
ADD CONSTRAINT cc_envios_status
CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

-- Checagem na tabela pedidos --
ALTER TABLE pedidos
ADD CONSTRAINT cc_pedidos_status
CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

-- Checagem na tabela produtos --
ALTER TABLE produtos
ADD CONSTRAINT cc_produtos_preco_unitario
CHECK (preco_unitario >= 0);

-- Checagem na tabela pedidos_itens --
ALTER TABLE pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_preco_unitario
CHECK (preco_unitario >= 0);

ALTER TABLE pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_quantidade
CHECK (quantidade >= 0);

-- Checagem na tabela estoques --
ALTER TABLE estoques
ADD CONSTRAINT cc_estoques_quantidade
CHECK (quantidade >= 0);

-- Checagem na tabela lojas --
ALTER TABLE lojas
ADD CONSTRAINT cc_lojas_endereco_web_fisico
CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL);

ALTER TABLE lojas
ADD CONSTRAINT cc_lojas_latitude
CHECK (latitude BETWEEN 90 AND -90);

ALTER TABLE lojas
ADD CONSTRAINT cc_lojas_longitude
CHECK (longitude BETWEEN 180 AND -180);

-- Checagem na tabela clientes --
ALTER TABLE clientes
ADD CONSTRAINT cc_clientes_telefone1
CHECK (telefone1 IN ( '(', ')', '-', '+', 0, 1, 2, 3, 4, 5, 6, 7, 8, 9))

ALTER TABLE clientes
ADD CONSTRAINT cc_clientes_telefone2
CHECK (telefone2 IN ( '(', ')', '-', '+', 0, 1, 2, 3, 4, 5, 6, 7, 8, 9))

ALTER TABLE clientes
ADD CONSTRAINT cc_clientes_telefone3
CHECK (telefone3 IN ( '(', ')', '-', '+', 0, 1, 2, 3, 4, 5, 6, 7, 8, 9))

ALTER TABLE clientes
ADD CONSTRAINT cc_clientes_nome
CHECK (nome NOT LIKE '%[0-9]%');
