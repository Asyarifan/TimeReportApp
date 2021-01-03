import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/ManagerPage/activityEmpModel.dart';
import 'package:test1/api.dart';

class ActivityEmpScreen extends StatefulWidget {
  @override
  _ActivityEmpScreenState createState() => _ActivityEmpScreenState();
}

class _ActivityEmpScreenState extends State<ActivityEmpScreen> {
  String _iduser, _idactivity;
  var loading = false;
  final list = new List<ActivityModel>();

  var id;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
      _iduser = id;
    });
    _previewdata();
  }

  _previewdata() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.post(BaseUrl.getActivityEmp, body: {
      "id": _iduser,
    });
    if (response.contentLength == 2) {
      loading = false;
      //NullPage();
    } else {
      print("Masuk sini b");
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new ActivityModel(
          api['idactivity'],
          api['name'],
          api['project'],
          api['activity'],
          api['date'],
          api['time'],
          api['remark'],
        );
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  approveActivity(String id) async {
    String status = 'APPROVED';
    await http.post(BaseUrl.approvalActivityEmp, body: {
      "id": id,
      "status": status,
    });
    _previewdata();
  }

  rejectActivity(String id) async {
    String status = 'REJECTED';
    await http.post(BaseUrl.approvalActivityEmp, body: {
      "id": id,
      "status": status,
    });
    _previewdata();
  }

  @override
  void initState() {
    super.initState();
    getPref();
    //_previewdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                Text(x.activity),
                                Text(x.date),
                                Text(x.project),
                                Text(x.time),
                                Text(x.remark)
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                approveActivity(x.idactivity);
                              },
                              icon: Icon(Icons.check)),
                          IconButton(
                              onPressed: () {
                                rejectActivity(x.idactivity);
                              },
                              icon: Icon(Icons.block))
                        ],
                      ));
                },
              ));
  }
}

class NullPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Your Profile!'),
      ),
    );
  }
}
