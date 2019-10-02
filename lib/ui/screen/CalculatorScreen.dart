import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geometry_calc/model/Calculator.dart';
import 'package:geometry_calc/model/Data.dart';
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

  Calculator get _calculator => widget.calculator;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(),
      endDrawer: Drawer(
        child: ListView.builder(
          itemCount: Data.calculators.length,
          itemBuilder: (context, index) => buildTile(Data.calculators[index]),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children:
          _calculator.calculator.build(inputChangedCallback).getInputs() +
              [ResultWidget(result: _result)],
        ),
      ),
    );
  }

  Widget buildAppBar() {
    var title = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,

      children: <Widget>[
        Text(_calculator.title),
        SizedBox(height: 4, width: double.infinity,),
        Opacity(
          child: Text("Объём", style: TextStyle(fontSize: 12)),
          opacity: 0.5,
        ),
      ],
    );

    var homeButton = IconButton(
      icon: Icon(OMIcons.home),
      onPressed: () => Navigator.pop(context),
    );

    var actions = <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(Icons.menu),
        onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
      )
    ];

    return AppBar(
      title: InkWell(
        child: title,
        onTap: () {},
      ),
      centerTitle: true,
      leading: homeButton,
      actions: actions,
      backgroundColor: Colors.transparent,
    );
  }

  Widget buildTile(Calculator calc) {
    return ListTile(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CalculatorScreen(
                  calculator: calc,
                ),
          ),
        );
      },
      leading: SvgPicture.asset(
        calc.icon,
        semanticsLabel: calc.title,
        height: 24,
        width: 24,
      ),
      title: Text(calc.title),
    );
  }

  void inputChangedCallback() {
    //todo рассчёт в зависимости от выбранного режима
    setState(() {
      _result = _calculator.calculator.calculateVolume();
    });
  }
}
