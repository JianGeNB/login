import 'package:flutter/material.dart';
import './custoemrs/customers.dart';
import './parts/parts.dart';
import 'package:dio/dio.dart';
class Wel extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      // TODO: implement createState
      return WelState();
    }
}
class WelState extends State<Wel> with SingleTickerProviderStateMixin{
  TabController tc;
  Dio dio;
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      tc = TabController(vsync: this,length: 3);
    }
  @override
  Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        body: TabBarView(
          controller: tc,
          children: <Widget>[
            Customers(),
            Parts(),
          ],
        ),
        bottomNavigationBar:Material(
          color: Colors.lightBlue,
          child: TabBar(
            labelStyle: TextStyle(fontSize: 16.0),
            labelColor: Colors.white,
            unselectedLabelColor:Colors.black,
            unselectedLabelStyle:TextStyle(fontSize: 14.0),
            indicatorColor: Colors.white,
            // isScrollable: true,
            controller: tc,
            tabs: <Widget>[
              Tab(text: '顾客',
              icon:Icon(Icons.people),),
              Tab(text: '配件',icon:Icon(Icons.settings)),
              
            ],
          ),
        ) ,
      );
    }
}