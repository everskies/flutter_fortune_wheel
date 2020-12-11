import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

void main() {
  runApp(DemoApp());
}

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fortune Wheel Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _value = 0;
  Alignment _alignment = Alignment.topCenter;

  @override
  Widget build(BuildContext context) {
    final wheelFields = <String>['1', '2', '3', '4', '5', '6', '7', '8'];

    final rollButton = RaisedButton(
      child: Text('Roll'),
      onPressed: () {
        setState(() {
          int rand = _value;
          while (rand == _value) {
            rand = Random().nextInt(wheelFields.length);
          }
          _value = rand;
        });
      },
    );

    final Map<Alignment, String> alignments = {
      Alignment.topCenter: 'top center',
      Alignment.topRight: 'top right',
      Alignment.centerRight: 'center right',
      Alignment.bottomRight: 'bottom right',
      Alignment.bottomCenter: 'bottom center',
      Alignment.bottomLeft: 'bottom left',
      Alignment.centerLeft: 'center left',
      Alignment.topLeft: 'top left',
      Alignment.center: 'center',
    };

    final indicatorPosition = DropdownButton(
      value: _alignment,
      items: alignments.keys
          .map((e) => DropdownMenuItem(
                child: Text(alignments[e]),
                value: e,
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _alignment = value;
        });
      },
    );

    final actions = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: rollButton),
        Padding(padding: const EdgeInsets.all(8.0), child: indicatorPosition),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                actions,
                Text('Rolled Value: ${wheelFields[_value]}'),
                Expanded(
                  child: FortuneWheel(
                    selected: _value,
                    animation: FortuneWheelAnimation.Roll,
                    onAnimationStart: () {
                      print('Animation start');
                    },
                    onAnimationEnd: () {
                      print('Animation end');
                    },
                    indicators: [
                      FortuneWheelIndicator(
                        alignment: _alignment,
                        child: TriangleIndicator(),
                      ),
                    ],
                    slices: wheelFields.map((e) {
                      return CircleSlice(child: Text(e));
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
