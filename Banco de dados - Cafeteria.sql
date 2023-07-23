-- Aluna: Kamile de Souza Novaes

-- Cria um Schema para Cafeterias
CREATE SCHEMA `Cafeterias` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- [1] Tabelas correspondentes ao modelo conceitual
CREATE TABLE Cafe (
  id_preparo INT AUTO_INCREMENT PRIMARY KEY,
  nome_preparo VARCHAR(50) NOT NULL,
  puro ENUM('S', 'N') NOT NULL
);

CREATE TABLE Cafeteria (
  id_cafeteria INT AUTO_INCREMENT PRIMARY KEY,
  nome_fantasia VARCHAR(50) NOT NULL,
  endereco VARCHAR(100) NOT NULL,
  instagram VARCHAR(50) NOT NULL
);

CREATE TABLE Cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nome_cliente VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  dt_nascimento DATE NOT NULL
);

CREATE TABLE Gosta (
  id_cliente INT,
  id_preparo INT,
  PRIMARY KEY (id_cliente, id_preparo),
  FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente),
  FOREIGN KEY (id_preparo) REFERENCES Cafe (id_preparo)
);

CREATE TABLE Oferece (
  id_cafeteria INT,
  id_preparo INT,
  avaliacao DECIMAL(2, 1) NOT NULL,
  preco DECIMAL(6, 2) NOT NULL, -- Suporta valores até 9999.99
  vegano ENUM('S', 'N') NOT NULL,
  PRIMARY KEY (id_cafeteria, id_preparo),
  FOREIGN KEY (id_cafeteria) REFERENCES Cafeteria (id_cafeteria),
  FOREIGN KEY (id_preparo) REFERENCES Cafe (id_preparo)
);

CREATE TABLE Frequenta (
  id_cliente INT,
  id_cafeteria INT,
  PRIMARY KEY (id_cliente, id_cafeteria),
  FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente),
  FOREIGN KEY (id_cafeteria) REFERENCES Cafeteria (id_cafeteria)
);


-- [2] Populando as tabelas

-- a. Insere valores na tabela Cafe
INSERT INTO Cafe (nome_preparo, puro)
VALUES
  ('espresso', 'S'),
  ('doppio', 'S'),
  ('cold brew', 'S'),
  ('capuccino', 'N'),
  ('afogato', 'N'),
  ('café latte', 'N');
  
-- b. Cria as cafeterias e seus atributos
INSERT INTO Cafeteria (nome_fantasia, endereco, instagram)
VALUES
  ('Cafeína', 'Rua do pó moído, n 54', '@cafeteriacafeina'),
  ('Cafezal', 'Avenida do cafe filtrado, 88', '@cafezal_nocopo'),
  ('Cat Café', 'Rua dos grãos torrados', '@cat_cafeoficial'),
  ('Café com pão', 'Rua lanchinho da tarde, n° 22', '@cafecompaozinho');
  
-- c. Adicionando os clientes
INSERT INTO Cliente (nome_cliente, email, dt_nascimento)
VALUES
  ('Antonio', 'antonio@cafe.org', '1980-07-22'),
  ('Alice', 'alice@gmail.com', '1994-01-15'),
  ('Regina', 'regina@yahoo.com', '1999-07-01'),
  ('Guilherme', 'iceland@gmail.com', '2000-10-22'),
  ('Marcelo', 'marcelo@id.uff.br', '1995-01-08');

-- Fazendo a referência ao gosto de cada cliente
INSERT INTO Gosta (id_cliente, id_preparo)
SELECT c.id_cliente, cf.id_preparo
FROM Cliente c, Cafe cf
WHERE c.nome_cliente = 'Antonio' AND cf.nome_preparo IN ('espresso', 'doppio', 'cold brew', 'capuccino')
UNION ALL
SELECT c.id_cliente, cf.id_preparo
FROM Cliente c, Cafe cf
WHERE c.nome_cliente = 'Alice' AND cf.nome_preparo IN ('espresso', 'doppio', 'cold brew', 'afogato')
UNION ALL
SELECT c.id_cliente, cf.id_preparo
FROM Cliente c, Cafe cf
WHERE c.nome_cliente = 'Regina' AND cf.nome_preparo IN ('capuccino', 'café latte')
UNION ALL
SELECT c.id_cliente, cf.id_preparo
FROM Cliente c, Cafe cf
WHERE c.nome_cliente = 'Guilherme' AND cf.nome_preparo IN ('cold brew', 'afogato')
UNION ALL
SELECT c.id_cliente, cf.id_preparo
FROM Cliente c, Cafe cf
WHERE c.nome_cliente = 'Marcelo' AND cf.nome_preparo IN ('espresso', 'doppio', 'cold brew', 'capuccino', 'afogato', 'café latte');

-- Também poderia ser feito:
-- INSERT INTO Gosta (id_cliente, id_preparo)
-- VALUES
--  (1, 1), (1, 2), (1, 3), (1, 4),
--  (2, 1), (2, 2), (2, 3), (2, 5),
--  (3, 4), (3, 6),
--  (4, 3), (4, 5),
--  (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6);
-- Mas como nem sempre vamos saber previamente o ID dos clientes e dos cafés, fiz da outra forma pra aprender.

-- d. Inserindo os preços e avaliações
-- Neste caso vou utilizar os índices já previamente conhecidos (por incremento), senão ficaria um pouco grande.
-- Mas também poderia ser feito da outra maneira utilizando o SELECT/FROM/WHERE.

-- Cafeína
INSERT INTO Oferece (id_cafeteria, id_preparo, avaliacao, preco, vegano)
VALUES
  (1, 1, 4.9, 6.50, 'N'),
  (1, 2, 4.7, 8.90, 'N'),
  (1, 4, 4.2, 11.50, 'S'),
  (1, 6, 3.9, 11.00, 'S');

-- Cafezal
INSERT INTO Oferece (id_cafeteria, id_preparo, avaliacao, preco, vegano)
VALUES
  (2, 1, 4.5, 5.90, 'N'),
  (2, 2, 4.3, 8.50, 'N'),
  (2, 3, 3.9, 16.00, 'N'),
  (2, 4, 4.8, 11.00, 'S'),
  (2, 6, 3.5, 10.00, 'S'),
  (2, 5, 4.5, 15.00, 'S');

-- Cat Café
INSERT INTO Oferece (id_cafeteria, id_preparo, avaliacao, preco, vegano)
VALUES
  (3, 1, 4.3, 6.90, 'N'),
  (3, 2, 3.9, 9.00, 'N'),
  (3, 3, 3.7, 15.00, 'N'),
  (3, 4, 4.5, 12.00, 'N'),
  (3, 5, 4.6, 16.00, 'N'),
  (3, 6, 4.0, 12.00, 'N');

-- Café com pão
INSERT INTO Oferece (id_cafeteria, id_preparo, avaliacao, preco, vegano)
VALUES
  (4, 1, 3.9, 5.50, 'N'),
  (4, 4, 3.5, 10.00, 'N'),
  (4, 6, 3.5, 8.00, 'N');

-- e. Preenchendo a tabela "Frequenta", seguindo a lógica de pesquisar na base de dados.

-- Cafeína
INSERT INTO Frequenta (id_cliente, id_cafeteria)
SELECT c.id_cliente, cf.id_cafeteria
FROM Cliente c, Cafeteria cf
WHERE c.nome_cliente IN ('Alice', 'Antonio', 'Marcelo') AND cf.nome_fantasia = 'Cafeína';

-- Cafezal
INSERT INTO Frequenta (id_cliente, id_cafeteria)
SELECT c.id_cliente, cf.id_cafeteria
FROM Cliente c, Cafeteria cf
WHERE c.nome_cliente IN ('Marcelo', 'Regina', 'Alice') AND cf.nome_fantasia = 'Cafezal';

-- Cat Café
INSERT INTO Frequenta (id_cliente, id_cafeteria)
SELECT c.id_cliente, cf.id_cafeteria
FROM Cliente c, Cafeteria cf
WHERE c.nome_cliente IN ('Regina', 'Marcelo') AND cf.nome_fantasia = 'Cat Café';

-- Café com pão
INSERT INTO Frequenta (id_cliente, id_cafeteria)
SELECT c.id_cliente, cf.id_cafeteria
FROM Cliente c, Cafeteria cf
WHERE c.nome_cliente = 'Antonio' AND cf.nome_fantasia = 'Café com pão';


-- [3] Respondendo às perguntas:

-- a. Combina as tabelas "Oferece", "Cafeteria" e "Cafe" usando JOIN, e filtra para mostrar apenas os 
-- cafés capuccino com avaliação entre 4 e 5.
SELECT cf.nome_fantasia, cf.endereco, cf.instagram, ofr.avaliacao, ofr.preco
FROM Oferece AS ofr
JOIN Cafeteria AS cf ON ofr.id_cafeteria = cf.id_cafeteria
JOIN Cafe AS c ON ofr.id_preparo = c.id_preparo
WHERE c.nome_preparo = 'capuccino' AND ofr.avaliacao BETWEEN 4 AND 5
ORDER BY ofr.avaliacao DESC;

-- b. Combina as tabelas "Frequenta", "Cliente", "Cafeteria" e "Oferece" usando as cláusulas JOIN, e
-- exclui a Alice, para mostrar clientes que também frequentam cafeterias que servem café vegano.
SELECT cl.nome_cliente, cf.nome_fantasia
FROM Frequenta AS fr
JOIN Cliente AS cl ON fr.id_cliente = cl.id_cliente
JOIN Cafeteria AS cf ON fr.id_cafeteria = cf.id_cafeteria
JOIN Oferece AS ofr ON fr.id_cafeteria = ofr.id_cafeteria
WHERE cl.nome_cliente != 'Alice' AND ofr.vegano = 'S'
GROUP BY cl.nome_cliente, cf.nome_fantasia;

-- c. Lista de clientes que ainda não gostam de afogato.
SELECT cl.nome_cliente, cl.email
FROM Cliente AS cl
WHERE cl.id_cliente NOT IN (
  SELECT id_cliente
  FROM Gosta AS g
  JOIN Cafe AS cf ON g.id_preparo = cf.id_preparo
  WHERE cf.nome_preparo = 'afogato'
);

-- d. Compara o preço do espresso em Cafezal com outras cafeterias e imprime as que tem um preço mais caro.
SELECT cf.nome_fantasia, ofr.preco, ofr.avaliacao
FROM Oferece AS ofr
JOIN Cafeteria AS cf ON ofr.id_cafeteria = cf.id_cafeteria
JOIN Cafe AS c ON ofr.id_preparo = c.id_preparo
WHERE c.nome_preparo = 'espresso' AND ofr.preco > (
  SELECT ofr_cafezal.preco
  FROM Oferece AS ofr_cafezal
  JOIN Cafeteria AS cf_cafezal ON ofr_cafezal.id_cafeteria = cf_cafezal.id_cafeteria
  JOIN Cafe AS c_cafezal ON ofr_cafezal.id_preparo = c_cafezal.id_preparo
  WHERE c_cafezal.nome_preparo = 'espresso' AND cf_cafezal.nome_fantasia = 'Cafezal'
);

-- e. Lista os clientes de Cafezal que fazem aniversário em julho, e mostra o nome, e-mail e sua preferencia de cafés.
SELECT c.nome_cliente, c.email, GROUP_CONCAT(ca.nome_preparo SEPARATOR ', ') AS preferencia
FROM Cliente AS c
JOIN Gosta AS g ON c.id_cliente = g.id_cliente
JOIN Cafe AS ca ON g.id_preparo = ca.id_preparo
WHERE c.dt_nascimento LIKE '%-07-%'
GROUP BY c.nome_cliente, c.email;

-- f. Na cafeteria Cafeína, aumenta o preço dos cafés "puros" em 8% e os "não puros" em 5% na tabela "Oferece".
UPDATE Oferece
SET preco = CASE
  WHEN id_preparo IN (
    SELECT id_preparo FROM Cafe WHERE puro = 'S'
  ) THEN preco * 1.08
  ELSE preco * 1.05
  END
WHERE id_cafeteria = (
  SELECT id_cafeteria FROM Cafeteria WHERE nome_fantasia = 'Cafeína'
);

-- g. Deletar a cafeteria Café com pão. 
DELETE FROM Frequenta WHERE id_cafeteria = (
  SELECT id_cafeteria FROM Cafeteria WHERE nome_fantasia = 'Café com Pão'
);

DELETE FROM Oferece WHERE id_cafeteria = (
  SELECT id_cafeteria FROM Cafeteria WHERE nome_fantasia = 'Café com Pão'
);

DELETE FROM Gosta WHERE id_preparo IN (
  SELECT id_preparo FROM Cafe WHERE id_cafeteria = (
    SELECT id_cafeteria FROM Cafeteria WHERE nome_fantasia = 'Café com Pão'
  )
);

DELETE FROM Cafe WHERE id_cafeteria = (
  SELECT id_cafeteria FROM Cafeteria WHERE nome_fantasia = 'Café com Pão'
);

DELETE FROM Cafeteria WHERE nome_fantasia = 'Café com Pão';


-- h. Adiciona o atributo "pesquisa" na tabela Frequenta, pois já está associado os clientes com as cafeterias que eles frequentam.
-- Então eles iriam avaliar cada cafeteria que eles frequentam, com uma nota de 1 a 5, assim como em avaliação.
ALTER TABLE Frequenta ADD pesquisa DECIMAL(3, 1) NOT NULL;









