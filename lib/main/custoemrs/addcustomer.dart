import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
class Add extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddState();
  }
}

class AddState extends State<Add> {
  TextEditingController nameTc = TextEditingController();
  TextEditingController telTc = TextEditingController();
  TextEditingController feeTc = TextEditingController();
  TextEditingController addressTc = TextEditingController();
  TextEditingController carTc = TextEditingController();
  TextEditingController messageTc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('添加信息'),
          actions: <Widget>[
            GestureDetector(
                onTap: ()async{
                  Dio dio =new Dio();
                  Response res;
                  var result;
                  try {
                    res = await dio.post('http://www.imbuesong.com:6060/customers/addcustomer',
                    data: {'name':nameTc.text,'tel':telTc.text,'fee':feeTc.text,'address':addressTc.text,'car':carTc.text,'message':messageTc.text});
                    result =res.data['code'];
                  } catch (e) {
                    result = 1;
                  }
                  if(result==0){
                    Navigator.pop(context,'0');
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
                      icon: Icon(Icons.person, color: Colors.lightBlue),
                      labelText: "用户名",
                      fillColor: Colors.lightBlue,
                      hintText: '编辑用户名'),
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                  controller: telTc,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                      labelText: "电话",
                      fillColor: Colors.lightBlue,
                      hintText: '编辑联系方式'),
                  keyboardType: TextInputType.phone,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                  controller: feeTc,
                  decoration: InputDecoration(
                      icon: Icon(Icons.favorite, color: Colors.red),
                      labelText: "费用",
                      fillColor: Colors.lightBlue,
                      hintText: '编辑费用'),
                  keyboardType: TextInputType.number,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                  controller: addressTc,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.home,
                        color: Colors.greenAccent,
                      ),
                      labelText: "地址",
                      fillColor: Colors.lightBlue,
                      hintText: '编辑地址'),
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                  controller: carTc,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.local_car_wash,
                        color: Colors.black,
                      ),
                      labelText: "所用车辆",
                      fillColor: Colors.lightBlue,
                      hintText: '编辑车辆'),
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextFormField(
                  controller: messageTc,
                  maxLines: 8,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.message,
                        color: Colors.orange,
                      ),
                      labelText: "修理记录",
                      fillColor: Colors.lightBlue,
                      hintText: '编辑记录'),
                  keyboardType: TextInputType.text,
                ),
              )
            ],
          ),
        )));
  }
}
