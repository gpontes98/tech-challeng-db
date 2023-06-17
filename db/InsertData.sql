-- CADASTRANDO 1 CLIENTE
INSERT INTO customers (customer_name, customer_email, customer_cpf, is_active) VALUES ('Gabriel de Barros Pontes', 'gabrielpontes98@gmail.com', '46272039859', 1);

-- CADASTRANDO OS STATUS DA FILA - Recebido, Em Preparação, Pronto e Finalizado
INSERT INTO status_queue_enum (status_queue) VALUES ('Recebido');
INSERT INTO status_queue_enum (status_queue) VALUES ('Em Preparação');
INSERT INTO status_queue_enum (status_queue) VALUES ('Pronto');
INSERT INTO status_queue_enum (status_queue) VALUES ('Finalizado');

-- CADASTRANDO OS TIPOS DE ITENS - Bebida, Lanche, Acompanhamento, Sombremesa
INSERT INTO itemTypeEnum (type_name) VALUES ('Bebida');
INSERT INTO itemTypeEnum (type_name) VALUES ('Lanche');
INSERT INTO itemTypeEnum (type_name) VALUES ('Acompanhamento');
INSERT INTO itemTypeEnum (type_name) VALUES ('Sobremesa');

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