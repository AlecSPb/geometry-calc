import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geometry_calc/model/Calculator.dart';
import 'package:geometry_calc/model/Data.dart';
import 'package:geometry_calc/ui/screen/CalculatorScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Геометрический Калькулятор"),
          centerTitle: true,
        ),
        body: buildBody(context),
      );

  Widget buildBody(BuildContext context) => GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: _getTiles(context),
      );

  List<Widget> _getTiles(BuildContext context) {
    final List<Widget> tiles = <Widget>[];

    for (int i = 0; i < Data.calculators.length; i++) {
      var ci = Data.calculators[i];

      var svgIcon = SvgPicture.asset(
        ci.icon,
        semanticsLabel: ci.title,
        height: 64,
        width: 64,
      );

      var tileContent = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          svgIcon,
          SizedBox(height: 24),
          Text(
            ci.title,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      );

      tiles.add(
        Stack(
          children: <Widget>[
            Positioned.fill(child: tileContent),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: const Color(0x33555555),
                  onTap: () => _onTileClicked(context, ci),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return tiles;
  }

  void _onTileClicked(BuildContext context, Calculator calc) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalculatorScreen(
          calculator: calc,
        ),
      ),
    );
  }
}
