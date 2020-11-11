import 'dart:math';

import 'package:flutter/material.dart';

const _colors = [
  Colors.deepPurpleAccent,
  Colors.deepPurple,
  Colors.pink,
  Colors.purple,
  Colors.purpleAccent,
  Colors.deepOrange,
  Colors.red,
];

Random _randomIndex = new Random();

Color getRandomColor() {
  return _colors[_randomIndex.nextInt(_colors.length)];
}
