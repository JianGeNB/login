import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../commom/alert.dart';
class Part {
  String name;
  String brand;
  String cost;
  String address;
  String time;
  Part(this.name, this.brand, this.cost, this.address, this.time);
}

class Detail extends StatefulWidget {
  String id;
  Detail({Key key, @required this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DetailState(id: id);
  }
}

class DetailState extends State<Detail> {
  String id;
  Part customer;
  DetailState({Key key, @required this.id});
  TextEditingController nameTc = TextEditingController();
  TextEditingController brandTc = TextEditingController();
  TextEditingController costTc = TextEditingController();
  TextEditingController addressTc = TextEditingController();
  TextEditingController timeTc = TextEditingController();
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDetail();
  }

  _getDetail() async {
    Dio dio = new Dio();
    Response res;
    try {

      //  print(id);
      res = await dio.post('http://www.imbuesong.com:6060/parts/partId',
          data: {'id': id});
      // print(res.data);
      // print(res.data['data'][0]['name']);
    } catch (e) {}
    setState(() {
      customer = new Part(
          res.data['data'][0]['name'],
          res.data['data'][0]['brand'],
          res.data['data'][0]['cost'],
          res.data['data'][0]['address'],
          res.data['data'][0]['time']);
      
      nameTc.value = TextEditingValue(text: customer.name);
      brandTc.value = TextEditingValue(text: customer.brand);
      costTc.value = TextEditingValue(text: customer.cost);
      addressTc.value = TextEditingValue(text: customer.address);
      timeTc.value = TextEditingValue(text: customer.time);
      
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('购买记录详细信息'),
          actions: <Widget>[
            GestureDetector(
                onTap: ()async{
                  Dio dio =new Dio();
                  Response res;
                  var result;
                  try {
                    res = await dio.post('http://www.imbuesong.com:6060/parts/updatepart',
                    data: {'id':id,'name':nameTc.text,'brand':brandTc.text,'cost':costTc.text,'address':addressTc.text,'time':timeTc.text});
                    result =res.data['code'];
                  } catch (e) {
                    result = 1;
                  }
                  if(result==0){
                    alert(context, '保存成功', 60.0, 255, 230, 230,
                                      250, 100.0, 20.0);
                  }
                },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                    child: Text('保存', style: TextStyle(fontSize: 20)),
                  ),
            ))
          ],
        ),
        body: SingleChildScrollView(
            child: new ConstrainedBox(
          constraints: new BoxConstraints(
            minHeight: 10.0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                  controller: nameTc,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person,color: Colors.lightBlue),
                      labelText: "用户名",
                      fillColor: Colors.lightBlue,
                      hintText: '编辑用户名'),
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                  controller: brandTc,
                  decoration: InputDecoration(
                    icon: Icon(Icons.group_work,color: Colors.green,),
                      labelText: "品牌",
                      fillColor: Colors.lightBlue,
                      hintText: '编辑品牌'),
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                  controller: costTc,
                  decoration: InputDecoration(
                    icon: Icon(Icons.favorite,color: Colors.red),
                      labelText: "费用",
                      fillColor: Colors.lightBlue,
                      hintText: '费用'),
                  keyboardType: TextInputType.number,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                  controller: addressTc,
                  decoration: InputDecoration(
                    icon: Icon(Icons.home,color:Colors.greenAccent,),
                      labelText: "地址",
                      fillColor: Colors.lightBlue,
                      hintText: '编辑地址'),
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                  controller: timeTc,
                  decoration: InputDecoration(
                    icon: Icon(Icons.timer,color: Colors.orange,),
                      labelText: "购买时间",
                      fillColor: Colors.lightBlue,
                      hintText: '编辑时间'),
                  keyboardType: TextInputType.text,
                ),  
              ),
              
            ],
          ),
        )));
  }
}
