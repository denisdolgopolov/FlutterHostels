import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'arrays.dart' as arrays;


void main() {
  runApp(MaterialApp(
    home: MyWidget(),
  ));
}

class MyWidget extends StatefulWidget {

  @override
  _MyStates createState() => _MyStates();
}

class _MyStates extends State<MyWidget> {
  bool isDreamVisible = false;
  FocusNode dreamFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Выбор общежития'),
      backgroundColor: Colors.purple,
    ),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Введите имя",
              labelText: "Имя",
            ),
            cursorColor: Colors.purple,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              decorationColor: Colors.purple,
            ),
          ),
          
          SizedBox(height: 20),
          Dropdown((value) {
            if(value == arrays.extraHostel)
              _displayDialog(context);
          }, arrays.hostels),

          SizedBox(height: 20),
          Dropdown((value) {
              setState(() {
                if(value == arrays.extraDreams) {
                  isDreamVisible = true;
                  dreamFocusNode.requestFocus();
                } else {
                  isDreamVisible = false;
                }
              });
          }, arrays.dreams),

          SizedBox(height: 20),
          Visibility(
            visible: isDreamVisible,
            child: TextField(
              focusNode: dreamFocusNode,
              decoration: InputDecoration(
                hintText: "На великах кататься",
                labelText: "Желание",
                contentPadding: EdgeInsets.all(0)
              ),
              cursorColor: Colors.purple,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                decorationColor: Colors.purple,
              ),
            ),
          ),

          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: "telegram: @fine_bear",
              labelText: "Как с тобой связаться?",
            ),
            cursorColor: Colors.purple,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              decorationColor: Colors.purple,
            ),
          ),
        ],
      ),
    ),
  );
}

class Dropdown extends StatefulWidget {
  final List list;
  final void Function(String) onChanged;

  Dropdown(this.onChanged, this.list);

  @override
  _DropdownState createState() => _DropdownState(list, onChanged);
}

class _DropdownState extends State<Dropdown> {
  int selectedValue = 1;
  final List list;
  final void Function(String) onChanged;

  _DropdownState(this.list, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: selectedValue,
        items: list.map((e) => DropdownMenuItem(
          child: Text(e,
            style: TextStyle(
                fontSize: 23,
            ),
          ),
          value: list.indexOf(e),
        )).toList(),
        onChanged: (value) {
          setState(() {
            this.selectedValue = value;
            onChanged(list[value]);
          });
        });
  }
}

_displayDialog(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Введите название общежития, добавим в список'),
          content: TextField(
            autofocus: true,
            style: TextStyle(
              fontSize: 18,
            ),
            decoration: InputDecoration(
                hintText: "МГТУ, 11",
                labelText: "Название общежития",
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
    });
}



