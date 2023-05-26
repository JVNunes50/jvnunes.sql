-- Deletar um Banco de Dados existente com o mesmo nome -- 
DROP DATABASE uvv;

-- Trocar o dono do Banco de Dados --
REASSIGN OWNED BY jvnunes TO postgres;
DROP OWNED BY jvnunes;

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

-- Criando o SCHEMA do Banco de Dados --
CREATE SCHEMA lojas;
ALTER SCHEMA lojas OWNER TO jvnunes;
ALTER USER jvnunes SET search_path TO lojas, '$user', public;
SET search_path TO lojas, '$user', public;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------ Criação das tabelas ----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Criação da tabelas lojas.produtos --
CREATE TABLE lojas.produtos (
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

-- Comentarios da tabela lojas.produtos -- 
COMMENT ON TABLE lojas.produtos IS 'Essa é a criação da tabela produtos';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'Essa é a criação da coluna que vai mostrar o id dos lojas.produtos, sendo essa a PK';
COMMENT ON COLUMN lojas.produtos.nome IS 'Essa é a criação da coluna que vai mostrar os nomes dos lojas.produtos, não podendo estar vazia';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Essa é a criação da coluna que vai mostrar os preços dos lojas.produtos';

-- Criação da tabelas lojas.lojas --
CREATE TABLE lojas.lojas (
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

-- Comentarios da tabela lojas.lojas -- 
COMMENT ON TABLE lojas.lojas IS 'Essa é a criação da tabela loja';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'id das lojas';
COMMENT ON COLUMN lojas.lojas.nome IS 'Essa é a criação da coluna que vai mostrar os nomes das lojas.lojas, não podendo estar vazia';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Essa é a criação da coluna que vai mostrar o endereço web';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Essa é a criação da coluna que vai mostrar os endereços da lojas.lojas fisicas';
COMMENT ON COLUMN lojas.lojas.latitude IS 'Essa é a criação da coluna que vai mostrar os locais das lojas.lojas em latitude, sendo de 0 a -90 Sul e 0 e 90 Norte';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Essa é a criação da coluna que vai mostrar os locais das lojas.lojas em longitude, sendo de 0 a -180 oeste e 0 e 180 leste';

-- Criação da tabelas lojas.estoques --
CREATE TABLE lojas.estoques (
    estoque_id      NUMERIC(38)     NOT NULL,
    loja_id         NUMERIC(38)     NOT NULL,
    produto_id      NUMERIC(38)     NOT NULL,
    quantidade      NUMERIC(38)     NOT NULL
);

-- Comentarios da tabela lojas.estoques -- 
COMMENT ON TABLE lojas.estoques IS 'Essa é a criação da tabela estoque';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Essa é a criação da coluna que vai mostrar o id dos lojas.estoques, sendo essa a PK';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Essa é a criação da coluna que vai mostrar o id das lojas.lojas,sendo a FK e não podendo estar vazio';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Essa é a criação da coluna que vai mostrar o id dos lojas.produtos, sendo essa a FK e não podendo estar vazia';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Essa é a criação da coluna que vai mostrar a quantidade de lojas.produtos no estoque, não podendo estar vazia';

-- Criação da tabelas lojas.clientes --
CREATE TABLE lojas.clientes (
    cliente_id      NUMERIC(38)     NOT NULL,
    email           VARCHAR(255)    NOT NULL,
    nome            VARCHAR(255)    NOT NULL,
    telefone1       VARCHAR(20),
    telefone2       VARCHAR(20),
    telefone3       VARCHAR(20)
);

-- Comentarios da tabela lojas.clientes -- 
COMMENT ON TABLE lojas.clientes IS 'Essa é a criação da tabela clientes';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Essa é a criação da coluna que vai mostrar o id dos lojas.clientes, sendo essa a PK';
COMMENT ON COLUMN lojas.clientes.email IS 'Essa é a criação da coluna que vai mostrar os email dos lojas.clientes, não podendo estar vazia';
COMMENT ON COLUMN lojas.clientes.nome IS 'Essa é a criação da coluna que vai mostrar os nomes dos lojas.clientes, não podendo estar vazia';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Essa é a criação da coluna que vai mostrar os telefones dos lojas.clientes';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Essa é a criação da coluna que vai mostrar os telefones dos lojas.clientes';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Essa é a criação da coluna que vai mostrar os telefones dos lojas.clientes';

-- Criação da tabelas lojas.envios --
CREATE TABLE lojas.envios (
    envio_id            NUMERIC(38)     NOT NULL,
    loja_id             NUMERIC(38)     NOT NULL,
    cliente_id          NUMERIC(38)     NOT NULL,
    endereco_entrega    VARCHAR(512)    NOT NULL,
    status              VARCHAR(15)     NOT NULL
);

-- Comentarios da tabela lojas.envios -- 
COMMENT ON TABLE lojas.envios IS 'Essa é a criação da tabela envios';
COMMENT ON COLUMN lojas.envios.envio_id IS 'Essa é a criação da coluna que vai mostrar o id dos lojas.envios, sendo essa a PK';
COMMENT ON COLUMN lojas.envios.loja_id IS 'Essa é a criação da coluna que vai mostrar o id das lojas.lojas,sendo a FK e não podendo estar vazio';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'Essa é a criação da coluna que vai mostrar o id dos lojas.clientes,sendo a FK e não podendo estar vazio';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Essa é a criação da coluna que vai mostrar os endereços de entregas dos lojas.envios, não podendo estar vazia';
COMMENT ON COLUMN lojas.envios.status IS 'Essa é a criação da coluna que vai mostrar o status dos lojas.envios, não podendo estar vazia';

-- Criação da tabelas lojas.pedidos --
CREATE TABLE lojas.pedidos (
    pedido_id       NUMERIC(38)     NOT NULL,
    data_hora       TIMESTAMP       NOT NULL,
    cliente_id      NUMERIC(38)     NOT NULL,
    status          VARCHAR(15)     NOT NULL,
    loja_id         NUMERIC(38)     NOT NULL
);

-- Comentarios da tabela lojas.pedidos -- 
COMMENT ON TABLE lojas.pedidos IS 'Essa é a criação da tabela pedidos';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'Essa é a criação da coluna que vai mostrar o id dos lojas.produtos, sendo essa a PK';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Essa é a criação da coluna que vai mostrar a data e hora dos lojas.pedidos, não podendo estar vazia';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Essa é a criação da coluna que vai mostrar o id dos lojas.clientes,sendo a FK e não podendo estar vazio';
COMMENT ON COLUMN lojas.pedidos.status IS 'Essa é a criação da coluna que vai mostrar o status dos lojas.pedidos, não podendo estar vazia';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Essa é a criação da coluna que vai mostrar o id das lojas.lojas,sendo a FK e não podendo estar vazio';

-- Criação da tabelas lojas.pedidos_itens --
CREATE TABLE lojas.pedidos_itens (
    pedido_id           NUMERIC(38)     NOT NULL,
    produto_id          NUMERIC(38)     NOT NULL,
    numero_da_linha     NUMERIC(38)     NOT NULL,
    preco_unitario      NUMERIC(10,2)   NOT NULL,
    quantidade          NUMERIC(38)     NOT NULL,
    envio_id            NUMERIC(38)
);

-- Comentarios da tabela lojas.pedidos_itens -- 
COMMENT ON TABLE lojas.pedidos_itens IS 'Essa é a criação da tabela pedidos_itens';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Essa é a criação da coluna que vai mostrar o id dos lojas.pedidos, sendo essa a PK e FK ao mesmo tempo';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Essa é a criação da coluna que vai mostrar o id dos lojas.produtos, sendo essa a PK e FK ao mesmo tempo';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Essa é a criação da coluna que vai mostrar o numero da linha, não podendo estar vazia';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Essa é a criação da coluna que vai mostrar os preços dos lojas.pedidos, não podendo estar vazia';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Essa é a criação da coluna que vai mostrar a quantidade de lojas.pedidos, não podendo estar vazia';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Essa é a criação da coluna que vai mostrar o id dos lojas.envios, sendo essa a FK';

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------ Criação da PK ----------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- PK da tabela lojas.produtos --
ALTER TABLE lojas.produtos
ADD CONSTRAINT pk_produto_id
PRIMARY KEY (produto_id);

-- PK da tabela lojas.lojas --
ALTER TABLE lojas.lojas
ADD CONSTRAINT pk_loja_id
PRIMARY KEY (loja_id);

-- PK da tabela lojas.estoques --
ALTER TABLE lojas.estoques
ADD CONSTRAINT pk_estoque_id
PRIMARY KEY (estoque_id);

-- PK da tabela lojas.clientes --
ALTER TABLE lojas.clientes
ADD CONSTRAINT pk_cliente_id
PRIMARY KEY (cliente_id);

-- PK da tabela lojas.envios --
ALTER TABLE lojas.envios
ADD CONSTRAINT pk_envio_id
PRIMARY KEY (envio_id);

-- PK da tabela lojas.pedidos --
ALTER TABLE lojas.pedidos
ADD CONSTRAINT pk_pedido_id
PRIMARY KEY (pedido_id);

-- Pk da tabela lojas.pedidos_itens -- 
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT pk_pedido_produto_id
PRIMARY KEY (pedido_id , produto_id);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------ Criação da FK ----------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- FK da tabela lojas.estoques --
ALTER TABLE lojas.estoques
ADD CONSTRAINT fk_produtos_estoques
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id);

ALTER TABLE lojas.estoques
ADD CONSTRAINT fk_lojas_estoques
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id);

-- FK da tabela lojas.pedidos --
ALTER TABLE lojas.pedidos 
ADD CONSTRAINT fk_lojas_pedidos
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id);

ALTER TABLE lojas.pedidos 
ADD CONSTRAINT fk_clientes_pedidos
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id);

-- FK da tabela lojas.envios --
ALTER TABLE lojas.envios 
ADD CONSTRAINT fk_lojas_envios
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id);

ALTER TABLE lojas.envios 
ADD CONSTRAINT fk_clientes_envios
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id);

-- Fk da tabela lojas.pedidos_itens --
ALTER TABLE lojas.pedidos_itens 
ADD CONSTRAINT fk_envios_pedidos_itens
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id);

ALTER TABLE lojas.pedidos_itens 
ADD CONSTRAINT fk_produtos_pedidos_itens
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id);

ALTER TABLE lojas.pedidos_itens 
ADD CONSTRAINT fk_pedidos_pedidos_itens
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------ Criação de checagem ----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Checagem na tabela lojas.envios --
ALTER TABLE lojas.envios
ADD CONSTRAINT cc_envios_status
CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

-- Checagem na tabela lojas.pedidos --
ALTER TABLE lojas.pedidos
ADD CONSTRAINT cc_pedidos_status
CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

-- Checagem na tabela lojas.produtos --
ALTER TABLE lojas.produtos
ADD CONSTRAINT cc_produtos_preco_unitario
CHECK (preco_unitario >= 0);

-- Checagem na tabela lojas.pedidos_itens --
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_preco_unitario
CHECK (preco_unitario >= 0);

ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_quantidade
CHECK (quantidade >= 0);

-- Checagem na tabela lojas.estoques --
ALTER TABLE lojas.estoques
ADD CONSTRAINT cc_estoques_quantidade
CHECK (quantidade >= 0);

-- Checagem na tabela lojas.lojas --
ALTER TABLE lojas.lojas
ADD CONSTRAINT cc_lojas_endereco_web_fisico
CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL);
