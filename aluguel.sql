DROP DATABASE IF EXISTS netflix;

CREATE DATABASE netflix;

\c netflix;

CREATE TABLE empresa (
    id serial primary key,
    cnpj character(14) unique,
    nome_fantasia text,
    razao_social text,
    nome_dono text
);

-- inserir um registro/tupla em uma determinada tabela (ex: tabela empresa)
INSERT INTO empresa (cnpj, nome_fantasia, razao_social, nome_dono)
VALUES ('11111111111111', 'IGOR NETFLIX ENTREPRISE LTDA CORPORATION', 'IGOR COMPANY', 'IGOR (EU)');

-- atualizando o registro 1
-- UPDATE empresa SET nome_fantasia = 'IDORIS LTDA' WHERE id = 1;



CREATE TABLE cliente (
    id serial primary key,
    cpf character(11) unique,
    nome text not null,
    email text,
    senha text,
    dados_pagamento text,
    empresa_id integer references empresa (id)
);

CREATE TABLE categoria (
    id serial primary key,
    descricao text not null
);

CREATE TABLE filme (
    id serial primary key,
    titulo text,
    sinopse text,
    preco money,
    categoria_id integer references categoria (id)

);

CREATE TABLE aluguel (
    id serial primary key,
    data_inicio date,
    data_fim date,
    valor money,
    cliente_id integer references cliente (id),
    filme_id integer references filme (id)
);

CREATE TABLE ator (
    id serial primary key,
    nome text not null
);


CREATE TABLE ator_filme (
    ator_id integer references ator (id),
    filme_id integer references filme (id),
    primary key (ator_id, filme_id)  
);

-- mostrar o registro da tabela empresa
-- netflix=# SELECT * FROM empresa;




