
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistema_lanchonete/main.dart';
import 'package:sistema_lanchonete/views/balanco.dart';
import 'package:sistema_lanchonete/views/cardapio.dart';
import 'package:sistema_lanchonete/views/conf_mesas.dart';
import 'package:sistema_lanchonete/views/cozinha.dart';
import 'package:sistema_lanchonete/views/mesas.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  TabController _tabController; 

  List _listaTelas = [
    Cozinha(),
    Mesas()
  ];

  _tabButtom(Icon icon, tipo){
    return SizedBox(
      width:  MediaQuery.of(context).size.width / 5.6,
      child: RaisedButton(
        elevation: 0,
        child: icon,
        color: red,
        onPressed: (){
          setState(() {
            if(tipo == 'cozinha'){
              _tabController.index = 0;
            }else{
              _tabController.index = 1;
            }
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }

  @override
  void initState() {
    _tabController = TabController(
      length: _listaTelas.length,
      vsync: this
    );
    super.initState();
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_tabController.index);
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        backgroundColor: red,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.circular(18),
        //     bottomRight: Radius.circular(18))
        // ),
        title: Text('Lunc!',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5),
            child:  _tabButtom(
              Icon(
                Icons.fastfood,
                color: white,
              ),
              'cozinha'
              ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: _tabButtom(
              Icon(
                Icons.assignment,
                color: white,
              ), 
              'garcom'
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child:  Column(
                children: <Widget>[
                  Icon(Icons.fastfood,
                    color: white,
                    size: 60,
                  ),
                  Text('Lunc!',
                    style: TextStyle(
                      color: white,
                      fontSize: 18
                    ),
                  ),
                ],
              ), 
              decoration: BoxDecoration(
                color: red
              ),
            ),
            ListTile(
              title: Text('Mesas'),
              subtitle: Text('Editar as mesas'),
              onTap: () => Get.to(ConfMesas()),
            ),
            ListTile(
              title: Text('Cardapio'),
              subtitle: Text('Editar o cardapio'),
              onTap: () => Get.to(Cardapio())
            ),
            ListTile(
              title: Text('Balanço'),
              subtitle: Text('Ver como esta o balanço'),
              onTap: () => Get.to(Balanco()),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _listaTelas[0],
          _listaTelas[1]
        ]
      ),
    );
  }
}