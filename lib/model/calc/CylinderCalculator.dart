import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:geometry_calc/model/calc/ICalculator.dart';
import 'package:geometry_calc/ui/widget/InputWidget.dart';

class CylinderCalculator extends ICalculator {
  int _radius = 0;
  int _height = 0;

  @override
  CylinderCalculator build(Function ic) {
    super.build(ic);
    return this;
  }

  @override
  List<Widget> getInputs() {
    return [
      InputWidget(
        label: "Радиус",
        inputCallback: (text) {
          _radius = int.parse(text);
          inputsChanged();
        },
      ),
      InputWidget(
        label: "Высота",
        inputCallback: (text) {
          _height = int.parse(text);
          inputsChanged();
        },
      ),
    ];
  }

  @override
  double calculateArea() {
    return math.pi * _radius * _radius;
  }

  @override
  double calculateVolume() {
    return calculateArea() * _height;
  }
}
