USE DeliverySystem;

-- Esta tabela armazena informações dos clientes, como ID, CPF, nome e e-mail.
CREATE TABLE customers (
    id INT auto_increment PRIMARY KEY,
    customer_cpf VARCHAR(11) UNIQUE,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL,
    is_active BOOLEAN NOT NULL
);

-- Esta tabela armazena informações dos pedidos, como ID, data do pedido, total do pedido e o ID do cliente associado ao pedido.
CREATE TABLE orders (
  id INT auto_increment PRIMARY KEY,
  order_date DATE NOT NULL,
  order_total FLOAT NOT NULL,
  customer_id INT,
  FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Esta tabela armazena os tipos de itens disponíveis.
CREATE TABLE item_type_enum (
  id INT auto_increment PRIMARY KEY,
  type_name VARCHAR(100) NOT NULL
);

-- Esta tabela armazena informações dos itens, como ID, ID do tipo de item, nome e preço.
CREATE TABLE itens (
  id INT auto_increment PRIMARY KEY,
  item_type_id INT NOT NULL,
  FOREIGN KEY (item_type_id) REFERENCES item_type_enum(id),
  item_name VARCHAR(100) NOT NULL,
  item_price FLOAT NOT NULL
);

-- Esta tabela relaciona os itens de um pedido específico, registrando o ID do pedido, o ID do item, a quantidade do item no pedido e um ID exclusivo para o relacionamento.
CREATE TABLE order_item (
  id INT auto_increment PRIMARY KEY,
  order_id INT NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  item_id INT NOT NULL,
  FOREIGN KEY (item_id) REFERENCES itens(id),
  order_item_qtd INT NOT NULL
);

-- Esta tabela armazena os diferentes status possíveis para a fila de pedidos.
CREATE TABLE status_queue_enum (
  id INT auto_increment PRIMARY KEY,
  status_queue VARCHAR(100) NOT NULL
);

-- Esta tabela registra os pedidos na fila, incluindo o ID do pedido, a posição na fila, o ID do status da fila e um ID exclusivo para o relacionamento.
CREATE TABLE order_queue (
  id INT auto_increment PRIMARY KEY,
  order_id INT NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  position INT NOT NULL,
  status_queue_enum_id INT NOT NULL,
  FOREIGN KEY (status_queue_enum_id) REFERENCES status_queue_enum(id)
);

-- Definindo a codificação de caracteres para UTF-8
SET character_set_client = utf8;
SET character_set_connection = utf8;
SET character_set_results = utf8;
SET collation_connection = utf8_general_ci;

-- CADASTRANDO 1 CLIENTE
INSERT INTO customers (customer_name, customer_email, customer_cpf, is_active) VALUES ('Gabriel de Barros Pontes', 'gabrielpontes98@gmail.com', '46272039859', 1);

-- CADASTRANDO OS STATUS DA FILA - Recebido, Em Preparação, Pronto e Finalizado
INSERT INTO status_queue_enum (status_queue) VALUES ('Recebido');
INSERT INTO status_queue_enum (status_queue) VALUES ('Em Preparação');
INSERT INTO status_queue_enum (status_queue) VALUES ('Pronto');
INSERT INTO status_queue_enum (status_queue) VALUES ('Finalizado');

-- CADASTRANDO OS TIPOS DE ITENS - Bebida, Lanche, Acompanhamento, Sombremesa
INSERT INTO item_type_enum (type_name) VALUES ('Bebida');
INSERT INTO item_type_enum (type_name) VALUES ('Lanche');
INSERT INTO item_type_enum (type_name) VALUES ('Acompanhamento');
INSERT INTO item_type_enum (type_name) VALUES ('Sobremesa');

-- CADASTRANDO UM ITEM DE CADA CATEGORIA
INSERT INTO itens (item_type_id, item_name, item_price) VALUES (1, 'Coca-cola', 5.90);
INSERT INTO itens (item_type_id, item_name, item_price) VALUES (2, 'X-Tudo', 16.90);
INSERT INTO itens (item_type_id, item_name, item_price) VALUES (3, 'Batata-Frita', 9.90);
INSERT INTO itens (item_type_id, item_name, item_price) VALUES (4, 'Sorvete de Morango', 2.90);

-- CADASTRANDO UM PEDIDO COM A DATA ATUAL PARA O PRIMEIRO CLIENTE
INSERT INTO orders (order_date, order_total, customer_id) VALUES (current_date(), 35.60, 1);

-- CADASTRANDO UM ITEM DE CADA CATEGORIA AO PEDIDO
INSERT INTO order_item (order_id, item_id, order_item_qtd) VALUES (1, 1, 1);
INSERT INTO order_item (order_id, item_id, order_item_qtd) VALUES (1, 2, 1);
INSERT INTO order_item (order_id, item_id, order_item_qtd) VALUES (1, 3, 1);
INSERT INTO order_item (order_id, item_id, order_item_qtd) VALUES (1, 4, 1);

-- CADASTRANDO O PEDIDO NA TABELA DE FILA
INSERT INTO order_queue (order_id, position, status_queue_enum_id) VALUES (1, 1, 1);