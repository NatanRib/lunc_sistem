
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistema_lanchonete/controllers/balanco_controller.dart';
import 'package:sistema_lanchonete/controllers/pedido_controller.dart';
import 'package:sistema_lanchonete/main.dart';
import 'package:sistema_lanchonete/views/custom_widgets.dart';

class Balanco extends StatelessWidget {

  final bc = Get.put(BalancoController());
  final cw = Get.put(CustomWidgets());

  @override
  Widget build(BuildContext context) {
    print('itens no balanço: ${bc.balanco.length}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Balanço'),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.delete_sweep),
            onPressed: () => Get.dialog(cw.dialogConfirmacao('Deseja mesmo limpar o balanço',
              ()=> bc.limparBalanco())
            )
          )
        ],
      ),
      body: GetBuilder<BalancoController>(
        builder: (_){
          return Column(
            children: [
              SizedBox(
                height: Get.height - 130,
                width: Get.width,
                child: ListView.builder(
                  itemCount: _.balanco.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.only(bottom : 3),
                      child: Material(
                        color: white,
                        child: ListTile(  
                          title: Text('Item: ${_.balanco[index].pedido}\nValor: ${_.balanco[index].preco}'),
                          subtitle: Text('${_.balanco[index].mesa}  ${_.balanco[index].status}'),
                          trailing: IconButton(
                            color: red,
                            onPressed: () => Get.dialog(cw.dialogConfirmacao('Deseja excluir esse item do registros',
                            () => bc.removeItemBalanco(_.balanco[index]))),
                            icon: Icon(Icons.delete_forever,
                              color: red,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ),
              SizedBox(
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Numero total de itens: ${_.balanco.length}'),
                    Text('valor total: R\$ ${
                      _.valorTotal.toString().length >= 6? _.valorTotal.toString().substring(0,5) :
                       _.valorTotal.toString().length <= 5 ? _.valorTotal.toString() :
                        _.valorTotal.toString()
                      }')
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}