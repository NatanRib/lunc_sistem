import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class CustomWidgets{

  botao(Widget child,Color cor, Function f ){
    return RaisedButton(
      onPressed: f,
      child: child,
      color: cor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      textColor: Colors.white,
    );
  }

  botaoQuadrado(Widget child,Color cor, Function f ){
    return RaisedButton(
      onPressed: f,
      child: child,
      color: cor,
    );
  }
  
  snackBar(String title, String message, Color cor, int seconds){
    return Get.snackbar(
      title, 
      message,
      backgroundColor: cor,
      barBlur: 0,
      duration: Duration(seconds: seconds),
      colorText: Colors.white
    );
  }

  dialogConfirmacao(String tittle, Function f){
    return AlertDialog(
      title: Text(tittle),
      content: Text('Essa ação não pode ser desfeita!'),
      actions: [
        botao(Text('Cancelar'), Colors.yellow[800], ()=> Get.back()),
        botao(Text('Confirmar'), red, f)
      ],
    );
  }

}