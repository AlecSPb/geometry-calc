import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Виджет для ввода данных
class InputWidget extends StatefulWidget {
  final String label;
  final Function(String) inputCallback;

  InputWidget({@required this.label, @required this.inputCallback});

  @override
  State<StatefulWidget> createState() {
    return InputWidgetState(label, inputCallback);
  }
}

class InputWidgetState extends State<InputWidget> {
  TextEditingController _controller;
  Function(String) _inputCallback;
  String _label;

  InputWidgetState(String label, Function(String) inputCallback) {
    _label = label;
    _inputCallback = inputCallback;
  }

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: 0.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Spacer(),
            TextField(
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 32),
              controller: _controller,
              onChanged: (text) => _inputCallback(text),
              keyboardType: TextInputType.number,
              decoration: InputDecoration.collapsed(hintText: null),
            ),
            SizedBox(height: 22),
            Opacity(
              opacity: 0.6,
              child: Text(_label, style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}
