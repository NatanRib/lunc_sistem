import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistema_lanchonete/controllers/pedido_controller.dart';
import 'package:sistema_lanchonete/main.dart';
import 'package:sistema_lanchonete/views/custom_widgets.dart';
import 'package:sistema_lanchonete/views/pedido.dart';

class MesaDetalhes extends StatelessWidget {

  final pc = Get.put(PedidoController());
  final cw = Get.put(CustomWidgets());

  String mesa;

  MesaDetalhes(this.mesa);
  List pedidosMesa = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(mesa),
        backgroundColor: brown,
        actions: <Widget>[
          IconButton(
            onPressed: () => Get.dialog(cw.dialogConfirmacao('Baixar o pedido total da $mesa', () => pc.finalizarPedidosMesa(mesa))
            ),
            icon: Icon(Icons.monetization_on,
              color: white,
            ),
            color: brown,
          )
        ],
      ),
      body: GetBuilder<PedidoController>(
        builder: (_){
          return ListView.builder(
            itemCount: _.peds.length,
            itemBuilder: (context, index){
              return _.peds[index].mesa == mesa ? Padding(
                padding: const EdgeInsets.only(bottom : 8.0, left: 2, right: 2),
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: ListTile(
                    title: Text(_.peds[index].pedido),
                    subtitle: Text(_.peds[index].status,
                      style: TextStyle(
                        color: _.peds[index].status == 'preparando' ? Colors.yellow[800] : Colors.green[800] 
                      ),
                    ),
                    leading: IconButton(
                        color: yellow,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(32)
                        // ),
                        icon: Icon(
                          Icons.remove_circle,
                          color: Colors.yellow[800],
                        ),
                        onPressed: () => Get.dialog(cw.dialogConfirmacao(
                          'Remover pedido ${_.peds[index].pedido} ${_.peds[index].mesa} da mesa',
                           () => pc.removePedido(_.peds[index])))
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.attach_money), 
                        onPressed: () =>  Get.dialog(cw.dialogConfirmacao(
                          'Deseja baixar apenas o item ${_.peds[index].pedido} da conta dessa mesa', 
                          () => pc.finalizaPedido(_.peds[index]))
                        )
                      ),
                    ),
                  )
                
              ) : Container();
            }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: red,
        child: Icon(Icons.add,
          color: white,
        ),
        onPressed: (){
          Get.to(Pedido(mesa));
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}