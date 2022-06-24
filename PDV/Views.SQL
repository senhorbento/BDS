USE pdv;

CREATE VIEW viewProdutos as
SELECT id, nome, preco FROM Produto;

CREATE VIEW viewClientes as
SELECT id, nome, cpf_cnpj FROM Cliente;

CREATE VIEW viewFornecedor as
SELECT id, nome, cpf_cnpj FROM Fornecedor;

CREATE VIEW viewVendas as
SELECT c.nome, v.id, v.total_venda, v.data_venda, v.estado_venda
FROM Venda as v JOIN Cliente as c ON v.id_cliente = c.id;

CREATE VIEW viewCompras as
SELECT f.nome, c.id, c.total_compra, c.data_compra, c.estado_compra
FROM Compra as c JOIN Fornecedor as f ON c.id_fornecedor = f.id;

CREATE VIEW viewContaReceber as
SELECT c.id, cr.id, cr.total_conta, cr.data_lancamento, cr.data_vencimento, 
cr.estado_conta, cr.data_recebimento
FROM ContaReceber as cr JOIN Cliente as c ON cr.id_cliente = c.id;

CREATE VIEW viewContaPagar as
SELECT f.id, cp.id, cp.total_conta, cp.data_lancamento, cp.data_vencimento, 
cp.estado_conta, cp.data_pagamento
FROM ContaPagar as cp JOIN Fornecedor as f ON cp.id_fornecedor = f.id;