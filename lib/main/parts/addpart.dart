import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:dio/dio.dart';
class Name {}

class Add extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddState();
  }
}

class AddState extends State<Add> {
  TextEditingController nameTc = TextEditingController();
  TextEditingController brandTc = TextEditingController();
  TextEditingController costTc = TextEditingController();
  TextEditingController addressTc = TextEditingController();
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  // final timeFormat = DateFormat("h:mm a");
  DateTime date;
  // TimeOfDay time;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('添加配件购买记录'),
        actions: <Widget>[
            GestureDetector(
                onTap: ()async{
                  Dio dio =new Dio();
                  Response res;
                  var result;
                  try {
                    res = await dio.post('http://www.imbuesong.com:6060/parts/addpart',
                    data: {'name':nameTc.text,'brand':brandTc.text,'time':date==null?'':date.toString(),'cost':costTc.text,'address':addressTc.text});
                    
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
          ]
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
                    labelText: "配件名",
                    fillColor: Colors.lightBlue,
                    hintText: '编辑配件名'),
                keyboardType: TextInputType.text,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextFormField(
                controller: brandTc,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.group_work,
                      color: Colors.green,
                    ),
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
                    icon: Icon(Icons.favorite, color: Colors.red),
                    labelText: "费用",
                    fillColor: Colors.lightBlue,
                    hintText: '编辑费用'),
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: DateTimePickerFormField(
                format: dateFormat,
                decoration: InputDecoration(labelText: '购买时间',
                icon: Icon(Icons.timer,color:Colors.orange),
                hintText: '编辑时间'),
                onChanged: (dt) => setState(() => date = dt),
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
          ],
        ),
      )),
    );
  }
}
