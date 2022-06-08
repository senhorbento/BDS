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
    CREATE PROCEDURE ExcluirCompra(IN remover INT)
    BEGIN
        UPDATE Compra 
        SET estado_compra = "EXCLUIDO"
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