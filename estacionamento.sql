DROP DATABASE IF EXISTS estacionamento;

CREATE DATABASE estacionamento;

\c estacionamento;

CREATE TABLE cliente (
    cpf character(11) primary key,
    nome character varying(50) not null,
    rua character varying(100),
    bairro character varying(200),
    complemento text,
    nro character varying(8),
    data_nascimento date DEFAULT CURRENT_DATE
);
INSERT INTO cliente (cpf, nome, data_nascimento) VALUES
('11111111111', 'IGOR', '1987-01-20'),
('22222222222', 'MARCIO', '1950-02-02');

CREATE TABLE modelo (
    id serial primary key,
    descricao text not null,
    ano integer check (ano > 1900)
);
INSERT INTO modelo (descricao, ano) VALUES
('FUSCA', 1970),
('BRASILIA', 1980);

CREATE TABLE veiculo (
    chassi integer primary key,
    placa character(7) unique,
    cor character varying(10),
    ano integer,
    cliente_cpf character(11) references cliente (cpf),
    modelo_id integer references modelo (id)
);
INSERT INTO veiculo (chassi, placa, cliente_cpf, modelo_id) VALUES
(213423423, 'IXL1234', '11111111111', 1),
(892347892, 'IUI7809', '22222222222', 2);

CREATE TABLE andar (
    id serial primary key,
    capacidade integer check (capacidade > 0)
);
INSERT INTO andar (capacidade) VALUES 
(100), 
(50);

CREATE TABLE vaga (
    id serial primary key,
    data_hora_entrada timestamp,
    data_hora_saida timestamp,
    valor money,
    andar_id integer references andar (id),
    veiculo_chassi integer references veiculo (chassi)
);
INSERT INTO vaga (data_hora_entrada, data_hora_saida, andar_id, veiculo_chassi) VALUES
(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + '2 HOURS', 1, 213423423),
(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + '4 HOURS', 1, 892347892);

-- atualizar ano da minha fusqueta
estacionamento=# UPDATE veiculo SET ano = 1995 WHERE chassi = 213423423;
-- estacionamento=# SELECT placa, ano FROM veiculo WHERE chassi = 213423423;
-- estacionamento=# SELECT placa, ano FROM veiculo WHERE ano >= 2000;
-- estacionamento=# SELECT * FROM veiculo WHERE modelo_id  = 1;
-- estacionamento=# select * from vaga where veiculo_chassi = 213423423;
-- estacionamento=# select * from vaga LIMIT 1;
-- estacionamento=# select id as vaga, veiculo_chassi as veiculo, (data_hora_saida - data_hora_entrada) as tempo from vaga;
-- estacionamento=# SELECT count(*) as qtde FROM veiculo where modelo_id = 1;
-- estacionamento=# SELECT EXTRACT(YEAR FROM AVG(AGE(data_nascimento))) as media FROM cliente;
-- by ana:
-- estacionamento=# SELECT data_hora_saida - data_hora_entrada as periodo, cast(2*(CAST(EXTRACT(Hour from data_hora_saida) as integer) - CAST(EXTRACT(HOUR from data_hora_entrada) as integer)) as money) valor from vaga;
-- by igor
-- estacionamento=# SELECT data_hora_saida- data_hora_entrada as periodo, cast(2*extract(hour from data_hora_saida - data_hora_entrada) as money) as valor from vaga;









