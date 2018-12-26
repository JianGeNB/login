import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import './addpart.dart';
import './details.dart';
import '../../commom/alert.dart';
class Parts extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      // TODO: implement createState
      return PartsState();
    }
}
class PartsState extends State<Parts>{
  List partsList=[];
  RefreshController freshP = new RefreshController();
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _getParts();
    }
    _getParts()async{
      Dio dio = new Dio();
      Response res;
      try {
        res = await dio.get('http://www.imbuesong.com:6060/parts/all');
        
      } catch (e) {
      }
      setState(() {
              partsList = res.data['data'];
            });
    }
    void _onRefresh(bool up) {
    if (up) {
      //headerIndicator callback
      _getParts();

      freshP.sendBack(true, RefreshStatus.completed);
    } else {
      //footerIndicator Callback
    }
  }
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          title:Text('配件购买记录'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: ()async{
                final res=await Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>Add()
                ));
                if(res=='0'){
                  _getParts();
                }
              },
            )
          ],
        ),
        body: SmartRefresher(
          enablePullDown: true,
        // enablePullUp: true,
        onRefresh: _onRefresh,
        controller: freshP,
        headerBuilder: (context, mode) {
          return new ClassicIndicator(
            mode: mode,
            height: 30.0,
            releaseText: '松开手刷新',
            refreshingText: '刷新中',
            completeText: '刷新完成',
            failedText: '刷新失败',
            idleText: '下拉刷新',
          );
        },
        child: ListView.builder(
          itemBuilder: (context,index){
            
            if (index >= partsList.length) {
              return null;
            }
            var time =partsList[index]['time']==null?'':partsList[index]['time'].toString();
            return InkWell(
              child: ListTile(
                leading: Icon(Icons.build,color: Colors.red,),
                title: Text(partsList[index]['name']+'           '+time),
                
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>Detail(id:partsList[index]['_id'])
                  ));
                },
                onLongPress: (){
                  final id = partsList[index]['_id'];
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new ListTile(
                              leading: new Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              title: new Text("删除"),
                              onTap: () async {
                                Dio dio = new Dio();
                                var str;
                                Response res;
                                try {
                                  res = await dio.post(
                                      'http://www.imbuesong.com:6060/parts/deletepart',
                                      data: {'id': id});
                                } catch (e) {}
                                if (res.data['code'] == 0) {
                                  //await alert(context, '删除成功', 60.0, 255, 230, 230, 250,100.0,20.0);

                                  Navigator.pop(context, '0');
                                  _getParts();
                                } else {
                                  alert(context, '删除失败', 60.0, 255, 230, 230,
                                      250, 100.0, 20.0);
                                }
                              },
                            ),
                            new ListTile(
                              leading: new Icon(
                                Icons.fast_rewind,
                                color: Colors.green,
                              ),
                              title: new Text("取消"),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                },
              ),
            );
          },
        )
        ),
      );
    }
}