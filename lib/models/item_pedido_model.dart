class ItemPedidoModel {
  String pedido;
  String mesa;
  String status;
  double preco;
  String id;

  ItemPedidoModel(this.mesa, this.pedido, this.status, this.preco);

  ItemPedidoModel.fromMap(Map <String, dynamic> map){
    this.pedido = map['pedido'];
    this.mesa = map['mesa'];
    this.status = map['status'];
    this.preco = map['preco'];
    this.id = map['id'];
  }

  toMap(){
    Map<String, dynamic> map = {
      'pedido' : this.pedido,
      'mesa' : this.mesa,
      'status' : this.status,
      'preco' : this.preco
    };
    return map;
  }


}
