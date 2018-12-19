import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login> {
  TextEditingController usr = TextEditingController();
    TextEditingController psd = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
            child: new ConstrainedBox(
                constraints: new BoxConstraints(
                  minHeight: 10.0,
                ),
                child: Column(
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
                            labelText: "用户名", 
                            fillColor: Colors.lightBlue),
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
                            labelText: "密码", 
                            fillColor: Colors.white),
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
  void _login(){
    print(usr.text+';'+psd.text);
    //执行网络请求
  }
}
