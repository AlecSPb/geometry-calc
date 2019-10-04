import 'package:flutter/material.dart';

/// Интерфейс описания калькулятора
abstract class ICalculator {
  //region data

  /// Список виджетов для ввода данных
  @protected
  List<Widget> i;

  List<Widget> get inputs => i;

  /// Срабатывает при изменении одного из полей ввода
  @protected
  Function() inputsChanged;

  /// Словарь всех методов рассчёта
  @protected
  Map<String, Function> ct;

  Map<String, Function> get calculationsTypes => ct;

  //endregion

  /// Производит настройку ICalculator
  ICalculator build(Function() ic) {
    inputsChanged = ic;
    return this;
  }
}
