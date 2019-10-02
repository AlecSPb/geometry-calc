import 'package:flutter/material.dart';

/// Виджет для отображения результатов вычислений
class ResultWidget extends StatefulWidget {
  final double result;

  ResultWidget({
    @required this.result,
  });

  @override
  State<StatefulWidget> createState() {
    return ResultWidgetState();
  }
}

class ResultWidgetState extends State<ResultWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildIndicator(),
              Expanded(child: buildResult())
            ],
          ),
        ),
      ],
    );
  }

  Widget buildIndicator() {
    return Opacity(
      child: Text("=", style: TextStyle(fontSize: 24)),
      opacity: 0.5,
    );
  }

  Widget buildResult() {
    return Text(
      formatResult(),
      textAlign: TextAlign.right,
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  String formatResult() {
    var r = widget.result;

    return r.toStringAsFixed(r.truncateToDouble() == r ? 0 : 2);
  }
}
