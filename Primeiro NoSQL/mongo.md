# Sumário

01. [Selecionar/criar o banco](#selecionarcriar-o-banco)
00. [Inserir/criar collection/tabela de dados](#inserircriar-collectiontabela-de-dados)
00. [Mostrar bancos criados](#mostrar-bancos-criados)
00. [Mostrar todas as collections do banco](#mostrar-todas-as-collections-do-banco)
00. [Selecionar dados na collection](#selecionar-dados-na-collection)
00. [Atualizar dados de um registro/documento](#atualizar-dados-de-um-registrodocumento)
00. [Atualizar todos os dados de um registro/documento](#atualizar-todos-os-dados-de-um-registrodocumento)
00. [Excluir dados na collection](#excluir-dados-na-collection)

# Selecionar/criar o banco
```
use primeiroBanco;
```

# Inserir/criar collection/tabela de dados
## Sintaxe
```C#
//INSERT um dado na collection
db.NomeDaCollection.insertOne({"user": "admin", "password": "admin"});

//INSERT um varios dados na collection
db.NomeDaCollection.insertMany([
  {"user": "admin", "password": "admin"},
  {"user": "admin", "password": "admin"},
  {"user": "admin", "password": "admin", "idade": "10"}
]);
```
## Exemplo
```C#
//INSERT um dado na collection usuario
db.usuario.insertOne({"user": "admin", "password": "admin"});

//INSERT um dado na collection pessoa
db.usuario.insertOne({"nome": "Bill Gates", "idade": "66 "});

//INSERT vários dados na collection usuario
db.usuario.insertMany([
  {"user": "admin1", "password": "admin1"}, 
  {"user": "admin2", "password": "admin2"},
  {"user": "admin1", "password": "password"}
]);

//INSERT vários dados em outra collection, no caso, collection pessoa
db.pessoa.insertMany([
  {"nome": "Joao", "idade": "10"}, 
  {"nome": "Joao", "idade": "20"},
  {"nome": "Lucas", "idade": "15"}
]);

```

# Mostrar bancos criados
**Só apresenta o banco se tiver algum dado em alguma collection**
## Sintaxe
```C#
show dbs;
```
## Exemplo
```C#
//Exemplo resultado:
admin    0.000GB
config   0.000GB
local    0.000GB
primeiroBanco  0.000GB
```

# Mostrar todas as collections do banco
## Sintaxe
``` C#
show collections;
```
## Exemplo
```C#
//Exemplo de resultado:
pessoa
usuario
```

# Selecionar dados na collection
## Sintaxe
```C#
//Seleciona todos os registros de uma collection igual ao SELECT all
db.NomeDaCollection.find(); 

//SELECT primeiro item inserido na collection
db.NomeDaCollection.findOne(); 

//SELECT todos onde o parametro for verdadeiro
db.NomeDaCollection.find({"WHERE"}); 

//SELECT all com resultado semelhante a um Json (Bson)
db.NomeDaCollection.find().pretty(); 
```
## Exemplo
```C#
//SELECT o primeiro com o user = admin1
db.usuario.findOne({"user": "admin1"}); 

//SELECT todos com o user = admin1
db.usuario.find({"user": "admin1"}); 

//SELECT todos com o nome = Joao
db.usuario.find({"nome": "Joao"}); 
```

# Atualizar dados de um registro/documento
## Sintaxe
```C#
//Atualiza os dados para o(s) que foi(foram) passado(s) no segundo parâmetro e não modifica a estrutura

//Somente no primeiro correspondente ao primeiro parâmetro
db.NomeDaCollection.updateOne({"WHERE"}, {$set:"SET"}); 

//Em todos que correspondem ao primeiro parâmetro
db.NomeDaCollection.updateMany({"WHERE"}, {$set:"SET"});
```
## Exemplo
```C#
//Dados
db.usuario.insertMany([
  {"user": "admin1", "password": "admin1"}, 
  {"user": "admin2", "password": "admin2"},
  {"user": "admin1", "password": "password"}
]);

//UPDATE somente no primeiro encontrado
db.primeiroBanco.updateOne({"user" : "admin1"}, {$set: {"password": "nova-senha"}}); 

//Resultado
db.usuario.insertMany([
  {"user": "admin1", "password": "nova-senha"}, 
  {"user": "admin2", "password": "admin2"},
  {"user": "admin1", "password": "password"}
]);

//UPDATE em todos que atendem ao "WHERE"
db.usuario.updateMany({"user" : "admin1"}, {$set: {"password": "nova-senha"}}); 

//Resultado
db.usuario.insertMany([
  {"user": "admin1", "password": "nova-senha"}, 
  {"user": "admin2", "password": "admin2"},
  {"user": "admin1", "password": "nova-senha"}
]);
```

# Atualizar todos os dados de um registro/documento
## Sintaxe
```C#
//Atualiza TODOS os dados para o(s) que foi(foram) passado(s) no segundo parâmetro e modifica a estrutura, semelhante ao ALTER TABLE

//Somente no primeiro correspondente ao primeiro parâmetro
db.NomeDaCollection.replaceOne({"WHERE"}, {"Nova estrutura"});
```
``` replaceMany ``` **Não existe**
## Exemplo
```C#
//Dados
{ "_id" : ObjectId("62c4d5e11a23db9b29b9fca1"), "user" : "admin1", "password" : "admin1" }
{ "_id" : ObjectId("62c4d5e11a23db9b29b9fca2"), "user" : "admin2", "password" : "admin2" }
{ "_id" : ObjectId("62c4d5e11a23db9b29b9fca3"), "user" : "admin1", "password" : "password" }

/*Altera todos os dados do primeiro que corresponde a user = admin1
  para "password": "nova-senha"*/
db.usuario.replaceOne({"user" : "admin1"}, {"password": "nova-senha"}); 

//Resultado
{ "_id" : ObjectId("62c4d5e11a23db9b29b9fca1"), "password" : "nova-senha" }
{ "_id" : ObjectId("62c4d5e11a23db9b29b9fca2"), "user" : "admin2", "password" : "admin2" }
{ "_id" : ObjectId("62c4d5e11a23db9b29b9fca3"), "user" : "admin1", "password" : "password" }
```

# Excluir dados na collection
## Sintaxe
```C#
//Exclui somente o primeiro que corresponde a cláusula
db.NomeDaCollection.deleteOne({"WHERE"});

//Exclui todos os que correspondem a cláusula
db.NomeDaCollection.deleteMany({"WHERE"});

//Exclui todos os dados da collection
db.NomeDaCollection.deleteMany({});
```
## Exemplo
```C#
//Dados
{ "_id" : ObjectId("62c4d3121a23db9b29b9fc9e"), "nome" : "Joao", "idade" : "10" }
{ "_id" : ObjectId("62c4d3121a23db9b29b9fc9f"), "nome" : "Joao", "idade" : "20" }
{ "_id" : ObjectId("62c4d3121a23db9b29b9fca0"), "nome" : "Lucas", "idade" : "15" }

//DELETE o dado primeiro com o nome = Joao
db.usuario.deleteOne({"nome" : "Joao"}); 

//Resultado
{ "_id" : ObjectId("62c4d3121a23db9b29b9fc9f"), "nome" : "Joao", "idade" : "20" }
{ "_id" : ObjectId("62c4d3121a23db9b29b9fca0"), "nome" : "Lucas", "idade" : "15" }

//DELETE todos os dados com o nome = Joao
db.usuario.deleteMany({"nome" : "Joao"}); 

//Resultado
{ "_id" : ObjectId("62c4d3121a23db9b29b9fca0"), "nome" : "Lucas", "idade" : "15" }
```
