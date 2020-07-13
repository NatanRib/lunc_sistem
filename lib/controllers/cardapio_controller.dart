import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sistema_lanchonete/main.dart';
import 'package:sistema_lanchonete/models/item_cardapio_model.dart';
import 'package:sistema_lanchonete/views/custom_widgets.dart';

class CardapioController extends GetController{

  TextEditingController nome = TextEditingController();
  TextEditingController ingVol = TextEditingController();
  TextEditingController preco = TextEditingController();

  final cw = Get.put(CustomWidgets());

  List comidas = List();
  List bebidas = List();
  List outrasComidas = List();

  bool statusDrop = false;
  String tipo;

  onInit(){
    recuperaCardapio();
    super.onInit();
  }

  recuperaCardapio(){
    Firestore.instance.collection('cardapio').snapshots().listen((event) {
      comidas.clear();
      bebidas.clear();
      outrasComidas.clear();
      for (var doc in event.documents){
        if(doc.data['tipo'] == 'comidas'){
          comidas.add(ItemCardapio.fromMap(doc.data));
        } 
        if(doc.data['tipo'] == 'bebidas'){
          bebidas.add(ItemCardapio.fromMap(doc.data));
        } 
        if(doc.data['tipo'] == 'outras comidas'){
          outrasComidas.add(ItemCardapio.fromMap(doc.data));
        }
      }
      update();
    });
    
  }

  novoItem(item)async{
    try{
      await Firestore.instance.collection('cardapio').add(item).then(
        (value) => value.updateData({'id': value.documentID})).then((_){
          Get.back();
          cw.snackBar('Item adcionado ao cardapio', '', green, 3);
          update();
        });
    }catch(e){
      cw.snackBar('Erro ao adcionar item adcionado ao cardapio', '${e.toString()}', red, 5);
      update();
    }
  }

  excluirItem(item)async{
    try{
      await Firestore.instance.collection('cardapio').document(item.id).delete().then((value){
        Get.back();
        cw.snackBar('Item: ${item.nome} deletado', '', green, 3);
        update();
      });
    }catch(e){
      cw.snackBar('Erro ao deletar item: ${item.nome}', '${e.toString()}', red, 5);
      update();
    } 
  }

  editarItem(ItemCardapio item)async{
    try{
      Firestore.instance.collection('cardapio').document(item.id).updateData(item.toMap(item.tipo)).then((value){
        Get.back();
        cw.snackBar('Item: ${item.nome} atualizado', '', green, 3);
        update();
      });
    }catch(e){
      cw.snackBar('Erro ao atualizar item: ${item.nome}', '${e.toString()}', red, 5);
      update();
    }
  }

  setStatusDrop(){
    statusDrop = !statusDrop;
    update();
  }

  set sTipo(String tipo){
    this.tipo = tipo;
    update();
  }
}