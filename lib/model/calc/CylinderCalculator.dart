import 'dart:math' as math;

import 'package:geometry_calc/model/calc/ICalculator.dart';
import 'package:geometry_calc/ui/widget/InputWidget.dart';

class CylinderCalculator extends ICalculator {
  int _radius = 0;
  int _height = 0;

  @override
  CylinderCalculator build(Function ic) {
    super.build(ic);

    super.ct = {
      'Объём': _calculateVolume,
      'Боковая поверхность': _calculateLateralArea,
      'Полная поверхность': _calculateArea,
    };

    super.inputs = [
      InputWidget(
        label: "Радиус",
        text: _radius.toString(),
        inputCallback: (text) {
          _radius = int.parse(text);
          inputsChanged();
        },
      ),
      InputWidget(
        label: "Высота",
        text: _height.toString(),
        inputCallback: (text) {
          _height = int.parse(text);
          inputsChanged();
        },
      ),
    ];

    return this;
  }

  double _calculateArea() {
    return 2 * math.pi * _radius * (_height + _radius);
  }

  double _calculateLateralArea() {
    return 2 * math.pi * _radius * _height;
  }

  double _calculateVolume() {
    return math.pi * _radius * _radius * _height;
  }
}
