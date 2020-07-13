import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sistema_lanchonete/models/item_pedido_model.dart';
import 'package:sistema_lanchonete/views/custom_widgets.dart';

import '../main.dart';

class BalancoController extends GetController{

  final cw = Get.put(CustomWidgets());

  List<ItemPedidoModel> balanco = List();
  double valorTotal;

  onInit(){
    super.onInit();
    recuperaBalanco();
  }

  recuperaBalanco(){
    Firestore.instance.collection('balanco').snapshots().listen((querySnaps){
      balanco.clear();
      valorTotal = 0;
      for (var snaps in querySnaps.documents){
        balanco.add(ItemPedidoModel.fromMap(snaps.data));
        valorTotal += snaps.data['preco'];
      }
      update();
    });
  }

  removeItemBalanco(ItemPedidoModel p)async{
    try{
      await Firestore.instance.collection('balanco').document(p.id).delete().then((_){
        Get.back();
        cw.snackBar('item ${p.pedido} ${p.preco} excluido do balanço', '', green, 3);
        update();
      });
    }catch(e){
      cw.snackBar('Erro ao excluir pedido ${p.pedido} ${p.mesa} do balanço', '${e.toString()}', red, 5);
      update();
    }
  }

  limparBalanco()async{
    List<ItemPedidoModel> pedidosMesa = List();
    for( var p in balanco){
      pedidosMesa.add(p);
    }
    try{
      for(var p in pedidosMesa){  
        await Firestore.instance.collection('balanco').document(p.id).delete();
      }
      Get.back();
      update();
      cw.snackBar('Balanço limpo com sucesso', '', green, 3);
      update();
    }catch(e){
      cw.snackBar('Erro ao limpar balanço', '${e.toString()}', red, 5);
      update();
    }
  }
}