import 'dart:math' as math;

import 'package:geometry_calc/model/calc/ICalculator.dart';
import 'package:geometry_calc/ui/widget/InputWidget.dart';

class CylinderCalculator extends ICalculator {
  double _radius = 0;
  double _height = 0;

  @override
  CylinderCalculator build(Function ic) {
    super.build(ic);

    super.ct = {
      'Объём': _calculateVolume,
      'Боковая поверхность': _calculateLateralArea,
      'Полная поверхность': _calculateArea,
    };

    initInputs();

    return this;
  }

  @override
  void clear() {
    _radius = 0;
    _height = 0;

    initInputs();
  }

  void initInputs() {
    super.i = [
      InputWidget(
        label: "Радиус",
        text: _radius.toString(),
        inputCallback: (text) {
          _radius = double.parse(text);
          inputsChanged();
        },
      ),
      InputWidget(
        label: "Высота",
        text: _height.toString(),
        inputCallback: (text) {
          _height = double.parse(text);
          inputsChanged();
        },
      ),
    ];
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
