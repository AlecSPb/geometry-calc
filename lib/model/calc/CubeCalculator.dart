import 'dart:math' as math;

import 'package:geometry_calc/model/calc/ICalculator.dart';
import 'package:geometry_calc/ui/widget/InputWidget.dart';

class CubeCalculator extends ICalculator {
  /// Грань куба
  double _s = 0;

  @override
  CubeCalculator build(Function ic) {
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
    _s = 0;

    initInputs();
  }

  void initInputs() {
    super.i = [
      InputWidget(
        label: "Грань",
        text: _s.toString(),
        inputCallback: (text) {
          _s = double.parse(text);
          inputsChanged();
        },
      ),
    ];
  }

  double _calculateArea() {
    return 6 * math.pow(_s, 2);
  }

  double _calculateVolume() {
    return math.pow(_s, 3);
  }
}
