DELIMITER /
    CREATE PROCEDURE ExcluirCliente(IN cancelar INT)
    BEGIN
        UPDATE Cliente 
        SET estado_cliente = "CANCELADO"
        WHERE id = cancelar;
    END /
DELIMITER ;

DELIMITER /
    CREATE PROCEDURE ExcluirFornecedor(IN cancelar INT)
    BEGIN
        UPDATE Fornecedor 
        SET estado_fornecedor = "CANCELADO"
        WHERE id = cancelar;
    END /
DELIMITER ;

DELIMITER /
    CREATE PROCEDURE ExcluirVenda(IN cancelar INT)
    BEGIN
        UPDATE Venda 
        SET estado_venda = "CANCELADO"
        WHERE id = cancelar;
    END /
DELIMITER ;

DELIMITER /
    CREATE PROCEDURE ExcluirCompra(IN cancelar INT)
    BEGIN
        UPDATE Compra 
        SET estado_compra = "CANCELADO"
        WHERE id = cancelar;
    END /
DELIMITER ;

DELIMITER /
    CREATE PROCEDURE ExcluirItemVenda(IN cancelar INT)
    BEGIN
        UPDATE ItemVenda 
        SET estado_item = "CANCELADO"
        WHERE id = cancelar;
    END /
DELIMITER ;

DELIMITER /
    CREATE PROCEDURE ExcluirItemCompra(IN cancelar INT)
    BEGIN
        UPDATE ItemCompra 
        SET estado_item = "CANCELADO"
        WHERE id = cancelar;
    END /
DELIMITER ;