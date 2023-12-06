import 'package:flutter/material.dart';
import 'package:pixel_art/widgets/color_picker.dart';
import 'package:pixel_art/widgets/pixel_art_canvas.dart';

class PixelArt extends StatefulWidget {
  const PixelArt({super.key});

  @override
  State<PixelArt> createState() => _PixelArtState();
}

class _PixelArtState extends State<PixelArt> {
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
        child: const Column(
          children: [
            ColorPicker(),
            Text('data'),
            PixelArtCanvas(),
          ],
        ),
      ),
    );
  }
}
