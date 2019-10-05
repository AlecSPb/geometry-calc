import 'dart:math' as math;

import 'package:geometry_calc/model/calc/ICalculator.dart';
import 'package:geometry_calc/ui/widget/InputWidget.dart';

class TorusCalculator extends ICalculator {
  /// Внешний радиус
  double _R = 0;

  /// Внутренний радиус
  double _r = 0;

  @override
  TorusCalculator build(Function ic) {
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
    _R = 0;
    _r = 0;

    initInputs();
  }

  void initInputs() {
    super.i = [
      InputWidget(
        label: "Радиус окружности (r)",
        text: _r.toString(),
        inputCallback: (text) {
          _r = double.parse(text);
          inputsChanged();
        },
      ),
      InputWidget(
        label: "Расстояние от центра до оси (R)",
        text: _R.toString(),
        inputCallback: (text) {
          _R = double.parse(text);
          inputsChanged();
        },
      ),
    ];
  }

  double _calculateArea() {
    return 4 * math.pow(math.pi, 2) * _R * _r;
  }

  double _calculateVolume() {
    return 0.5 * _r * _calculateArea();
  }
}
