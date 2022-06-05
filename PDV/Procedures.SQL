USE pdv;

DELIMITER /
    CREATE PROCEDURE BaixarContaReceber(IN baixar INT)
    BEGIN
        DECLARE vencimento VARCHAR(15) DEFAULT 0;

        SELECT data_vencimento
        INTO vencimento
        FROM ContaReceber
        WHERE id = baixar;
        
        IF (current_date() > vencimento) THEN
            UPDATE ContaReceber 
            SET estado_conta = "PAGA-ATRASADO",
            data_recebimento = current_date()
            WHERE id = baixar;
        ELSE
            UPDATE ContaReceber  
            SET estado_conta = "PAGA",
            data_recebimento = current_date()
            WHERE id = baixar;
        END IF;
    END /
DELIMITER ;

DELIMITER /
    CREATE PROCEDURE BaixarContaPagar(IN baixar INT)
    BEGIN
        DECLARE vencimento VARCHAR(15) DEFAULT 0;

        SELECT data_vencimento
        INTO vencimento
        FROM ContaReceber
        WHERE id = baixar;

        IF(current_date() > data_vencimento) THEN
            UPDATE ContaPagar 
            SET estado_conta = "PAGA-ATRASADO",
            data_pagamento = current_date()
            WHERE id = baixar;
        ELSE
            UPDATE ContaPagar 
            SET estado_conta = "PAGA",
            data_pagamento = current_date()
            WHERE id = baixar;
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

DELIMITER /
    CREATE PROCEDURE ExcluirItemVenda(IN remover INT)
    BEGIN
        UPDATE ItemVenda 
        SET estado_item = "EXCLUIDO"
        WHERE id = remover;
    END /
DELIMITER ;

DELIMITER /
    CREATE PROCEDURE ExcluirItemCompra(IN remover INT)
    BEGIN
        UPDATE ItemCompra 
        SET estado_item = "EXCLUIDO"
        WHERE id = remover;
    END /
DELIMITER ;