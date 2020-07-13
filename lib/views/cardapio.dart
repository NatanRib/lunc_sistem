import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistema_lanchonete/controllers/cardapio_controller.dart';
import 'package:sistema_lanchonete/main.dart';
import 'package:sistema_lanchonete/models/item_cardapio_model.dart';
import 'package:sistema_lanchonete/views/custom_widgets.dart';
import 'cardapio_tab.dart';

class Cardapio extends StatefulWidget {

  final cc = Get.put(CardapioController());
  final cw = Get.put(CustomWidgets());

  @override
  _CardapioState createState() => _CardapioState();
}

class _CardapioState extends State<Cardapio> with SingleTickerProviderStateMixin {

  _novaComida(){
    widget.cc.nome.text = '';
    widget.cc.ingVol.text = '';
    widget.cc.preco.text = '';

    return SingleChildScrollView(
      child: AlertDialog(
        title: Text('Novo item do cardapio'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: widget.cc.nome,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Nome'
              ),
            ),
            TextField(
              controller: widget.cc.ingVol,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Ingredientes ou Volume'
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: widget.cc.preco,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Preço'
                ),
              ),
            ),
          GetBuilder<CardapioController>(
            builder: (_){
              return  GestureDetector(
                onTap: () => widget.cc.setStatusDrop(),
                child: SizedBox(
                  width: Get.width / 1.8,
                  height: 30,
                  child: Material(
                    borderRadius: _.statusDrop ? BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)) 
                    : BorderRadius.circular(12),
                    color: red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text( _.tipo == null ? 'Tipo' : _.tipo,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: white
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(left: 5.0),
                          child: Icon(Icons.arrow_drop_down_circle,
                            color: white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          GetBuilder<CardapioController>(
            builder: (_){
              return _.statusDrop ? Material(
                color: red,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
                child: SizedBox(
                  width: Get.width/ 1.8,
                  height: 95,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: GestureDetector(
                          onTap: (){ 
                            widget.cc.sTipo = 'comidas';
                            widget.cc.setStatusDrop();
                          },
                          child: Material(
                            color: red,
                            child: Text('Comida',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: white
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            widget.cc.sTipo = 'outras comidas';
                            widget.cc.setStatusDrop();
                          },
                          child: Material(
                            color: red,
                            child: Text('O. Comida',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: white
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            widget.cc.sTipo = 'bebidas';
                            widget.cc.setStatusDrop();
                          },
                          child: Material(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12)),
                            color: red,
                            child: Text('Bebidas',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ) : Container();
            },
          )
          ],
        ),
        actions: <Widget>[
          RaisedButton(
            onPressed: (){
              Get.back();
            },
            child: Text('Cancelar'),
            color: red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18)
            ),
          ),
           RaisedButton(
            onPressed: (){
              widget.cc.preco.text = widget.cc.preco.text.replaceAll(',', '.');
              var i = ItemCardapio(widget.cc.nome.text, widget.cc.ingVol.text, double.parse(widget.cc.preco.text),0);
              widget.cc.novoItem(i.toMap(widget.cc.tipo));
              //madar pro bd
            },
            child: Text('Salvar'),
            color: green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18)
            ),
          )
        ],
      ),
    );
  }

  List telas = [
    CardapioTab('comidas'),
    CardapioTab('outras comidas'),
    CardapioTab('bebidas')
  ];

  TabController _tabController;

  @override
  void initState() { 
    super.initState();
    _tabController = TabController(length: telas.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Cardapio',
          style: TextStyle(
            color: white
          ),
        ),
        centerTitle: true,
        backgroundColor: brown,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(child: Text('Comidas'),),
            Tab(child: Text('O. Comidas'),),
            Tab(child: Text('Bebidas'),),
          ]
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          telas[0],
          telas[1],
          telas[2]
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.dialog(_novaComida());
        },
        child: Icon(
          Icons.add,
          color: white,  
        ),
        backgroundColor: brown,
      ),
    );
  }
}