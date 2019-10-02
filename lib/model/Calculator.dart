import 'package:flutter/widgets.dart';
import 'package:geometry_calc/model/calc/ICalculator.dart';

class Calculator {
  String icon;
  String title;
  ICalculator calculator;

  Calculator({
    @required this.icon,
    @required this.title,
    @required this.calculator,
  });
}
