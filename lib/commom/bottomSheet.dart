import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './alert.dart';
import '../main/custoemrs/customers.dart';
bottomSheet(context,id){
  showModalBottomSheet(
              context: context,
              builder: (BuildContext context){
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    
                    new ListTile(
                      leading: new Icon(Icons.delete,color: Colors.red,),
                      title: new Text("删除"),
                      onTap: () async {
                        Dio dio =new Dio();
                        var str;
                        Response res;
                        try {
                           res =await dio.post('http://www.imbuesong.com:6060/customers/deletecuetomer',data: {'id':id});
                        } catch (e) {

                        }
                        if(res.data['code']==0){
                          //await alert(context, '删除成功', 60.0, 255, 230, 230, 250,100.0,20.0);
                          
                          Navigator.pop(context,'0');
                          
                           
                        }else{
                          alert(context, '删除失败', 60.0, 255, 230, 230, 250,100.0,20.0);
                        }
                      },
                    ),
                    new ListTile(
                      leading: new Icon(Icons.fast_rewind,color: Colors.green,),
                      title: new Text("取消"),
                      onTap: ()  {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              }
          );
}