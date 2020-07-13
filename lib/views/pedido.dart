import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistema_lanchonete/controllers/cardapio_controller.dart';
import 'package:sistema_lanchonete/controllers/pedido_controller.dart';
import 'package:sistema_lanchonete/main.dart';
import 'package:sistema_lanchonete/models/item_pedido_model.dart';
import 'package:sistema_lanchonete/views/mesa_detalhes.dart';

class Pedido extends StatelessWidget {
  
  String mesa;

  Pedido(this.mesa);

  String status = 'preparando';

  final pc = Get.put(PedidoController());
  final cc = Get.put(CardapioController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), 
          onPressed: () => Get.back()
        ),
        backgroundColor: yellow,
        title: Text('Novo pedido $mesa'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: GetBuilder<PedidoController>(
              builder: (_){
                return Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        pc.setComStatus(!pc.comidasStatus);
                        pc.setBebStatus(false);
                        pc.setOutComStatus(false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Material(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Comidas',
                                style: TextStyle(
                                  fontSize: 25
                                ),    
                              ),
                              pc.comidasStatus ? Icon(Icons.arrow_drop_down,
                                color: Colors.black,
                              ) : Icon(Icons.arrow_drop_up,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                                                    //COMIDAS
                    pc.comidasStatus ? SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: cc.comidas.length,
                          itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: Material(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left : 8.0),
                                    child: Text('${cc.comidas[index].nome}',
                                      style: TextStyle(
                                        fontSize: 16
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.add_circle,
                                          size: 30,
                                          color: green,
                                        ), 
                                        onPressed: () {
                                          pc.addPedidoMesa(
                                            ItemPedidoModel(
                                              mesa, 
                                              cc.comidas[index].nome, 
                                              status, 
                                              cc.comidas[index].preco
                                            )
                                          );
                                          //adcionoa 1 da comida ao pedido
                                        }
                                      ),
                                    ],
                                  )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ) : Container(),
                    GestureDetector(
                      onTap: (){
                        pc.setComStatus(false);
                        pc.setBebStatus(false);
                        pc.setOutComStatus(!pc.outrasComidasStatus);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Material(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Outras comidas',
                                style: TextStyle(
                                  fontSize: 25
                                ),    
                              ),
                              pc.outrasComidasStatus ? Icon(Icons.arrow_drop_down,
                                color: brown,
                              ) : Icon(Icons.arrow_drop_up,
                                color: brown,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                                                          //OUTRAS COMIDAS
                    pc.outrasComidasStatus ? SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: cc.outrasComidas.length,
                          itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: Material(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left : 8.0),
                                      child: Text('${cc.outrasComidas[index].nome}',
                                        style: TextStyle(
                                          fontSize: 16
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.add_circle,
                                            size: 30,
                                            color: green,
                                          ), 
                                          onPressed: (){
                                            pc.addPedidoMesa(
                                              ItemPedidoModel(
                                                mesa, 
                                                cc.outrasComidas[index].nome, 
                                                status,
                                                cc.outrasComidas[index].preco
                                              )
                                            );
                                            //adcionoa 1 da comida ao pedido
                                          }
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ) : Container(),
                    GestureDetector(
                      onTap: (){
                        pc.setComStatus(false);
                        pc.setBebStatus(!pc.bebidasStatus);
                        pc.setOutComStatus(false);
                        
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Material(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Bebidas',
                                style: TextStyle(
                                  fontSize: 25
                                ),    
                              ),
                              pc.bebidasStatus ? Icon(Icons.arrow_drop_down,
                                color: brown,
                              ) : Icon(Icons.arrow_drop_up,
                                color: brown,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                                                                    //BEBIDAS 
                    pc.bebidasStatus ? SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: cc.bebidas.length,
                          itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: Material(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                
                                    Padding(
                                      padding: const EdgeInsets.only(left : 8.0),
                                      child: Text('${cc.bebidas[index].nome}',
                                        style: TextStyle(
                                          fontSize: 16
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.add_circle,
                                            size: 30,
                                            color: green,
                                          ), 
                                          onPressed: (){
                                            pc.addPedidoMesa(
                                              ItemPedidoModel(
                                                  mesa, 
                                                  cc.bebidas[index].nome, 
                                                  status,
                                                  cc.bebidas[index].preco
                                                )
                                              );
                                            //adcionoa 1 da comida ao pedido
                                          }
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ) : Container(),
                                      //RESUMO DO PEDIDO
                    SizedBox(
                      width: MediaQuery.of(context).size.width -10,
                      height: MediaQuery.of(context).size.height / 2,
                      child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('Resumo do pedido:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  height:( MediaQuery.of(context).size.height / 2 - 30),
                                  width: MediaQuery.of(context).size.width - 15,
                                  child: GetBuilder<PedidoController>(
                                    builder: (_){
                                      return ListView.builder(
                                        itemCount: _.pedsMesa.length,
                                        itemBuilder: (context, index){
                                          return ListTile(
                                            title: Text('${_.pedsMesa[index].pedido}'),
                                            subtitle: Text('${_.pedsMesa[index].preco}'),
                                            trailing: IconButton(icon: Icon(Icons.clear,
                                                color: Colors.red,
                                              ),
                                              onPressed: () => pc.removePedidoMesa(_.pedsMesa[index])
                                            ),
                                          );
                                        }
                                      );
                                    }, 
                                  )
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 5.6,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: (){
                              pc.limpaPedidosMesa();
                            },
                            child: Text('Limpar Pedido',
                              style: TextStyle(
                                color: white
                              ),
                            ),
                            color: yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                          RaisedButton(
                            onPressed: (){
                              return showDialog(
                                context: context,
                                builder: (dialogContext){
                                  return AlertDialog(
                                    title: Text('Enviar Pedido?'),
                                    actions: <Widget>[
                                      RaisedButton(
                                        child: Text('Cancelar'),
                                        color: red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12)
                                        ),
                                        onPressed: (){
                                          Navigator.pop(dialogContext);
                                        } 
                                      ),
                                      RaisedButton(
                                        child: Text('Enviar'),
                                        color: green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12)
                                        ),
                                        onPressed: (){
                                          pc.enviarPedido(mesa);
                                          Navigator.pop(dialogContext);
                                        } 
                                      )
                                    ],
                                  );
                                }
                              );
                            },
                            child: Text('Enviar Pedido',
                              style: TextStyle(
                                color: white
                              ),
                            ),
                            color: green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                        ],
                      ),
                    )
              ],
            ) ;
          },      
        )
      ),
    );
  }
}