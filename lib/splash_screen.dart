import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistema_lanchonete/controllers/cardapio_controller.dart';
import 'package:sistema_lanchonete/controllers/mesa_controller.dart';
import 'package:sistema_lanchonete/main.dart';
import 'controllers/pedido_controller.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  final cc = Get.put(CardapioController());
  final mc = Get.put(MesasController());
  final pc = Get.put(PedidoController());

  @override
  void initState(){
    cc.onInit();
    mc.onInit();
    pc.onInit();
    Future.delayed(Duration(seconds: 2)).then((_){
      Get.off(Home());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: red
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Icon(Icons.fastfood,
                color: white,
                size: 60,
              ),
            ),
            Text('Lunc!',
              style: TextStyle(
                color: white,
                fontSize: 35,
                fontWeight: FontWeight.bold
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: CircularProgressIndicator(),
            )
          ],
        ) 
      ),
    );
  }
}