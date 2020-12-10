import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test1/detailactivity.dart';

class ActivityScreen extends StatelessWidget {
  Future<List> getdata() async {
    final response =
        await http.post("http://192.168.100.10/TimeReport/getdataactivity.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () {},
      ),
      body: new FutureBuilder<List>(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new itemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
    // return Container(
    //   child: Center(
    //     child: Text('Menu Add Activity!'),
    //   ),
    // );
  }
}

class itemList extends StatelessWidget {
  List list;
  itemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
            padding: const EdgeInsets.all(10.0),
            child: new GestureDetector(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new DetailActivity(
                        list: list,
                        index: i,
                      ))),
              child: new Card(
                child: new ListTile(
                  title: new Text(list[i]['project']),
                  leading: new Icon(Icons.work),
                  subtitle: new Text(list[i]['activity']),
                ),
              ),
            ));
      },
    );
  }
}
