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
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  double _result = 0;

  Calculator _c;
  ICalculator _calculator;

  String _calculationTypeName;
  Function _calculationType;

  @override
  void initState() {
    super.initState();
    initCalculator(widget.calculator);
  }

  void initCalculator(Calculator calculator) {
    _c = calculator;
    _calculator = _c.calculator.build(inputChangedCallback);

    _calculationTypeName = _calculator.calculationsTypes.keys.toList()[0];
    _calculationType = _calculator.calculationsTypes[_calculationTypeName];

    _result = _calculationType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(),
      endDrawer: Drawer(
        child: ListView.builder(
          itemCount: Data.calculators.length,
          itemBuilder: (context, index) {
            var calculator = Data.calculators[index];

            return buildTile(calculator, calculator == _c);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: _calculator.getInputs() + [ResultWidget(result: _result)],
        ),
      ),
    );
  }

  Widget buildAppBar() {
    var title = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(_c.title),
        SizedBox(height: 4, width: double.infinity),
        Opacity(
          child: Text(_calculationTypeName, style: TextStyle(fontSize: 12)),
          opacity: 0.5,
        ),
      ],
    );

    var calculationsTypes = <Widget>[];
    _calculator.calculationsTypes.forEach((key, value) {
      calculationsTypes.add(
        ListTile(
          title: Text(key),
          onTap: () =>
              setState(() {
                _calculationType = value;
                _calculationTypeName = key;

                _result = _calculationType();

                Navigator.pop(context); // Close dialog
              }),
        ),
      );
    });

    var homeButton = IconButton(
      icon: Icon(OMIcons.home),
      onPressed: () => Navigator.pop(context),
    );

    var actions = <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => {},
      ),
      IconButton(
        icon: Icon(Icons.menu),
        onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
      )
    ];

    return AppBar(
      title: InkWell(
        child: title,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => SimpleDialog(children: calculationsTypes),
          );
        },
      ),
      centerTitle: true,
      leading: homeButton,
      actions: actions,
      backgroundColor: Colors.transparent,
    );
  }

  Widget buildTile(Calculator calc, bool selected) {
    return Ink(
      color: selected ? const Color(0xff555555) : Colors.transparent,
      child: ListTile(
        onTap: () =>
            setState(() {
              initCalculator(calc);
              Navigator.pop(context); // Close drawer
            }),
        leading: SvgPicture.asset(
          calc.icon,
          semanticsLabel: calc.title,
          height: 24,
          width: 24,
        ),
        title: Text(calc.title),
      ),
    );
  }

  void inputChangedCallback() {
    setState(() {
      _result = _calculationType();
    });
  }
}
