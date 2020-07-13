import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistema_lanchonete/controllers/mesa_controller.dart';
import 'package:sistema_lanchonete/controllers/pedido_controller.dart';
import 'package:sistema_lanchonete/views/mesa_detalhes.dart';

class Mesas extends StatelessWidget {

  final mc = Get.put(MesasController());
  final pc = Get.put(PedidoController());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mc.mesas.length,
      itemBuilder: (context, index){
        return  Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 30, right: 30),
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            ),
            child: ListTile(
              title: Text(mc.mesas[index].nome,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              subtitle: Text('Aperte e segure para acessar os pedidos.',
              textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.underline
                ),
              ),
              onLongPress: (){
                Get.to(MesaDetalhes(mc.mesas[index].nome));
              },
            ),
          ),
        );
      },
    );
  }
}