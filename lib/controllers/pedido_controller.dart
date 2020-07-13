import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistema_lanchonete/controllers/mesa_controller.dart';
import 'package:sistema_lanchonete/main.dart';
import 'package:sistema_lanchonete/models/item_pedido_model.dart';
import 'package:sistema_lanchonete/views/custom_widgets.dart';

class PedidoController extends GetController{

  final mesas = Get.put(MesasController());
  final cw = Get.put(CustomWidgets());

  bool comidasStatus = false;
  bool outrasComidasStatus = false;
  bool bebidasStatus = false;

  List<ItemPedidoModel> peds = List();
  List<ItemPedidoModel> pedsMesa = List();

  onInit(){
    recuperaPedidos();
    super.onInit();
  }

  recuperaPedidos(){
    Firestore.instance.collection('pedidos').snapshots().listen((querySnaps){
      peds.clear();
      for (var snaps in querySnaps.documents){
        peds.add(ItemPedidoModel.fromMap(snaps.data));
      }
      print(peds.toString());
      update();
    });
  }

  addPedidoMesa(ItemPedidoModel ped){  
    try{
      pedsMesa.add(ped);
      update();
    }catch(e){
      cw.snackBar('Erro ao adcionar item: ${ped.pedido}', '${e.toString()}', Colors.red, 5);
      update();
    }
    
  }

  limpaPedidosMesa(){
    try{
      pedsMesa.clear();
      update();
    }catch(e){
      cw.snackBar('Erro ao limpar itens', '${e.toString()}', Colors.red, 5);
      update();
    }
  }

  removePedidoMesa(ItemPedidoModel p){
    try{
      pedsMesa.remove(p);
      update();
    }catch(e){
      cw.snackBar('Erro ao remover item: ${p.pedido}', '${e.toString()}', Colors.red, 5);
      update();
    }
  }

  enviarPedido(String mesa)async{
   try{
      for(var p in pedsMesa){
        await Firestore.instance.collection('pedidos').add(p.toMap())
          .then((value) => value.updateData({'id' : value.documentID})).then((_){
            cw.snackBar('Pedidos ${p.pedido} da $mesa enviado', '', Colors.green, 2);
            update();
          });
        }
        limpaPedidosMesa();
        update();
      }catch(e){
        cw.snackBar('Erro ao enviar pedidos da $mesa', '${e.toString()}', Colors.red, 5);
        update();
      }
  }

  pedidoPreparado(ItemPedidoModel p)async{
    try{
      await Firestore.instance.collection('pedidos').document(p.id).updateData({'status' : 'pronto'}).then((_){
        Get.back();
        update();
        cw.snackBar('Status do pedido ${p.pedido} ${p.mesa} atualizado para "pronto"', '', green, 1);
        update();
      });
    }catch(e){
      cw.snackBar('Erro ao atualizar status do pedido ${p.pedido} ${p.mesa}', '${e.toString()}', red, 5);
      update();
    }
  }

  finalizaPedido(ItemPedidoModel p)async{
    try{
      await Firestore.instance.collection('balanco').add(p.toMap()).then((value){
        value.updateData({
            'id' : value.documentID,
            'status' : 'pago'
          }).then((_)async{
          await Firestore.instance.collection('pedidos').document(p.id).delete().then((_){
            Get.back();
            cw.snackBar('Pedido ${p.pedido} ${p.mesa} baixado', 'Enviado para o balanço', green, 3);
            update();
          });
        });
      });
    }catch(e){
      cw.snackBar('Erro ao baixar pedido ${p.pedido} ${p.mesa}', '${e.toString()}', red, 5);
      update();
    }
  }

  finalizarPedidosMesa(String mesa)async{
    List<ItemPedidoModel> pedidosMesa = List();

    for( var p in peds){ 
      if (p.mesa == mesa){
        pedidosMesa.add(p);
      }
    }
    try{
      for(var p in pedidosMesa){
          await Firestore.instance.collection('balanco').add(p.toMap()).then((value){
          value.updateData({
            'id' : value.documentID,
            'status' : 'pago'
          }).then((_)async{
            await Firestore.instance.collection('pedidos').document(p.id).delete();
          });
        });
      }
      Get.back();
      update();
      cw.snackBar('Pedidos da $mesa baixados e enviados para o balanço', '', green, 3);
      update();
    }catch(e){
      cw.snackBar('Erro ao baixar pedidos da $mesa', '${e.toString()}', red, 5);
      update();
    }
  }

  removePedido(ItemPedidoModel p)async{
    try{
      await Firestore.instance.collection('pedidos').document(p.id).delete().then((_){
        Get.back();
        cw.snackBar('Pedido ${p.pedido} ${p.mesa} excluido da fila', '', green, 3);
        update();
      });
    }catch(e){
      cw.snackBar('Erro ao excluir pedido ${p.pedido} ${p.mesa} da fila', '${e.toString()}', red, 5);
      update();
    }
  }

  setComStatus(bool st){
    comidasStatus = st;
    update();
  }

  setOutComStatus(bool st){
    outrasComidasStatus = st;
    update();
  }

  setBebStatus(bool st){
    bebidasStatus = st;
    update();
  }

}