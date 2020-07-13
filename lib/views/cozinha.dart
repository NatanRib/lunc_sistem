
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistema_lanchonete/controllers/pedido_controller.dart';
import 'package:sistema_lanchonete/main.dart';
import 'package:sistema_lanchonete/views/custom_widgets.dart';

class Cozinha extends StatelessWidget {

  final pc = Get.put(PedidoController());
  final cw = Get.put(CustomWidgets());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PedidoController>(
      builder: (_){
        return ListView.builder(
          itemCount: _.peds.length,
          itemBuilder: (context, index){
            return _.peds[index].status == 'preparando' ? Padding(
              padding: const EdgeInsets.only(bottom : 3),
              child: Material(
                color: white,
                child: ListTile(  
                  title: Text('${_.peds[index].pedido}'),
                  subtitle: Text('${_.peds[index].mesa}\n${_.peds[index].status}'),
                  trailing: Material(
                    color: green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: IconButton(
                      color: green,
                      onPressed: () => Get.dialog(cw.dialogConfirmacao('Este pedido esta mesmo pronto e sera entregue a mesa?',
                        () => pc.pedidoPreparado(_.peds[index]))),
                      icon: Icon(Icons.done,
                        color: white,
                      ),
                    ),
                  ),
                ),
              ),
            ) : Container();
          }
        );
      },
    );
  }
}