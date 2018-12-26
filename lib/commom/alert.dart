import 'package:flutter/material.dart';
alert(context,info,height,a,r,g,b,pL,pT){
  showDialog(
          context: context,
          builder: (context) => AlertDialog(
                contentPadding: EdgeInsets.all(0),
                content: Container(
                  // width: 50.0,
                  height: height,
                  padding: EdgeInsets.fromLTRB(pL, pT, 0, 0),
                  child: Text(info,style: TextStyle(fontFamily:'微软雅黑'),),
                  color: Color.fromARGB(a, r, g, b),
                  
                ),
                
              ));
}