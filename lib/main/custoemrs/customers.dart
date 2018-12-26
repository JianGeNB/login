import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import './details.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../commom/bottomSheet.dart';
import './addcustomer.dart';
import '../../commom/alert.dart';

class Customer {
  String _id;
  String name;
  // String tel;
  // String fee;
  // String address;
  // String car;
  // Customer(this._id,this.name,this.tel,this.fee,this.address,this.car);
  Customer(this._id, this.name);
  Customer.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        name = json['name'];
}

class Customers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomersState();
  }
}

class CustomersState extends State<Customers> {
  List customersList = [];
  RefreshController freshC = new RefreshController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCustomers();
  }

  _getCustomers() async {
    Dio dio = new Dio();
    Response res;
    var result;
    try {
      res = await dio.get('http://www.imbuesong.com:6060/customers/all');
      // Map customerMap = json.decode(res.data['data']);
      // print(res.data);
    } catch (e) {} finally {
      setState(() {
        customersList = res.data['data'];
        // List l = ['蔡卓妍','杨幂','林允儿'];
        // l.sort((a,b)=>a.noSuchMethod(b));
        // print(l);
        
        
      
      });
    }
  }

  void _onRefresh(bool up) {
    if (up) {
      //headerIndicator callback
      _getCustomers();

      freshC.sendBack(true, RefreshStatus.completed);
    } else {
      //footerIndicator Callback
    }
  }

  _handleQueryChanged(context, query) {}
  _handleQuerySubmitted(context, query) async {
    Dio dio = new Dio();
    Response res;
    try {
      res = await dio.post('http://www.imbuesong.com:6060/customers/customer',
          data: {'name': '$query'});
    } catch (e) {}
    setState(() {
      customersList = res.data['data'];

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: SearchBar(
        defaultBar: AppBar(
          title: Text('顾客列表'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                final res = await Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Add()));
                if (res == '0') {
                  _getCustomers();
                }
              },
            )
          ],
        ),
        searchHint: '搜索顾客',

        // onQueryChanged: (query) => _handleQueryChanged(context, query),
        onQuerySubmitted: (query) => _handleQuerySubmitted(context, query),
        attrs: SearchBarAttrs(
            searchBarColor: Colors.lightBlue,
            disabledDetailColor: Colors.black, //提示子颜色
            primaryDetailColor: Colors.white, //箭头颜色
            textBoxBackgroundColor: Colors.white, //搜索背景颜色
            // textBoxOutlineColor: Colors.white,//放大镜和x
            // secondaryDetailColor: Colors.white,//放大镜和xs
            statusBarColor: Colors.black,
            textStyle: TextStyle(color: Colors.black)),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        // enablePullUp: true,
        onRefresh: _onRefresh,
        controller: freshC,
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
          padding: EdgeInsets.all(10),
          // itemCount: customersList.length,
          itemBuilder: (context, index) {
            if (index >= customersList.length) {
              return null;
            }
            return InkWell(
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.lightBlue,
                ),
                title: Text(customersList[index]['name']),
                onLongPress: () {
                  final id = customersList[index]['_id'];
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
                                      'http://www.imbuesong.com:6060/customers/deletecuetomer',
                                      data: {'id': id});
                                } catch (e) {}
                                if (res.data['code'] == 0) {
                                  //await alert(context, '删除成功', 60.0, 255, 230, 230, 250,100.0,20.0);

                                  Navigator.pop(context, '0');
                                  _getCustomers();
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Detail(id: customersList[index]['_id'])));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
