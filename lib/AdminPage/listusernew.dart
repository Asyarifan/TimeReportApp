import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test1/AdminPage/adduser.dart';
import 'package:test1/AdminPage/model/userModel.dart';

import '../api.dart';

class ListUserScreen extends StatefulWidget {
  @override
  _ListUserScreenState createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {
  var loading = false;
  final list = new List<UserModel>();

  _previewdata() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(BaseUrl.getListUser);
    if (response.contentLength == 2) {
      loading = false;
      //NullPage();
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new UserModel(api['id'], api['nik'], api['name'],
            api['email'], api['role'], api['manager'], api['status']);
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _previewdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new AddUser(),
          )),
        ),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final x = list[i];
                  return Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  x.name,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("NIK :" + x.nik),
                                Text("Status :" + x.status)
                              ],
                            ),
                          ),
                          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                        ],
                      ));
                },
              ));
  }
}
