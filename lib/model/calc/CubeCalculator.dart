import 'dart:math' as math;

import 'package:geometry_calc/model/calc/ICalculator.dart';
import 'package:geometry_calc/ui/widget/InputWidget.dart';

class CubeCalculator extends ICalculator {
  int _s = 0;

  @override
  CubeCalculator build(Function ic) {
    super.build(ic);

    super.ct = {
      'Объём': _calculateVolume,
      'Полная поверхность': _calculateArea,
    };

    super.i = [
      InputWidget(
        label: "Грань",
        text: _s.toString(),
        inputCallback: (text) {
          _s = int.parse(text);
          inputsChanged();
        },
      ),
    ];

    return this;
  }

  double _calculateArea() {
    return 6.0 * math.pow(_s, 2);
  }

  double _calculateVolume() {
    return 1.0 * math.pow(_s, 3);
  }
}
