# Delivery System DataBase

Banco de dados em MySql para controle de pedidos e entrega de uma lanchonete.
Link para acessar modelage do banco de dados:

MIRO: https://miro.com/app/board/uXjVM-1Y1Mo=/?share_link_id=545402683820

## Requisitos

Certifique-se de ter os seguintes requisitos instalados na sua máquina:

- Docker: [Link para download e instalação](https://www.docker.com/get-started)

## Configuração

Siga as etapas abaixo para configurar e executar a aplicação:

1. Clone este repositório para a sua máquina local:

```
git clone https://github.com/gpontes98/tc-delivery-system-db.git
```

2. Faça a build do db via docker (é preciso estar na raiz do projeto):

```
docker build -t deliverysystem-db .
```

3. Execute o container:

```
docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=RootPassword -e MYSQL_DATABASE=DeliverySystem -e MYSQL_USER=MainUser -e MYSQL_PASSWORD=MainPassword deliverysystem-db
```

4. Acesse o banco de forma manual:
   Rode o comando:

```
docker exec -it <container_id> bash
```

Obs.: para descobrir o id do container rode o comando docker ps

Agora você está no bash do container, inicie o mysql como usuário root:

```
mysql -uroot -p
```

Vai pedir a senha
Enter password: RootPassword

Selecione o database que será utilizado:

```
USE DeliverySystem;
```

Agora faça um select de teste:

```
SELECT * FROM order_status;
```

### Usando Docker Compose

Para usar o docker compose é mais simples:

1. Rode o comando docker compose:

```
docker-compose up
```
