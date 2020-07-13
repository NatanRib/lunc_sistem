class MesaModel{

  String nome;
  String id;

  MesaModel(this.id, this.nome);

  MesaModel.fromMap(map){
    nome = map['nome'];
    id = map['id'];
  }

  toMap(){
    Map<String,dynamic> map = {
      'nome' : nome,
      'id' : id
    };
    return map;
  }

}