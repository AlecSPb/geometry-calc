import 'dart:math' as math;

import 'package:geometry_calc/model/calc/ICalculator.dart';
import 'package:geometry_calc/ui/widget/InputWidget.dart';

class ConeCalculator extends ICalculator {
  int _radius = 0;
  int _height = 0;

  @override
  ConeCalculator build(Function ic) {
    super.build(ic);

    super.ct = {
      'Объём': _calculateVolume,
      'Площадь боковой поверхности': _calculateLateralArea,
      'Площадь основания': _calculateBaseArea,
      'Площадь поверхности': _calculateArea,
    };

    super.i = [
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

  double _calculateVolume() {
    return 1 / 3 * _calculateBaseArea() * _height;
  }

  double _calculateLateralArea() {
    return math.pi *
        _radius *
        math.sqrt(math.pow(_radius, 2) + math.pow(_height, 2));
  }

  double _calculateBaseArea() {
    return math.pi * math.pow(_radius, 2);
  }

  double _calculateArea() {
    return _calculateBaseArea() + _calculateLateralArea();
  }
}
