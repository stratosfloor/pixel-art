import 'package:flutter/material.dart';
import 'package:pixel_art/widgets/color_picker.dart';
import 'package:pixel_art/widgets/pixel_art_grid.dart';
import 'package:pixelart_client/pixelart_client.dart';
import 'package:pixelart_shared/pixelart_shared.dart';

class PixelArtCanvas extends StatefulWidget {
  const PixelArtCanvas({
    super.key,
    required this.pixelart,
  });

  final PixelArt pixelart;

  @override
  State<PixelArtCanvas> createState() => _PixelArtCanvasState();
}

class _PixelArtCanvasState extends State<PixelArtCanvas> {
  var _selectedColor = const Color(0xFFffa800);
  String _participant = '';

  void selectColor(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  final repository =
      const HTTPPixelArtRepository(url: "localhost:8080/pixelart");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Pixel Artzzzz',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.blueGrey,
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              widget.pixelart.name,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            ColorPicker(
                selectedColor: _selectedColor, selectColor: selectColor),
            const SizedBox(height: 8),
            TextField(
              onChanged: (value) {
                _participant = value;
              },
              autocorrect: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Name'),
            ),
            const SizedBox(height: 8),
            PixelArtGrid(
              pixelart: widget.pixelart,
              selectedColor: _selectedColor,
              participant: _participant,
            ),
          ],
        ),
      ),
    );
  }
}
