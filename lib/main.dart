import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Expenses Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _items = [];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        backgroundColor: Colors.pinkAccent,
      ),
      body: new ListView.builder(
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int position) {
          //return new ListItem(_items[position]);
          return getRow(position);
        }),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Add Item',
        backgroundColor: Colors.pinkAccent,
        child: new Icon(Icons.add),
        onPressed: () => _openDialogAddItem(),
      ),
    );
  }

  Widget getRow(int position) {
    return new FlatButton(
      child: new ListTile(
        title: new Text(_items[position].text),
        trailing: new Text(_items[position].number.toString()),
      ),
      onPressed: () {
        setState(() {
          _items.removeAt(position);
        });
      },
    );
  }

  Future _openDialogAddItem() async {
    ModelData data = await Navigator.of(context).push(
      new MaterialPageRoute<ModelData>(
        builder: (BuildContext context) {
          return new DialogAddItem();
        },
        fullscreenDialog: true));

    setState(() {
      _items.add(data);
    });
  }
}

class DialogAddItem extends StatefulWidget {
  @override
  _DialogAddItemState createState() => new _DialogAddItemState();
}

class _DialogAddItemState extends State<DialogAddItem> {
  bool _canSave = false;
  ModelData _data = new ModelData.empty();

  void _setCanSave(bool save) {
    if (save != _canSave)
      setState(() => _canSave = save);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return new Scaffold(
      appBar: new AppBar(
          title: const Text('Add New Expenses'),
          backgroundColor: Colors.pinkAccent,
          actions: <Widget> [
            new FlatButton(
                child: new Text('ADD', style: theme.textTheme.body1.copyWith(color: _canSave ? Colors.white : new Color.fromRGBO(255, 255, 255, 0.5))),
                onPressed: _canSave ? () { Navigator.of(context).pop(_data); } : null
            )
          ]
      ),
      body: new Form(
        child: new ListView(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          children: <Widget>[
            new TextField(
              decoration: const InputDecoration(
                labelText: "Tap to enter item",
              ),
              onChanged: (String value) {
                _data.text = value;
                _setCanSave(value.isNotEmpty);
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0,20.0,0.0,0.0),
              child: new TextField(
                decoration: const InputDecoration(
                  labelText: "Tap to enter amount",
                ),
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  _data.number = int.parse(value);
                  _setCanSave(value.isNotEmpty);
                },
              ),
            )     
          ].toList(),
        ),
      ),
    );
  }
}

class ModelData
{
  String text;
  int number;

  ModelData(this.text, this.number);

  ModelData.empty() {
    text = "";
    number = 0;
  }
}