USE DeliverySystem;

CREATE TABLE order_status (
  id INT auto_increment PRIMARY KEY,
  order_status_name VARCHAR(100)
);

CREATE TABLE customers (
    id INT auto_increment PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_email VARCHAR(100),
    customer_cpf VARCHAR(11) UNIQUE,
    is_active BOOLEAN NOT NULL
);

CREATE TABLE orders (
  id INT auto_increment PRIMARY KEY,
  order_date DATE,
  order_total FLOAT,
  order_status_id INT,
  customer_id INT,
  FOREIGN KEY (order_status_id) REFERENCES order_status(id),
  FOREIGN KEY (customer_id) REFERENCES customers(id)
);

SET character_set_client = utf8;
SET character_set_connection = utf8;
SET character_set_results = utf8;
SET collation_connection = utf8_general_ci;

-- CADASTRANDO 1 CLIENTE
INSERT INTO customers (customer_name, customer_email, customer_cpf, is_active) VALUES ('Gabriel de Barros Pontes', 'gabrielpontes98@gmail.com', '46272039859', 1);

-- CADASTRANDO OS STATUS
INSERT INTO order_status (order_status_name) VALUES ('Recebido');
INSERT INTO order_status (order_status_name) VALUES ('Em Preparação');
INSERT INTO order_status (order_status_name) VALUES ('Pronto');
INSERT INTO order_status (order_status_name) VALUES ('Finalizado');