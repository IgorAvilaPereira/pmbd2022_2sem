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

INSERT INTO novelas (nome, horario_exibicao) VALUES
('TRAVESSIA', '21:00'),
('REI DO GADO', '15:00'),
('GREYS ANATOMY', '22:00'),
('BEIJO DO VAMPIRO', '19:00');

INSERT INTO novelas (nome, data_ultimo_capitulo) VALUES
('MISTÉRIOS DE UMA VIDA', '2022-10-28');


CREATE TABLE capitulos (
    codigo serial primary key,
    nome text,
    data_exibicao date,
    cod_novela integer references novelas (codigo)
);
INSERT INTO capitulos (nome, data_exibicao, cod_novela) VALUES
('MEREDITH SAI DA SERIE', '2022-11-28', 3),
('MEZENGA E BERDINATES', '2022-11-29', 2);

CREATE TABLE atores (
    codigo serial primary key,
    nome text,
    data_nascimento date,
    cidade text,
    salario money,
    sexo char(1) CHECK(sexo = 'F' OR sexo = 'M')
);

INSERT INTO atores(nome, salario, sexo) VALUES
('elen pompeo', 6000000, 'F'),
('antonio fagundes', 10000, 'M'); 

INSERT INTO atores(nome, salario, sexo, cidade) VALUES
('RYAN REINOLDS', 10000000, 'M', 'MACHASSUTES'),
('CRIS EVANS', 50000000, 'M', 'MINESSOTA');

CREATE TABLE personagens (
    codigo serial primary key,
    nome text,
    data_nascimento date,
    situacao_financeira character(1),
    cod_ator integer references atores (codigo)
);
INSERT INTO personagens (nome, cod_ator) VALUES
('MEREDITH GREY', 1),
('BRUNO MEZENGA', 2);

INSERT INTO personagens (nome, cod_ator, data_nascimento) VALUES
('JOVEM MEREDITH GREY YOUNG SHELDON', 1, '2008-01-01');

CREATE TABLE novelas_personagens (
    cod_novela integer references novelas (codigo),
    cod_personagem integer references personagens (codigo),
    primary key (cod_novela, cod_personagem)
);
INSERT INTO novelas_personagens (cod_novela, cod_personagem) VALUES
(2,2),
(3,1);


--2) noveleiros=# SELECT data_ultimo_capitulo FROM novelas WHERE nome = 'MISTÉRIOS DE UMA VIDA';
-- 3) noveleiros=# SELECT nome FROM novelas WHERE horario_exibicao IS NULL;
-- 4) noveleiros=# select * from atores where cidade  LIKE 'M%';     
-- 5) noveleiros=# SELECT COUNT(*) AS quantidade FROM novelas WHERE nome iLIKE '%VIDA%' OR nome iLIKE 'VIDA%';         
-- 6) noveleiros=# Select * from personagens ORDER BY nome ASC;
-- 7) noveleiros=# select nome, extract(year from AGE(data_nascimento)) from personagens order by age(data_nascimento) DESC;
-- 8) noveleiros=# SELECT count(*) as qtde_atores from atores;
-- 9) noveleiros=# Select count(*) from novelas;
-- 10) noveleiros=# SELECT COUNT(*) FROM atores WHERE sexo = 'F';
-- 11) noveleiros=# SELECT CAST(AVG(EXTRACT(YEAR FROM AGE(data_nascimento))) AS INTEGER) AS media FROM personagens;
-- 12) noveleiros=# SELECT nome, extract(year from age(data_nascimento)) as idade FROM personagens WHERE extract(year from age(data_nascimento)) < 15;
-- 13) noveleiros=# SELECT MAX(salario) from atores;
-- 14) noveleiros=# SELECT MIN(salario) from atores;
-- 15) noveleiros=# SELECT SUM(salario) from atores;


