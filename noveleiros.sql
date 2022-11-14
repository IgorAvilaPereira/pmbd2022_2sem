DROP DATABASE IF EXISTS noveleiros;

CREATE DATABASE noveleiros;

\c noveleiros;

CREATE TABLE novelas (
    codigo serial primary key,
    nome text not null,
    data_primeiro_capitulo date,
    data_ultimo_capitulo date,
    horario_exibicao time
);


CREATE TABLE capitulos (
    codigo serial primary key,
    nome text,
    data_exibicao date,
    cod_novela integer references novelas (codigo)
);

CREATE TABLE atores (
    codigo serial primary key,
    nome text,
    data_nascimento date,
    cidade text,
    salario money,
    sexo char(1) CHECK(sexo = 'F' OR sexo = 'M')
);

CREATE TABLE personagens (
    codigo serial primary key,
    nome text,
    data_nascimento date,
    situacao_financeira character(1),
    cod_ator integer references atores (codigo)
);

CREATE TABLE novelas_personagens (
    cod_novela integer references novelas (codigo),
    cod_personagem integer references personagens (codigo),
    primary key (cod_novela, cod_personagem)
);


