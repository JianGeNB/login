import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../commom/alert.dart';
class Customer {
  String name;
  String tel;
  String fee;
  String address;
  String car;
  String message;
  Customer(this.name, this.tel, this.fee, this.address, this.car,this.message);
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
  Customer customer;
  DetailState({Key key, @required this.id});
  TextEditingController nameTc = TextEditingController();
  TextEditingController telTc = TextEditingController();
  TextEditingController feeTc = TextEditingController();
  TextEditingController addressTc = TextEditingController();
  TextEditingController carTc = TextEditingController();
  TextEditingController messageTc = TextEditingController();

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

      // print(id);
      res = await dio.post('http://www.imbuesong.com:6060/customers/customerId',
          data: {'id': id});
      // print(res.data);
      // print(res.data['data'][0]['name']);
    } catch (e) {}
    setState(() {
      customer = new Customer(
          res.data['data'][0]['name'],
          res.data['data'][0]['tel'],
          res.data['data'][0]['fee'],
          res.data['data'][0]['address'],
          res.data['data'][0]['car'],
          res.data['data'][0]['message']);
      nameTc.value = TextEditingValue(text: customer.name);
      telTc.value = TextEditingValue(text: customer.tel);
      feeTc.value = TextEditingValue(text: customer.fee);
      addressTc.value = TextEditingValue(text: customer.address);
      carTc.value = TextEditingValue(text: customer.car);
      messageTc.value = TextEditingValue(text: customer.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('个人详细信息'),
          actions: <Widget>[
            GestureDetector(
                onTap: ()async{
                  Dio dio =new Dio();
                  Response res;
                  var result;
                  try {
                    res = await dio.post('http://www.imbuesong.com:6060/customers/updatecustomer',
                    data: {'id':id,'name':nameTc.text,'tel':telTc.text,'fee':feeTc.text,'address':addressTc.text,'car':carTc.text,'message':messageTc.text});
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
                  controller: telTc,
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone,color: Colors.green,),
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
                  controller: carTc,
                  decoration: InputDecoration(
                    icon: Icon(Icons.local_car_wash,color: Colors.black,),
                      labelText: "所用车辆",
                      fillColor: Colors.lightBlue,
                      hintText: '编辑车辆'),
                  keyboardType: TextInputType.text,
                ),  
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                  controller: messageTc,
                  maxLines: 8,
                  decoration: InputDecoration(
                    icon: Icon(Icons.message,color: Colors.orange,),
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
