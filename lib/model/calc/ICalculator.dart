import 'package:flutter/material.dart';

/// Интерфейс описания калькулятора
abstract class ICalculator {
  //region Данные

  /// Срабатывает при изменении одного из полей ввода
  @protected
  Function() inputsChanged;

  @protected
  List<Widget> inputs;

  /// Словарь всех методов рассчёта
  @protected
  Map<String, Function> ct;

  /// Словарь всех методов рассчёта
  Map<String, Function> get calculationsTypes => ct;

  //endregion

  /// Производит настройку ICalculator
  ICalculator build(Function() ic) {
    inputsChanged = ic;
    return this;
  }

  /// Возвращаем список виджетов ввода для ICalculator
  List<Widget> getInputs() => inputs;
}
