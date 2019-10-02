import 'package:flutter/material.dart';

abstract class ICalculator {
  @protected
  Function() inputsChanged;

  ICalculator build(Function() ic) {
    inputsChanged = ic;
    return this;
  }

  List<Widget> getInputs();

  double calculateArea();

  double calculateVolume();
}
