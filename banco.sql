CREATE DATABASE IF NOT EXISTS banco;

USE banco;

CREATE TABLE Banco (
    codigo_banco INT PRIMARY KEY,
    nome VARCHAR(255)
);

CREATE TABLE Agencia (
    numero_agencia INT PRIMARY KEY,
    endereco VARCHAR(255),
    codigo_banco INT,
    FOREIGN KEY (codigo_banco) REFERENCES Banco(codigo_banco)
);

CREATE TABLE Conta (
    numero_conta INT PRIMARY KEY,
    saldo DECIMAL(15, 2),
    tipo VARCHAR(50)
);

CREATE TABLE Cliente (
    cpf VARCHAR(14) PRIMARY KEY,
    nome VARCHAR(255),
    sexo CHAR(1),
    telefone VARCHAR(20),
    endereco_cidade VARCHAR(100),
    endereco_estado CHAR(2),
    endereco_cep VARCHAR(9),
    endereco_logradouro VARCHAR(255)
);

CREATE TABLE Telefone (
    id_telefone INT PRIMARY KEY AUTO_INCREMENT,
    numero_telefone VARCHAR(20),
    tipo_telefone VARCHAR(50),
    cpf_cliente VARCHAR(14),
    FOREIGN KEY (cpf_cliente) REFERENCES Cliente(cpf)
);

CREATE TABLE Conta_Cliente (
    id_conta_cliente INT PRIMARY KEY AUTO_INCREMENT,
    numero_conta INT,
    cpf_cliente VARCHAR(14),
    FOREIGN KEY (numero_conta) REFERENCES Conta(numero_conta),
    FOREIGN KEY (cpf_cliente) REFERENCES Cliente(cpf)
);

CREATE TABLE Emprestimo (
    numero_emprestimo INT PRIMARY KEY AUTO_INCREMENT,
    valor DECIMAL(15, 2),
    tipo VARCHAR(50),
    cpf_cliente VARCHAR(14),
    data_contratacao DATE,
    numero_agencia INT,
    FOREIGN KEY (cpf_cliente) REFERENCES Cliente(cpf),
    FOREIGN KEY (numero_agencia) REFERENCES Agencia(numero_agencia)
);

ALTER TABLE Conta ADD CONSTRAINT fk_conta_cliente FOREIGN KEY (cpf_cliente) REFERENCES Cliente(cpf);

ALTER TABLE Emprestimo ADD CONSTRAINT chk_max_emprestimos_cliente CHECK (
    (SELECT COUNT(*) FROM Emprestimo WHERE cpf_cliente = Emprestimo.cpf_cliente) <= 2
);

ALTER TABLE Emprestimo ADD CONSTRAINT fk_agencia_limite_emprestimos CHECK (
    (SELECT COUNT(*) FROM Emprestimo WHERE numero_agencia = Emprestimo.numero_agencia) <= 1000
);