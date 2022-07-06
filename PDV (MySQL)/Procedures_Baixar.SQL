USE pdv;

DELIMITER /
    CREATE PROCEDURE BaixarContaReceber(IN baixar INT)
    BEGIN
        DECLARE vencimento VARCHAR(15) DEFAULT 0;
        DECLARE valor INT DEFAULT 0;

        SELECT data_vencimento, total_conta
        INTO vencimento, valor
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

        UPDATE Caixa
        SET saldo = saldo + valor 
        WHERE id = id_forma_pagamento; 

    END /
DELIMITER ;

DELIMITER /
    CREATE PROCEDURE BaixarContaPagar(IN baixar INT)
    BEGIN
        DECLARE vencimento VARCHAR(15) DEFAULT 0;
        DECLARE valor INT DEFAULT 0;

        SELECT data_vencimento, total_conta
        INTO vencimento, valor
        FROM ContaPagar
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

        UPDATE Caixa
        SET saldo = saldo - valor 
        WHERE id = id_forma_pagamento;

    END /
DELIMITER ;