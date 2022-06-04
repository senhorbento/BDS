CREATE DATABASE pdv;
USE pdv;

CREATE TABLE Cliente (
    id              INT PRIMARY KEY AUTO_INCREMENT, 
    nome            VARCHAR(100), 
    cpf_cnpj        VARCHAR(14),
    logradouro      VARCHAR(100), 
    numero          VARCHAR(100), 
    complemento     VARCHAR(100), 
    bairro          VARCHAR(100),
    cidade          VARCHAR(100), 
    estado          VARCHAR(100), 
    cep             VARCHAR(8), 
    telefone        VARCHAR(20), 
    email           VARCHAR(100),
    estado_cliente  VARCHAR(10)
);

CREATE TABLE Venda (
    id                  INT PRIMARY KEY AUTO_INCREMENT, 
    data_venda          VARCHAR(15), 
    total_venda         INT, 
    estado_venda        VARCHAR(10),
    id_cliente          INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id)
);

CREATE TABLE ContaReceber (
    id                      INT PRIMARY KEY AUTO_INCREMENT, 
    id_cliente              INT NOT NULL, 
    total_conta             INT NOT NULL, 
    data_lancamento         VARCHAR(15) NOT NULL, 
    data_vencimento         VARCHAR(15) NOT NULL,
    data_recebimento        VARCHAR(15), 
    valor_recebimento       VARCHAR(15),
    estado_conta            VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id)
);

CREATE TABLE FormaPagamento (
    id          INT PRIMARY KEY, 
    nome        VARCHAR(10)
);

CREATE TABLE FormaPagamentoVenda (
    id_forma_pagamento      INT,
    id_venda                INT,
    valor                   INT,
    PRIMARY KEY (id_forma_pagamento, id_venda),
    FOREIGN KEY (id_forma_pagamento) REFERENCES FormaPagamento(id),
    FOREIGN KEY (id_venda) REFERENCES Venda(id)
);

CREATE TABLE Fornecedor (
    id                      INT PRIMARY KEY AUTO_INCREMENT, 
    nome                    VARCHAR(100), 
    cpf_cnpj                VARCHAR(14),
    logradouro              VARCHAR(100), 
    numero                  VARCHAR(100), 
    complemento             VARCHAR(100), 
    bairro                  VARCHAR(100),
    cidade                  VARCHAR(100), 
    estado                  VARCHAR(100), 
    cep                     VARCHAR(8), 
    telefone                VARCHAR(20), 
    email                   VARCHAR(100),
    estado_fornecedor       VARCHAR(10)
);

CREATE TABLE Produto (
    id                      INT PRIMARY KEY AUTO_INCREMENT, 
    nome                    VARCHAR(100), 
    quantidade_estoque      INT NOT NULL, 
    preco                   INT NOT NULL,  
    id_fornecedor           INT,
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id)
);

CREATE TABLE ItemVenda (
    id_venda                INT, 
    numero_item_venda       INT NOT NULL, 
    id_produto              INT NOT NULL, 
    quantidade              INT NOT NULL, 
    valor_unitario          INT NOT NULL, 
    total_item              INT NOT NULL,
    estado_item             VARCHAR(10),
    PRIMARY KEY (id_venda, numero_item_venda),
    FOREIGN KEY (id_venda) REFERENCES Venda(id),
    FOREIGN KEY (id_produto) REFERENCES Produto(id)
);

CREATE TABLE Compra (
    id                  INT PRIMARY KEY AUTO_INCREMENT, 
    data_compra         VARCHAR(15), 
    total_compra        INT, 
    estado_compra       VARCHAR(10),
    id_fornecedor       INT,
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id)
);

CREATE TABLE ItemCompra (
    id_compra               INT, 
    numero_item_compra      INT NOT NULL, 
    id_produto              INT NOT NULL, 
    quantidade              INT NOT NULL, 
    valor_unitario          INT NOT NULL, 
    total_item              INT NOT NULL,
    estado_item             VARCHAR(10),
    PRIMARY KEY (id_compra, numero_item_compra),
    FOREIGN KEY (id_compra) REFERENCES Compra(id),
    FOREIGN KEY (id_produto) REFERENCES Produto(id)
);

CREATE TABLE ContaPagar (
    id                      INT PRIMARY KEY AUTO_INCREMENT, 
    id_fornecedor           INT, 
    total_conta             INT, 
    data_lancamento         VARCHAR(15), 
    data_vencimento         VARCHAR(15),
    data_pagamento          VARCHAR(15), 
    estado_conta            VARCHAR(20),
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id)
);

CREATE TABLE FormaPagamentoCompra (
    id_forma_pagamento      INT AUTO_INCREMENT,
    id_compra               INT,
    valor                   INT,
    PRIMARY KEY (id_forma_pagamento, id_compra),
    FOREIGN KEY (id_forma_pagamento) REFERENCES FormaPagamento(id),
    FOREIGN KEY (id_compra) REFERENCES Compra(id)
);

DELIMITER /
    CREATE TRIGGER InserirContaReceber 
    AFTER INSERT ON Venda
    FOR EACH ROW
    BEGIN
        INSERT INTO ContaReceber (id_cliente, total_conta, data_lancamento, data_vencimento, estado_conta)
        VALUES (New.id_cliente, New.total_venda,current_date(), DATE_ADD(current_date(), INTERVAL 30 DAY), "ABERTA");
    END /
DELIMITER ;

DELIMITER /
    CREATE TRIGGER InserirContaPagar 
    AFTER INSERT ON Compra
    FOR EACH ROW
    BEGIN
        INSERT INTO ContaPagar (id_fornecedor, total_conta, data_lancamento, data_vencimento, estado_conta)
        VALUES (New.id_fornecedor, New.total_compra,current_date(), DATE_ADD(current_date(), INTERVAL 30 DAY), "ABERTA");
    END /
DELIMITER ;

DELIMITER /
    CREATE PROCEDURE BaixarContaReceber(IN remover INT)
    BEGIN
        DECLARE vencimento VARCHAR(15) DEFAULT 0;

        SELECT data_vencimento
        INTO vencimento
        FROM ContaReceber
        WHERE id = remover;
        
        IF (current_date() > vencimento) THEN
            UPDATE ContaReceber 
            SET estado_conta = "PAGA-ATRASADO",
            data_recebimento = current_date()
            WHERE id = remover;
        ELSE
            UPDATE ContaReceber  
            SET estado_conta = "PAGA",
            data_recebimento = current_date()
            WHERE id = remover;
        END IF;
    END /
DELIMITER ;

DELIMITER /
    CREATE PROCEDURE BaixarContaPagar(IN remover INT)
    BEGIN
        DECLARE vencimento VARCHAR(15) DEFAULT 0;

        SELECT data_vencimento
        INTO vencimento
        FROM ContaReceber
        WHERE id = remover;

        IF(current_date() > data_vencimento) THEN
            UPDATE ContaPagar 
            SET estado_conta = "PAGA-ATRASADO",
            data_pagamento = current_date()
            WHERE id = remover;
        ELSE
            UPDATE ContaPagar 
            SET estado_conta = "PAGA",
            data_pagamento = current_date()
            WHERE id = remover;
        END IF;
    END /
DELIMITER ;

DELIMITER /
    CREATE PROCEDURE ExcluirCliente(IN remover INT)
    BEGIN
        UPDATE Cliente 
        SET estado_cliente = "EXCLUIDO"
        WHERE id = remover;
    END /
DELIMITER ;

DELIMITER /
    CREATE PROCEDURE ExcluirFornecedor(IN remover INT)
    BEGIN
        UPDATE Fornecedor 
        SET estado_fornecedor = "EXCLUIDO"
        WHERE id = remover;
    END /
DELIMITER ;

DELIMITER /
    CREATE PROCEDURE ExcluirVenda(IN remover INT)
    BEGIN
        UPDATE Venda 
        SET estado_venda = "EXCLUIDO"
        WHERE id = remover;
    END /
DELIMITER ;