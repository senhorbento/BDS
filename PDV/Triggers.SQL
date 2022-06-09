USE pdv;

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
    CREATE TRIGGER AtualizarEstoqueVenda
    AFTER INSERT ON ItemVenda
    FOR EACH ROW
    BEGIN
        UPDATE Produto 
        SET quantidade_estoque = (quantidade_estoque - New.quantidade)
        WHERE id = New.id_produto;
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
    CREATE TRIGGER AtualizarEstoqueCompra
    AFTER INSERT ON ItemCompra
    FOR EACH ROW
    BEGIN
        UPDATE Produto 
        SET quantidade_estoque = (quantidade_estoque + New.quantidade)
        WHERE id = New.id_produto;
    END /
DELIMITER ;

DELIMITER /
    CREATE TRIGGER AddFormaPagamentoNoCaixa
    AFTER INSERT ON FormaPagamento
    FOR EACH ROW
    BEGIN
        INSERT INTO Caixa (saldo, id_forma_pagamento)
        VALUES (0, New.id);
    END /
DELIMITER ;