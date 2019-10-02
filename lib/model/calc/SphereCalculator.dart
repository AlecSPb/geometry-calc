import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:geometry_calc/model/calc/ICalculator.dart';
import 'package:geometry_calc/ui/widget/InputWidget.dart';

class SphereCalculator extends ICalculator {
  int _radius = 0;

  @override
  SphereCalculator build(Function ic) {
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
    ];
  }

  @override
  double calculateArea() {
    return 4 * math.pi * _radius * _radius;
  }

  @override
  double calculateVolume() {
    return 4 / 3 * math.pi * _radius * _radius * _radius;
  }
}
