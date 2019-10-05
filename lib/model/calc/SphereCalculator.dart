import 'dart:math' as math;

import 'package:geometry_calc/model/calc/ICalculator.dart';
import 'package:geometry_calc/ui/widget/InputWidget.dart';

class SphereCalculator extends ICalculator {
  double _radius = 0;

  @override
  SphereCalculator build(Function ic) {
    super.build(ic);

    super.ct = {
      'Объём': _calculateVolume,
      'Полная поверхность': _calculateArea,
    };

    initInputs();

    return this;
  }

  @override
  void clear() {
    _radius = 0;

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
    ];
  }

  double _calculateArea() {
    return 4 * math.pi * _radius * _radius;
  }

  double _calculateVolume() {
    return 4 / 3 * math.pi * _radius * _radius * _radius;
  }
}
