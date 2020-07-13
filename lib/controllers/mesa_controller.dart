import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistema_lanchonete/main.dart';
import 'package:sistema_lanchonete/models/mesas_model.dart';
import 'package:sistema_lanchonete/views/custom_widgets.dart';

class MesasController extends GetController{

  final cw = Get.put(CustomWidgets());
  List<MesaModel> mesas = List();
  TextEditingController nomeMesa = TextEditingController();

  onInit(){
    recuperaMesas();
    super.onInit();
  }

  recuperaMesas(){
    
    MesaModel mes;

    Firestore.instance.collection('mesas').snapshots().listen((event) {
      mesas.clear();
      for( var doc in event.documents){
        mes = MesaModel.fromMap(doc.data);
        mesas.add(mes);
      }
      mesas.sort((a,b) => a.nome.compareTo(b.nome));
    });
    update();
  }

  salvaMesa(String nomeMesa)async{
    try{
      await Firestore.instance.collection('mesas').add({
        'nome' : nomeMesa
      }).then((onValue){
        onValue.updateData({  //apos salva e gerar uma ref do docmuneto aleatoria, salva essa ref no id
          'id' : onValue.documentID
        });
      }).then((_) {
        Get.back();
        cw.snackBar('Nova mesa: $nomeMesa', '', green, 3);
        update();
      });
    }catch(e){
      cw.snackBar('${e.toString()}', '', red, 5);
      update();
    }
  }

  editaMesa(MesaModel mes, String novoNome)async{
    try{
      await Firestore.instance.collection('mesas').document(mes.id).updateData({
        'nome' : novoNome
      }).then((_){
        Get.back();
        cw.snackBar('Edição na ${mes.nome} completa', 'Agora é $novoNome', green, 3);
        update();
      });
    }catch(e){
      cw.snackBar('Erro ao editar ${mes.nome}', '${e.toString()}', red, 3);
      update();
    }
    
  }

  apagaMesa(MesaModel mes)async{
    try{
      await Firestore.instance.collection('mesas').document(mes.id).delete().then((_){
        Get.back();
        cw.snackBar('${mes.nome} apagada', '', green, 3);
        update();
      });
    }catch(e){
      cw.snackBar('Erro ao apagar ${mes.nome}', '${e.toString()}', red, 5);
      update();
    }
    
  }

  setNomeMesa(String nome) {
    nomeMesa.text = nome;
    update();
  } 
}