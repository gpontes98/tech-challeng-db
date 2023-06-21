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
  FOREIGN KEY (item_type_id) REFERENCES itemTypeEnum(id),
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