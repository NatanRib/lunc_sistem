class ItemCardapio{

  String nome;
  String ingVol;
  double preco;
  int qtde;
  String id;
  String tipo;

  ItemCardapio(this.nome, this.ingVol, this.preco, this.qtde);

  ItemCardapio.fromMap(Map map){
    nome = map['nome'];
    ingVol = map['ingVol'];
    preco = map['preco'];
    qtde = map['qtde'];
    id = map['id'];
    tipo = map['tipo'];
  }

  Map toMap(String tip){
    Map<String, dynamic> map = Map();
    map = {
      'nome' : this.nome,
      'ingVol' : this.ingVol,
      'preco' : this.preco,
      'qtde' : this.qtde,
      'tipo' : tip
    };
    return map;
  }

}