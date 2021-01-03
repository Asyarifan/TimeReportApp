import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test1/AdminPage/addlistdetailactivity.dart';
import 'package:test1/AdminPage/model/activityModel.dart';

import '../api.dart';

class ListDetailActivityScreen extends StatefulWidget {
  @override
  _ListDetailActivityScreenState createState() =>
      _ListDetailActivityScreenState();
}

class _ListDetailActivityScreenState extends State<ListDetailActivityScreen> {
  var loading = false;
  final list = new List<ActivityModel>();

  _previewdata() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(BaseUrl.getListActivity);
    if (response.contentLength == 2) {
      loading = false;
      //NullPage();
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new ActivityModel(api['id'], api['activity']);
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  delete(String id) async {
    print(id);
    await http.post(BaseUrl.deleteListActivity, body: {
      "id": id,
    });
    _previewdata();
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
            builder: (BuildContext context) => new AddActivity(),
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
                                  x.activity,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                delete(x.id);
                              },
                              icon: Icon(Icons.delete)),
                        ],
                      ));
                },
              ));
  }
}
