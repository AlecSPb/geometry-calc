import 'package:flutter/material.dart';

/// Виджет для отображения результатов вычислений
class ResultWidget extends StatefulWidget {
  final int result;

  ResultWidget({
    @required this.result,
  });

  @override
  State<StatefulWidget> createState() {
    return ResultWidgetState(r: result);
  }
}

class ResultWidgetState extends State<ResultWidget> {
  int _result;

  ResultWidgetState({@required int r}) {
    _result = r;
  }

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
      _result.toString(),
      textAlign: TextAlign.right,
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
