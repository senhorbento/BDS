USE pdv;

DELIMITER /
    CREATE PROCEDURE CancelarVenda(IN cancelar INT)
    BEGIN
        UPDATE Venda 
        SET estado_venda = "CANCELADO"
        WHERE id = cancelar;
    END /
DELIMITER ;

DELIMITER /
    CREATE PROCEDURE CancelarCompra(IN cancelar INT)
    BEGIN
        UPDATE Compra 
        SET estado_compra = "CANCELADO"
        WHERE id = cancelar;
    END /
DELIMITER ;

DELIMITER /
    CREATE PROCEDURE CancelarItemVenda(IN cancelar INT)
    BEGIN
        UPDATE ItemVenda 
        SET estado_item = "CANCELADO"
        WHERE id = cancelar;
    END /
DELIMITER ;

DELIMITER /
    CREATE PROCEDURE CancelarItemCompra(IN cancelar INT)
    BEGIN
        UPDATE ItemCompra 
        SET estado_item = "CANCELADO"
        WHERE id = cancelar;
    END /
DELIMITER ; 