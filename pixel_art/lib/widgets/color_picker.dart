import 'package:flutter/material.dart';

const colors = <Color>[
  Color(0xFF6d001a),
  Color(0xFFbe0039),
  Color(0xFFff4500),
  Color(0xFFffa800),
  Color(0xFFffd635),
  Color(0xFFfff8b8),
  Color(0xFF00a368),
  Color(0xFF00cc78),
  Color(0xFF7eed56),
  Color(0xFF00756f),
  Color(0xFF009eaa),
  Color(0xFF00ccc0),
  Color(0xFF2450a4),
  Color(0xFF3690ea),
  Color(0xFF51e9f4),
  Color(0xFF493ac1),
  Color(0xFF6a5cff),
  Color(0xFF94b3ff),
  Color(0xFF811e9f),
  Color(0xFFb44ac0),
  Color(0xFFe4abff),
  Color(0xFFde107f),
  Color(0xFFff3881),
  Color(0xFFff99aa),
  Color(0xFF6d482f),
  Color(0xFF9c6926),
  Color(0xFFffb470),
  Color(0xFF000000),
  Color(0xFF515252),
  Color(0xFF898d90),
  Color(0xFFd4d7d9),
  Color(0xFFffffff),
];

class ColorPicker extends StatelessWidget {
  const ColorPicker(
      {super.key, required this.selectedColor, required this.selectColor});

  final Color selectedColor;
  final void Function(Color color) selectColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            for (var i = 0; i < colors.length; i++)
              GestureDetector(
                onTap: () => selectColor(colors[i]),
                child: Container(
                  height: 64,
                  width: 64,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: colors[i],
                    border: selectedColor == colors[i]
                        ? Border.all(
                            width: 4,
                            color: Colors.black,
                          )
                        : Border.all(
                            width: 2,
                            color: Colors.grey,
                          ),
                  ),
                  child: Center(
                    child: Text(
                      colors[i].toString().substring(10, 16),
                    ),
                  ),
                ),
              )
          ],
        ),
      ],
    );
  }
}
