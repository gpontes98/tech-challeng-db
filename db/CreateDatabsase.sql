USE DeliverySystem;

-- Esta tabela armazena informações dos clientes, como ID, CPF, nome e e-mail.
CREATE TABLE customers (
    id INT auto_increment PRIMARY KEY,
    customer_cpf VARCHAR(11) UNIQUE,
    customer_name VARCHAR(100),
    customer_email VARCHAR(100),
    is_active BOOLEAN NOT NULL
);

-- Esta tabela armazena informações dos pedidos, como ID, data do pedido, total do pedido e o ID do cliente associado ao pedido.
CREATE TABLE orders (
  id INT auto_increment PRIMARY KEY,
  order_date DATETIME NOT NULL,
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
  item_name VARCHAR(100) NOT NULL,
  item_price FLOAT NOT NULL,
  item_description VARCHAR(256),
  item_img_url VARCHAR(256),
  item_type_id INT NOT NULL,
  FOREIGN KEY (item_type_id) REFERENCES item_type_enum(id)
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
  waiting_time TIME NOT NULL,
  order_id INT NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  status_queue_enum_id INT NOT NULL,
  FOREIGN KEY (status_queue_enum_id) REFERENCES status_queue_enum(id)
);

-- Esta tabela armazena os diferentes status possíveis para o pagamento.
CREATE TABLE status_payment_enum (
  id INT auto_increment PRIMARY KEY,
  status_payment VARCHAR(100) NOT NULL
);

-- Esta tabela armazena os diferentes métodos possíveis para o pagamento.
CREATE TABLE payment_method_enum (
  id INT auto_increment PRIMARY KEY,
  payment_method VARCHAR(100) NOT NULL
);

-- Esta tabela armazena informações do pagamento do pedido
CREATE TABLE order_payment (
  id INT auto_increment PRIMARY KEY,
  last_update DATETIME NOT NULL,
  order_id INT NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  status_payment_enum_id INT NOT NULL,
  FOREIGN KEY (status_payment_enum_id) REFERENCES status_payment_enum(id),
  payment_method_enum_id INT NOT NULL,
  FOREIGN KEY (payment_method_enum_id) REFERENCES payment_method_enum(id)
);

-- Definindo a codificação de caracteres para UTF-8
SET character_set_client = utf8;
SET character_set_connection = utf8;
SET character_set_results = utf8;
SET collation_connection = utf8_general_ci;

-- CADASTRANDO CLIENTE DEFAULT
INSERT INTO customers (id, customer_name, is_active) VALUES (1, 'unamed_customer', 1);

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
INSERT INTO itens (item_type_id, item_name, item_description, item_img_url, item_price) VALUES (1, 'Coca-cola', 'Refrigerante sabor cola', 'https://www.shutterstock.com/pt/image-vector/novi-sad-serbia-january-21-2018-1008479416', 5.90);
INSERT INTO itens (item_type_id, item_name, item_description, item_img_url, item_price) VALUES (2, 'X-Tudo', 'Pão, Hamburguer e salada', 'https://www.shutterstock.com/pt/image-vector/3d-rendering-delicious-cheese-burger-2168020455', 16.90);
INSERT INTO itens (item_type_id, item_name, item_description, item_img_url, item_price) VALUES (3, 'Batata-Frita', 'Batata-frita 200gms', 'https://www.shutterstock.com/pt/image-photo/french-fries-510881971', 9.90);
INSERT INTO itens (item_type_id, item_name, item_description, item_img_url, item_price) VALUES (4, 'Sorvete de Morango', 'Delicioso sorvete de morango', 'https://www.shutterstock.com/pt/image-photo/ice-cream-cone-vanilla-strawberry-flavors-645817927', 2.90);

-- CADASTRANDO UM PEDIDO COM A DATA ATUAL PARA O PRIMEIRO CLIENTE
INSERT INTO orders (order_date, order_total, customer_id) VALUES (NOW(), 35.60, 1);

-- CADASTRANDO UM ITEM DE CADA CATEGORIA AO PEDIDO
INSERT INTO order_item (order_id, item_id, order_item_qtd) VALUES (1, 1, 1);
INSERT INTO order_item (order_id, item_id, order_item_qtd) VALUES (1, 2, 1);
INSERT INTO order_item (order_id, item_id, order_item_qtd) VALUES (1, 3, 1);
INSERT INTO order_item (order_id, item_id, order_item_qtd) VALUES (1, 4, 1);

-- CADASTRANDO O PEDIDO NA TABELA DE FILA
INSERT INTO order_queue (order_id, waiting_time, status_queue_enum_id) VALUES (1, '00:05:00', 1);

-- CADASTRANDO OS STATUS DE PAGAMENTO
INSERT INTO status_payment_enum (status_payment) VALUES ('Aprovado');
INSERT INTO status_payment_enum (status_payment) VALUES ('Reprovado');

-- CADASTRANDO AS FORMAS DE PAGAMENTO
INSERT INTO payment_method_enum (payment_method) VALUES ('QrCode');
INSERT INTO payment_method_enum (payment_method) VALUES ('Dinheiro');
INSERT INTO payment_method_enum (payment_method) VALUES ('Crédito');
INSERT INTO payment_method_enum (payment_method) VALUES ('Débito');

-- CADASTRANDO UM PAGAMENTO DE PEDIDO
INSERT INTO order_payment (last_update, order_id, status_payment_enum_id, payment_method_enum_id) VALUES (now(), 1, 1, 1)
