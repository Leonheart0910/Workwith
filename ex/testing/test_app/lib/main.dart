import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MemoApp());
}

class MemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Memo App')),
        body: MemoPage(),
      ),
    );
  }
}

class MemoPage extends StatefulWidget {
  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  late SharedPreferences prefs;
  TextEditingController _controller = TextEditingController();
  String _loadedMemo = '';

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
    _loadMemo();
  }

  void _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _saveMemo() async {
    await prefs.setString('memo', _controller.text);
  }

  void _loadMemo() async {
    setState(() {
      _loadedMemo = prefs.getString('memo') ?? '';
      _controller.text = _loadedMemo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Enter your memo here'),
            maxLines: 5,
          ),
          SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  _saveMemo();
                  _loadMemo();
                },
                child: Text('Save'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: _loadMemo,
                child: Text('Load'),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(_loadedMemo),
        ],
      ),
    );
  }
}
