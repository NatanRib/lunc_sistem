import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistema_lanchonete/controllers/cardapio_controller.dart';
import '../main.dart';
import 'custom_widgets.dart';

class CardapioTab extends StatelessWidget {

  String tipo;

  CardapioTab(this.tipo);

  final cc = Get.put(CardapioController());
  final cw = Get.put(CustomWidgets());

  _editarItem(item){

    cc.nome.text = item.nome;
    cc.ingVol.text = item.ingVol;
    cc.preco.text = item.preco.toString();

    return SingleChildScrollView(
      child: AlertDialog(
        title: Text('Editar o item: ${item.nome}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: cc.nome,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Nome',
                hintText: 'Digite o nome do item'
              ),
            ),
            TextField(
              controller: cc.ingVol,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Ingredientes ou Volume',
                hintText: 'Ingredientes ou volume caso seja bebida'
              ),
            ),
            TextField(
              controller: cc.preco,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Preço',
                hintText: 'Digite aqui o preço'
              ),
            ),
          ],
        ),
        actions: [
          cw.botao(Text('Cancelar'), Colors.yellow[800], ()=>Get.back()),
          cw.botao(Text('Salvar'), green, (){
            cc.preco.text = cc.preco.text.replaceAll(',', '.');
            item.nome = cc.nome.text;
            item.ingVol = cc.ingVol.text;
            item.preco = double.parse(cc.preco.text);
            cc.editarItem(item);
          })
        ], 
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardapioController>(
      builder: (_){
        return  ListView.builder(
          itemCount: tipo == 'comidas' ? _.comidas.length : tipo == 'outras comidas' ? _.outrasComidas.length : _.bebidas.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
                child: Material(
                  borderRadius: BorderRadius.circular(12),
                  color: white,
                  child:  ListTile(
                    title: Text('${
                        tipo == "comidas" ? _.comidas[index].nome : tipo == "outras comidas" ? _.outrasComidas[index].nome : _.bebidas[index].nome
                      }\nR\$ ${
                        tipo == "comidas" ? _.comidas[index].preco.toString() : tipo == "outras comidas" ? _.outrasComidas[index].preco.toString() :
                          _.bebidas[index].preco.toString()
                      }'),
                    subtitle: Text('${
                      tipo == "comidas" ? _.comidas[index].ingVol : tipo == "outras comidas" ? _.outrasComidas[index].ingVol : 
                        _.bebidas[index].ingVol
                      }'),
                    leading: IconButton(
                      icon: Icon(Icons.edit,
                        color: yellow,
                      ), 
                      onPressed: () => Get.dialog(_editarItem(
                          tipo == 'comidas' ? _.comidas[index] : tipo == 'outras comidas' ? _.outrasComidas[index] :
                            _.bebidas[index]
                        )  
                      )
                    ),
                    trailing:  IconButton(
                      icon: Icon(Icons.remove_circle,
                        color: red,
                      ),
                      onPressed: () => Get.dialog(cw.dialogConfirmacao(
                        'Deseja mesmo excluir esse item ${
                          tipo == "comidas" ? _.comidas[index].nome : tipo == "outras comidas" ? _.outrasComidas[index].nome :
                          _.bebidas[index].nome 
                        }',
                        () => cc.excluirItem(
                          tipo == 'comidas' ? _.comidas[index] : tipo == 'outras comidas' ? _.outrasComidas[index] : _.bebidas[index]
                        ))
                    ),
                  )
              )
            )); 
          }
        );
      },
    );
  }
}