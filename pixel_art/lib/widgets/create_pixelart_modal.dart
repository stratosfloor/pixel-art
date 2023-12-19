import 'package:flutter/material.dart';
import 'package:pixelart_shared/pixelart_shared.dart';
import 'package:uuid/uuid.dart';

class CreatePixelModal extends StatelessWidget {
  CreatePixelModal({
    super.key,
    required this.createPixelart,
  });

  final void Function(PixelArt pixelart) createPixelart;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();

  PixelArt newPixelArt() {
    return PixelArt(
        id: const Uuid().v4(),
        name: _nameController.text,
        description: _descriptionController.text,
        width: int.parse(_widthController.text),
        height: int.parse(_heightController.text),
        editors: [],
        pixelMatrix: [[]]);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'PixelArt name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: 'PixelArt description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _widthController,
                  decoration: InputDecoration(
                    labelText: 'PixelArt height',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _heightController,
                  decoration: InputDecoration(
                    labelText: 'PixelArt height',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel')),
                    ElevatedButton(
                      onPressed: () {
                        createPixelart(newPixelArt());
                        Navigator.pop(context);
                      },
                      child: const Text('Create PixelArt'),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
