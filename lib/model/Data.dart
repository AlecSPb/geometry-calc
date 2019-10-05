import 'package:geometry_calc/model/Calculator.dart';
import 'package:geometry_calc/model/calc/CubeCalculator.dart';
import 'package:geometry_calc/model/calc/CylinderCalculator.dart';
import 'package:geometry_calc/model/calc/SphereCalculator.dart';
import 'package:geometry_calc/model/calc/TorusCalculator.dart';

class Data {
  static List<Calculator> calculators = [
    Calculator(
      icon: "assets/ic_cone.svg",
      title: "Конус",
      calculator: null,
    ),
    Calculator(
      icon: "assets/ic_cube.svg",
      title: "Куб",
      calculator: CubeCalculator(),
    ),
    Calculator(
      icon: "assets/ic_cylinder.svg",
      title: "Цилиндр",
      calculator: CylinderCalculator(),
    ),
    Calculator(
      icon: "assets/ic_sphere.svg",
      title: "Сфера",
      calculator: SphereCalculator(),
    ),
    Calculator(
      icon: "assets/ic_thorus.svg",
      title: "Тор",
      calculator: TorusCalculator(),
    ),
  ];
}
