import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geometry_calc/model/Calculator.dart';
import 'package:geometry_calc/model/Data.dart';
import 'package:geometry_calc/model/calc/ICalculator.dart';
import 'package:geometry_calc/ui/widget/ResultWidget.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class CalculatorScreen extends StatefulWidget {
  final Calculator calculator;

  CalculatorScreen({@required this.calculator});

  @override
  State<StatefulWidget> createState() {
    return CalculatorScreenState();
  }
}

class CalculatorScreenState extends State<CalculatorScreen> {
  //region data

  /// Ключ для управления Scaffold извне метода build
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  /// Обёртка калькулятора. Хранит иконку, название и сам калькулятор
  Calculator _c;

  /// Калькулятор. Отдаёт виджеты взаимодействия и методы рассчёта
  ICalculator _calculator;

  /// Имя вычисляемой характеристики (т.е. объём, площадь поверхности...)
  String _calculationTypeName;

  Function _calculationFunction;

  /// Результат расчёта
  double _result = 0;

  //endregion

  @override
  void initState() {
    super.initState();
    setupCalculator(widget.calculator);
  }

  @override
  Widget build(BuildContext context) {
    var navigationSidebar = Drawer(
      child: ListView.builder(
        itemCount: Data.calculators.length,
        itemBuilder: (_, index) => buildNavigationTile(Data.calculators[index]),
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(),
      endDrawer: navigationSidebar,
      body: SafeArea(
        child: _c.calculator == null
            ? buildUnimplementedBlank()
            : buildCalculatorUi(),
      ),
    );
  }

  //region logic

  void setupCalculator(Calculator calculator) {
    _c = calculator;

    if (_c.calculator == null) return;

    _calculator = _c.calculator.build(inputChangedCallback);

    _calculationTypeName = _calculator.calculationsTypes.keys.toList()[0];
    _calculationFunction = _calculator.calculationsTypes[_calculationTypeName];

    _result = _calculationFunction();
  }

  void changeCalculationType(String name, Function function) {
    setState(() {
      _calculationTypeName = name;
      _calculationFunction = function;

      _result = _calculationFunction();

      Navigator.pop(context); // Закрыть диалог
    });
  }

  void inputChangedCallback() =>
      setState(() => _result = _calculationFunction());

  //endregion

  //region ui

  Widget buildAppBar() {
    return AppBar(
      title: buildAppBarTitle(),
      centerTitle: true,
      leading: buildAppBarHomeButton(),
      actions: buildAppBarActions(),
      backgroundColor: Colors.transparent,
    );
  }

  Widget buildAppBarTitle() {
    var subtitle = _c.calculator != null
        ? [
      SizedBox(height: 4, width: double.infinity),
      Opacity(
        child: Text(_calculationTypeName, style: TextStyle(fontSize: 12)),
        opacity: 0.5,
      )
    ]
        : <Widget>[];

    var title = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[Text(_c.title)] + subtitle,
    );

    var tapAction = _c.calculator != null ? showCalculationTypeDialog : null;

    return InkWell(
      child: title,
      onTap: tapAction,
    );
  }

  Widget buildAppBarHomeButton() {
    return IconButton(
      icon: Icon(OMIcons.home),
      onPressed: () => Navigator.pop(context),
    );
  }

  List<Widget> buildAppBarActions() {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: _c.calculator == null ? null : () => {},
      ),
      IconButton(
        icon: Icon(Icons.menu),
        onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
      )
    ];
  }

  /// Показывает диалог смены типа вычислений
  void showCalculationTypeDialog() {
    var calculationsTypes = <Widget>[];

    _calculator.calculationsTypes.forEach(
          (key, value) =>
          calculationsTypes.add(
            ListTile(
              title: Text(key),
              onTap: () => changeCalculationType(key, value),
            ),
          ),
    );

    showDialog(
      context: context,
      builder: (context) => SimpleDialog(children: calculationsTypes),
    );
  }

  Widget buildNavigationTile(Calculator calc) {
    var icon = SvgPicture.asset(
      calc.icon,
      semanticsLabel: calc.title,
      height: 24,
      width: 24,
    );

    var text = Text(calc.title);

    var tapAction = () =>
        setState(() {
          setupCalculator(calc);
          Navigator.pop(context); // Close drawer
        });

    return Ink(
      color: _c == calc ? const Color(0xff555555) : Colors.transparent,
      child: ListTile(
        onTap: tapAction,
        leading: icon,
        title: text,
      ),
    );
  }

  Widget buildUnimplementedBlank() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(OMIcons.settings, size: 48),
          SizedBox(height: 18),
          Text("В процессе разработки", style: TextStyle(fontSize: 18))
        ],
      ),
    );
  }

  Widget buildCalculatorUi() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: _calculator.inputs + [ResultWidget(result: _result)],
    );
  }

//endregion
}
