import 'package:flutter/material.dart';

const List<Color> _colorThemes = [
  Colors.blue,
  Colors.red,
  Colors.pink,
  Colors.orange,
  Colors.purple,
  Colors.yellow,
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0 && selectedColor < _colorThemes.length,
            'Color index out of range');

  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorThemes[selectedColor],
    );
  }
}
