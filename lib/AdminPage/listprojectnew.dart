import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test1/AdminPage/addlistproject.dart';
import 'package:test1/AdminPage/model/projectModel.dart';
import '../api.dart';

class ListProjectScreen extends StatefulWidget {
  @override
  _ListProjectScreenState createState() => _ListProjectScreenState();
}

class _ListProjectScreenState extends State<ListProjectScreen> {
  var loading = false;
  final list = new List<ProjectModel>();

  _previewdata() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(BaseUrl.getDataProject);
    if (response.contentLength == 2) {
      loading = false;
      //NullPage();
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new ProjectModel(
            api['idproject'], api['kodeproject'], api['namaproject']);
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  delete(String id) async {
    print(id);
    await http.post(BaseUrl.deleteDataProject, body: {
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
            builder: (BuildContext context) => new AddProject(),
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
                                  x.namaproject,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(x.kodeproject)
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                delete(x.idproject);
                              },
                              icon: Icon(Icons.delete)),
                        ],
                      ));
                },
              ));
  }
}
