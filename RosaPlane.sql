CREATE DATABASE rosaplane;

USE rosaplane;
CREATE TABLE destinos (
	id_destino INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nomeDestino VARCHAR(60),
    pais VARCHAR(60),
    descricao VARCHAR(100)
);

CREATE TABLE pacotes (
	id_pacote INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nomePacote VARCHAR(60) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
	dataInicio DATE NOT NULL,
    dataTermino DATE NOT NULL,
    id_destino INT,
    FOREIGN KEY (id_destino) REFERENCES destinos(id_destino)
);

CREATE TABLE clientes(
	id_cliente INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nomeCliente VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    endereco VARCHAR(100) NOT NULL
);

CREATE TABLE reservas(
	id_reserva INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	dataReserva DATE NOT NULL,
    numeroPessoas INT,
    statusReserva VARCHAR(60) NOT NULL,
	id_cliente INT,
    id_pacote INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_pacote) REFERENCES pacotes(id_pacote)
);

INSERT INTO destinos ( nomeDestino, pais, descricao)
VALUES ("Ilhas Maldivas", "Maldivas", "Ilhas paradisiácas na ásia, conhecida pelas praias e palas lagoas azuis"),
	   ("Pinheirinho", "Brasil", "Venha presenciar o embate entre roger e cabelo"),
       ("Santiago Bernabéu", "Espanha", "Estádio localizado em madrid, local no qual ocorre os jogos do gigante Real Madrid");
       
INSERT INTO pacotes ( nomePacote, preco, dataInicio, dataTermino, id_destino)
VALUES ("Na Ilha", 12500.00, '2024-09-22', '2024-10-02', 1),
	   ("De volta pra quebra", 100.00, '2024-10-30', '2024-11-07', 2),
       ("Dia de champions", 10000.00, '2024-12-18', '2025-02-02', 3);
       
INSERT INTO clientes ( nomeCliente, email, telefone, endereco)
VALUES ("Sergio", "sergio@gmail.com", "11987654321", "Rua longe, Taboão da serra"),
	   ("Paola", "paola@gmail.com", "11912345678", "Rua perto, Embu das artes"),
       ("Luana", "luana@gmail.com", "11954321879", "Rua distante, Cotia");
       
INSERT INTO reservas ( dataReserva, numeroPessoas, statusReserva, id_cliente, id_pacote)
VALUES ('2024-09-27', 8, "Confirmada", 2, 1),
	   ('2024-10-11', 3, "Cancelada", 1, 3),
       ('2024-06-07', 8, "Pendente", 3, 2);
       
CREATE VIEW PacotesDestinos AS
SELECT pas.id_pacote, pas.nomePacote, pas.preco, pas.dataInicio, pas.dataTermino, 
       des.nomeDestino, des.pais, des.descricao
FROM pacotes pas
JOIN destinos des ON pas.id_destino = des.id_destino;

CREATE VIEW ReservasClientesPacotes AS
SELECT res.id_reserva, res.dataReserva, res.numeroPessoas, res.statusReserva, 
       cli.nomeCliente, cli.email, cli.telefone, pro.nomePacote, pro.preco, des.nomeDestino
FROM reservas res
JOIN clientes cli ON res.id_cliente = cli.id_cliente
JOIN pacotes pro ON res.id_pacote = pro.id_pacote
JOIN destinos des ON pro.id_destino = des.id_destino;

CREATE VIEW ClientesReservas AS
SELECT cli.id_cliente, cli.nomeCliente, cli.email, res.id_reserva, 
       rse.dataReserva, res.numeroPessoas, res.statusReserva
FROM clientes cli
LEFT JOIN reservas res ON cli.id_cliente = res.id_cliente;

SELECT nomePacote, preco, dataInicio, dataTermino
FROM pacotes
WHERE preco > 5000;

SELECT * 
FROM ReservasClientesPacotes
WHERE statusReserva = "Confirmada";

SELECT pac.nomePacote, res.statusReserva, res.numeroPessoas
FROM pacotes pac
JOIN reservas res ON pac.id_pacote = res.id_pacote
WHERE res.statusReserva = "Pendente";
