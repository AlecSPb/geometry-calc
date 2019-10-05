import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Виджет для ввода данных
class InputWidget extends StatefulWidget {
  final String label;
  final String text;
  final Function(String) inputCallback;

  InputWidget({
    @required this.label,
    @required this.text,
    @required this.inputCallback,
  });

  @override
  State<StatefulWidget> createState() {
    return InputWidgetState();
  }
}

class InputWidgetState extends State<InputWidget> {
  TextEditingController _controller;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: widget.text);

    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.selection =
            TextSelection(baseOffset: 0, extentOffset: _controller.text.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.text;

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
              controller: _controller,
              focusNode: _focusNode,
              keyboardType: TextInputType.number,
              onChanged: (text) => widget.inputCallback(text),
              style: TextStyle(fontSize: 32),
              decoration: InputDecoration.collapsed(hintText: null),
              textAlign: TextAlign.end,
            ),
            SizedBox(height: 22),
            Opacity(
              opacity: 0.6,
              child: Text(widget.label, style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}
