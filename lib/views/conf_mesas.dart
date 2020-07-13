import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistema_lanchonete/controllers/mesa_controller.dart';
import 'package:sistema_lanchonete/main.dart';
import 'package:sistema_lanchonete/models/mesas_model.dart';
import 'package:sistema_lanchonete/views/custom_widgets.dart';

class ConfMesas extends StatelessWidget {

  final mc = Get.put(MesasController());
  final cw = Get.put(CustomWidgets());
 
  _adicionarMesa(){
    return AlertDialog(
      title: Text('Adicionar uma mesa'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: mc.nomeMesa,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Indentificação da mesa'
            ),
          ),
        ],
      ),
      actions: <Widget>[
        cw.botao(Text('Cancelar'), red, () => Get.back()),
        cw.botao(Text('Salvar'), green,
         (){
            if(mc.nomeMesa.text != ''){
              mc.salvaMesa(mc.nomeMesa.text);
            }else{}
         }
        )
      ],
    );
  }

  _editaMesa(MesaModel mes){
    return AlertDialog(
      title: Text('Editar indentificação da mesa'),
      content: TextField(
        keyboardType: TextInputType.text,
        controller: mc.nomeMesa,
      ),
      actions: <Widget>[
        cw.botao(Text('Cancelar'), red, ()=> Get.back()),
        cw.botao(Text('Salvar'), green,
          (){
            if(mc.nomeMesa.text != ''){
              mc.editaMesa(mes, mc.nomeMesa.text);
            }else{}
          }
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuração das mesas'),
        centerTitle: true,
      ),
      body: GetBuilder<MesasController>(
        builder: (_){
          return Material(
            color: Colors.grey[400],
            child: ListView.builder(
              itemCount: _.mesas.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    child: ListTile(
                      title: Text('${_.mesas[index].nome}',
                        style: TextStyle(
                          fontSize: 18
                        ),
                        textAlign: TextAlign.center,
                      ),               
                      leading: IconButton(
                        icon: Icon(Icons.edit,
                          color: yellow,
                        ), 
                        onPressed: (){
                          mc.setNomeMesa(_.mesas[index].nome);
                          Get.dialog(_editaMesa(_.mesas[index]));
                        }
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle,
                          color: red,
                        ), 
                        onPressed: (){
                          Get.dialog(cw.dialogConfirmacao('Voçê quer mesmo apagar ${_.mesas[index].nome}',
                            ()=> mc.apagaMesa(_.mesas[index]))
                          );
                        }
                      ),
                    ),
                  ),
                );
              }
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: brown,
        child: Icon(Icons.add,
          color: white,
        ),
        onPressed: (){
          Get.dialog(_adicionarMesa());
        }
      ),
    );
  }
}