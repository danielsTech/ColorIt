import 'package:flutter/material.dart';

import 'package:task_app/random_color_generator.dart';
import 'package:task_app/system_chrome.dart';

void main() {
  runApp(MaterialClass());
}

class MaterialClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ColorIt',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Raleway',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Color _backgroundBottomColor = Colors.pinkAccent;
  Color _backgroundTopColor = Colors.purple;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 0.15,
    );
    _animationController.addListener(() {
      setState(() {
        if (_animationController.isCompleted) {
          _animationController.reverse();
        }
      });
    });
    systemChromeSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _background,
          _textViewSection,
        ],
      ),
    );
  }

  GestureDetector get _background => GestureDetector(
        onTap: () {
          setState(() {
            _backgroundBottomColor = getRandomColor();
            _backgroundTopColor = getRandomColor();
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          curve: Curves.linear,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _backgroundBottomColor,
                _backgroundTopColor,
              ],
              stops: [0.2, 0.75],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
        ),
      );

  Center get _textViewSection => Center(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onDoubleTap: () {
              _animationController.forward();
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(17.0),
            child: Transform.scale(
              alignment: Alignment.center,
              scale: 1.0 + _animationController.value,
              child: Container(
                width: 150.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(18.0),
                  border: Border.all(
                    color: Colors.purple[50].withOpacity(0.7),
                    width: 1.8,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Hey there!",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.88),
                      fontSize: 27.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
