import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geometry_calc/model/Calculator.dart';
import 'package:geometry_calc/model/Data.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class CalculatorScreen extends StatefulWidget {
  final Calculator calculator;

  CalculatorScreen({@required this.calculator});

  @override
  State<StatefulWidget> createState() {
    return CalculatorScreenState(calculator);
  }
}

class CalculatorScreenState extends State<CalculatorScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  Calculator _calculator;

  CalculatorScreenState(this._calculator);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(_calculator.title),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(OMIcons.home),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView.builder(
          itemCount: Data.calculators.length,
          itemBuilder: (context, index) {
            var ci = Data.calculators[index];

            return ListTile(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalculatorScreen(
                      calculator: ci,
                    ),
                  ),
                );
              },
              leading: SvgPicture.asset(
                ci.icon,
                semanticsLabel: ci.title,
                height: 24,
                width: 24,
              ),
              title: Text(ci.title),
            );
          },
        ),
      ),
    );
  }
}
