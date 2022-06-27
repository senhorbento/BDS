USE pdv;

CREATE VIEW viewTodosClientes as
SELECT id, nome, cpf_cnpj FROM Cliente;

CREATE VIEW viewClientesExcluidos as
SELECT id, nome, cpf_cnpj FROM Cliente WHERE estado_cliente = "EXCLUIDO";

CREATE VIEW viewClientesAtivos as
SELECT id, nome, cpf_cnpj FROM Cliente WHERE estado_cliente = "ATIVO";

CREATE VIEW viewTodosFornecedores as
SELECT id, nome, cpf_cnpj FROM Fornecedor;

CREATE VIEW viewFornecedoresExcluidos as
SELECT id, nome, cpf_cnpj FROM Fornecedor WHERE estado_fornecedor = "EXCLUIDO";

CREATE VIEW viewFornecedoresAtivos as
SELECT id, nome, cpf_cnpj FROM Cliente WHERE estado_fornecedor = "ATIVO";

CREATE VIEW viewProdutos as
SELECT id, nome, preco FROM Produto;

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

CREATE VIEW viewContaReceberAberta as
SELECT c.id, cr.id, cr.total_conta, cr.data_lancamento, cr.data_vencimento, 
cr.estado_conta, cr.data_recebimento
FROM ContaReceber as cr JOIN Cliente as c ON cr.id_cliente = c.id
WHERE cr.estado_conta = "ABERTA";

CREATE VIEW viewContaReceberPaga as
SELECT c.id, cr.id, cr.total_conta, cr.data_lancamento, cr.data_vencimento, 
cr.estado_conta, cr.data_recebimento
FROM ContaReceber as cr JOIN Cliente as c ON cr.id_cliente = c.id
WHERE cr.estado_conta = "PAGA";

CREATE VIEW viewContaReceberAtrasada as
SELECT c.id, cr.id, cr.total_conta, cr.data_lancamento, cr.data_vencimento, 
cr.estado_conta, cr.data_recebimento
FROM ContaReceber as cr JOIN Cliente as c ON cr.id_cliente = c.id
WHERE cr.estado_conta = "PAGA-ATRASADO";

CREATE VIEW viewContaPagar as
SELECT f.id, cp.id, cp.total_conta, cp.data_lancamento, cp.data_vencimento, 
cp.estado_conta, cp.data_pagamento
FROM ContaPagar as cp JOIN Fornecedor as f ON cp.id_fornecedor = f.id;

CREATE VIEW viewContaPagarAberta as
SELECT f.id, cp.id, cp.total_conta, cp.data_lancamento, cp.data_vencimento, 
cp.estado_conta, cp.data_pagamento
FROM ContaPagar as cp JOIN Fornecedor as f ON cp.id_fornecedor = f.id
WHERE cp.estado_conta = "ABERTA";

CREATE VIEW viewContaPagarPaga as
SELECT f.id, cp.id, cp.total_conta, cp.data_lancamento, cp.data_vencimento, 
cp.estado_conta, cp.data_pagamento
FROM ContaPagar as cp JOIN Fornecedor as f ON cp.id_fornecedor = f.id
WHERE cp.estado_conta = "PAGA";

CREATE VIEW viewContaPagarAtrasada as
SELECT f.id, cp.id, cp.total_conta, cp.data_lancamento, cp.data_vencimento, 
cp.estado_conta, cp.data_pagamento
FROM ContaPagar as cp JOIN Fornecedor as f ON cp.id_fornecedor = f.id
WHERE cp.estado_conta = "PAGA-ATRASADO";