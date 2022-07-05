# Selecionar/criar o banco
```
use primeiroBanco;
```

# Inserir/criar collection de dados
```
//INSERT uma linha
db.usuario.insertOne({"user": "admin", "password": "admin"});

//INSERT varias linhas
db.usuario.insertMany([
  {"user": "admin1", "password": "admin1"}, 
  {"user": "admin2", "password": "admin2"},
  {"user": "admin1", "password": "password"}
]);

//INSERT varias linhas em outra collection
db.pessoa.insertMany([
  {"nome": "Joao", "idade": "10"}, 
  {"nome": "Joao", "idade": "20"},
  {"nome": "Lucas", "idade": "15"}
]);

```

# Mostra todas as collections
```
show collections;
```

# Selecionar dados na collection
```
//SELECT all
db.primeiroBanco.find(); 

//SELECT primeiro item inserido no banco
db.primeiroBanco.findOne(); 

//SELECT all com resultado semelhante a um Json (Bson)
db.primeiroBanco.find().pretty(); 

Exemplo:
//SELECT o primeiro com o user = admin1
db.primeiroBanco.findOne({"user": "admin1"}); 

//SELECT todos com o user = admin1
db.primeiroBanco.find({"user": "admin1"}); 

//SELECT todos com o nome = Joao
db.pessoa.find({"nome": "Joao"}); 
```

# Atualizar dados na collection
```
//Sintaxe
db.primeiroBanco.updateOne({"WHERE"}, {$set:"SET"}); 
db.primeiroBanco.updateMany({"WHERE"}, {$set:"SET"});

//UPDATE somente do primeiro encontrado
db.primeiroBanco.updateOne({"user" : "admin1"}, {$set: {"password": "nova-senha"}}); 

//UPDATE todos que atendem ao "WHERE"
db.primeiroBanco.updateMany({"user" : "admin1"}, {$set: {"password": "nova-senha"}}); 
```

# Atualizar os atributos da collection
```
//Sintaxe
db.primeiroBanco.replaceOne({"WHERE"}, {"Nova estrutura"});

Exemplo:
db.primeiroBanco.replaceOne({"user" : "admin1"}, {"password": "nova-senha"}); 
```

# Deletar dados na collection

```
//Sintaxe
db.primeiroBanco.deleteOne({"WHERE"});
db.primeiroBanco.deleteMany({"WHERE"});

Exemplo:
//DELETE o primeiro com o user = admin1
db.primeiroBanco.deleteOne({"user" : "admin1"}); 

//DELETE todos com o user = admin1
db.primeiroBanco.deleteMany({"user" : "admin1"}); 
```
