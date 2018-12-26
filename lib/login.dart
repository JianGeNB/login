import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './commom/alert.dart';
import './main/index.dart';
class Myapp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyappState();
  }
}

class MyappState extends State<Myapp> {
  TextEditingController usr = TextEditingController();
  TextEditingController psd = TextEditingController();
  var code;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: SingleChildScrollView(
            child: new ConstrainedBox(
                constraints: new BoxConstraints(
                  minHeight: 10.0,
                ),
                child: 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/link.png',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      width: 250.0,
                      
                      child: TextFormField(
                        controller: usr,
                        
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.person_outline),
                            labelText: "用户名", 
                            fillColor: Colors.lightBlue,
                          
                            hintText: '请输入用户名'
                            ),
                        keyboardType: TextInputType.emailAddress,
                        
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      width: 250.0,
                      child: TextFormField(
                        controller: psd,
                        obscureText: true,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(Icons.https),
                            labelText: "密码", 
                            fillColor: Colors.white,
                            hintText: '请输入密码'
                            ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(110.0, 0, 110.0, 0),
                      color: Colors.lightBlue,
                      child: Text(
                        '登陆',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _login,
                    )
                  ],
                ))),
      ),
    );
  }

  void _login() async {
    // print(usr.text + ';' + psd.text);
    // CircularProgressIndicator();
    if (usr.text == '') {
      alert(context, '请输入用户名', 60.0, 255, 230, 230, 250,90.0,20.0);
    } else if (psd.text == '') {
      alert(context, '请输入密码', 60.0, 255, 230, 230, 250,90.0,20.0);
    } else {
      //执行网络请求
      Dio dio = new Dio();
      var res;
      int result;
      try {
        res = await dio.post('http://www.imbuesong.com:6060/admin/login',
            data: {'user': usr.text, 'password': psd.text});
        // print(res.data['code']);
        result = res.data['code'];
      } catch (e) {
        
         result = 2;
      }finally{
        setState(() {
                  code = result;
                });
      }
      if(code==1){
        alert(context, '用户名或密码错误', 60.0, 255, 230, 230, 250,80.0,20.0);
      }else if(code==2){
        alert(context, '请检查网络', 60.0, 255, 230, 230, 250,80.0,20.0);
      }else{
        alert(context, '登陆成功', 60.0, 255, 230, 230, 250,100.0,20.0);
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(
          builder: (context)=>Wel(),
        ),(route) => route == null);
      }
    }
  }
}
