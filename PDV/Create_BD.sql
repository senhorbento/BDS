CREATE DATABASE pdv;
USE pdv;

CREATE TABLE Cliente (
    id                  INT PRIMARY KEY AUTO_INCREMENT, 
    cep                 VARCHAR(8), 
    endereco            VARCHAR(100), 
    numero              VARCHAR(100), 
    complemento         VARCHAR(100), 
    bairro              VARCHAR(100),
    cidade              VARCHAR(100), 
    estado              VARCHAR(100), 
    email               VARCHAR(100),
    nome                VARCHAR(100) NOT NULL, 
    cpf_cnpj            VARCHAR(14) NOT NULL,
    telefone            VARCHAR(20) NOT NULL, 
    estado_cliente      VARCHAR(10) NOT NULL
);

CREATE TABLE Fornecedor (
    id                      INT PRIMARY KEY AUTO_INCREMENT, 
    cep                     VARCHAR(8), 
    endereco                VARCHAR(100), 
    numero                  VARCHAR(100), 
    complemento             VARCHAR(100), 
    bairro                  VARCHAR(100),
    cidade                  VARCHAR(100), 
    estado                  VARCHAR(100), 
    email                   VARCHAR(100),
    nome                    VARCHAR(100) NOT NULL, 
    cpf_cnpj                VARCHAR(14) NOT NULL,
    telefone                VARCHAR(20) NOT NULL, 
    estado_fornecedor       VARCHAR(10) NOT NULL
);

CREATE TABLE FormaPagamento (
    id          INT PRIMARY KEY AUTO_INCREMENT, 
    nome        VARCHAR(10) NOT NULL
);

CREATE TABLE Venda (
    id                  INT PRIMARY KEY AUTO_INCREMENT, 
    id_cliente          INT NOT NULL,
    total_venda         INT NOT NULL, 
    data_venda          VARCHAR(15) NOT NULL, 
    estado_venda        VARCHAR(10) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id)
);

CREATE TABLE ContaReceber (
    id                      INT PRIMARY KEY AUTO_INCREMENT, 
    id_cliente              INT NOT NULL, 
    total_conta             INT NOT NULL, 
    data_lancamento         VARCHAR(15) NOT NULL, 
    data_vencimento         VARCHAR(15) NOT NULL,
    estado_conta            VARCHAR(20) NOT NULL,
    data_recebimento        VARCHAR(15), 
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id)
);

CREATE TABLE ContaPagar (
    id                      INT PRIMARY KEY AUTO_INCREMENT, 
    id_fornecedor           INT NOT NULL, 
    total_conta             INT NOT NULL, 
    data_lancamento         VARCHAR(15) NOT NULL, 
    data_vencimento         VARCHAR(15) NOT NULL,
    estado_conta            VARCHAR(20) NOT NULL,
    data_pagamento          VARCHAR(15), 
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id)
);

CREATE TABLE Produto (
    id                      INT PRIMARY KEY AUTO_INCREMENT, 
    nome                    VARCHAR(100) NOT NULL, 
    quantidade_estoque      INT NOT NULL, 
    preco                   INT NOT NULL,  
    id_fornecedor           INT NOT NULL,
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id)
);

CREATE TABLE Compra (
    id                  INT PRIMARY KEY AUTO_INCREMENT, 
    id_fornecedor       INT NOT NULL,
    total_compra        INT NOT NULL, 
    data_compra         VARCHAR(15) NOT NULL, 
    estado_compra       VARCHAR(10) NOT NULL,
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id)
);

CREATE TABLE FormaPagamentoVenda (
    id                      INT NOT NULL,
    id_venda                INT NOT NULL,
    id_forma_pagamento      INT NOT NULL,
    valor                   INT NOT NULL,
    PRIMARY KEY (id_forma_pagamento, id_venda),
    FOREIGN KEY (id_forma_pagamento) REFERENCES FormaPagamento(id),
    FOREIGN KEY (id_venda) REFERENCES Venda(id)
);

CREATE TABLE FormaPagamentoCompra (
    id                      INT NOT NULL,
    id_compra               INT NOT NULL,
	id_forma_pagamento      INT NOT NULL,
    valor                   INT NOT NULL,
    PRIMARY KEY (id_forma_pagamento, id_compra),
    FOREIGN KEY (id_forma_pagamento) REFERENCES FormaPagamento(id),
    FOREIGN KEY (id_compra) REFERENCES Compra(id)
);

CREATE TABLE ItemVenda (
    id_venda                INT, 
    numero_item_venda       INT, 
    id_produto              INT NOT NULL, 
    quantidade              INT NOT NULL, 
    valor_unitario          INT NOT NULL, 
    total_item              INT NOT NULL,
    estado_item             VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_venda, numero_item_venda),
    FOREIGN KEY (id_venda) REFERENCES Venda(id),
    FOREIGN KEY (id_produto) REFERENCES Produto(id)
);

CREATE TABLE ItemCompra (
    id_compra               INT, 
    numero_item_compra      INT, 
    id_produto              INT NOT NULL, 
    quantidade              INT NOT NULL, 
    valor_unitario          INT NOT NULL, 
    total_item              INT NOT NULL,
    estado_item             VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_compra, numero_item_compra),
    FOREIGN KEY (id_compra) REFERENCES Compra(id),
    FOREIGN KEY (id_produto) REFERENCES Produto(id)
);


CREATE TABLE Caixa (
    id                      INT PRIMARY KEY AUTO_INCREMENT,
    saldo                   INT NOT NULL,
    id_forma_pagamento      INT NOT NULL,
    FOREIGN KEY (id_forma_pagamento) REFERENCES FormaPagamento(id)
);