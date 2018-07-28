import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
          );
        }
      }
      
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> { 
  int _total = 0;
  var _now = new DateFormat.yMMMd().format(new DateTime.now());

  void _incrementTotal() {
    setState(() {
      _total++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Expenses Tracker"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              _now,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w300
              ),
            ),
            new Text(
              "\$$_total",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w300
              ),),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementTotal,
        child: new Icon(Icons.add),
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }
}