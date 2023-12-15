import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pixelart_client/pixelart_client.dart';
import 'package:pixelart_shared/pixelart_shared.dart';

class PixelArtGrid extends StatefulWidget {
  const PixelArtGrid({
    super.key,
    required this.pixelart,
    required this.selectedColor,
    required this.participant,
  });

  final PixelArt pixelart;
  final Color selectedColor;
  final String participant;

  @override
  State<PixelArtGrid> createState() => _PixelArtGridState();
}

class _PixelArtGridState extends State<PixelArtGrid> {
  late List<List<Pixel>> matrix;
  final repository =
      const HTTPPixelArtRepository(url: "localhost:8080/pixelart");
  late Stream<PixelArt?> stream;

  void initStream() async {
    stream = await repository.changes(widget.pixelart.id);
    print('Stream init');
  }

  @override
  void initState() {
    initStream();

    super.initState();

    widget.pixelart.pixelMatrix[0].isEmpty
        ? matrix = List.generate(
            widget.pixelart.height,
            (_) => List.generate(
              widget.pixelart.width,
              (_) => const Pixel(
                  red: 224,
                  green: 224,
                  blue: 224,
                  alpha: 224,
                  placedBy: Participant(id: '', name: '')),
            ),
          )
        : matrix = widget.pixelart.pixelMatrix;
  }

  void updatePixelart() async {
    final updatedPixelart = widget.pixelart.copyWith(pixelMatrix: matrix);
    await repository.update(widget.pixelart.id, updatedPixelart);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final streamsss = Stream.fromFuture(repository.changes(widget.pixelart.id))
        .listen((event) {});

    // StreamBuilder(
    //   stream: stream,
    //   builder: (context, snapshot) {
    //     print(snapshot.data!.name);
    //     if (snapshot.hasData) {
    //       return Text(snapshot.data!.name);
    //     }
    //     return Text('data');
    //   },
    // );

    getIndexI(int index, PixelArt pixelart) {
      return (index / pixelart.width).floor();
    }

    int getIndexJ(int index, PixelArt pixelart) {
      return (index % pixelart.height).floor();
    }

    Pixel getPixel(int index, PixelArt pixelart) {
      int i = (index / pixelart.width).floor();
      int j = (index % pixelart.height).floor();
      return matrix[i][j];
    }

    Color getColorFromARGB(Pixel pixel) {
      return Color.fromARGB(
        pixel.alpha,
        pixel.red,
        pixel.green,
        pixel.blue,
      );
    }

    void changeColor(int index) {
      matrix[getIndexI(index, widget.pixelart)]
              [getIndexJ(index, widget.pixelart)] =
          Pixel(
              red: widget.selectedColor.red,
              green: widget.selectedColor.green,
              blue: widget.selectedColor.blue,
              alpha: widget.selectedColor.alpha,
              placedBy: Participant(
                  id: widget.participant, name: widget.participant));
      setState(() {});
    }

    return Expanded(
      child: GridView.count(
        crossAxisCount: widget.pixelart.width,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        children: List.generate(
          widget.pixelart.width * widget.pixelart.height,
          (index) => GestureDetector(
            onTap: () {
              changeColor(index);
              updatePixelart();
            },
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    title: Text(
                        'Pixel created by: ${getPixel(index, widget.pixelart).placedBy.name}')),
              );
            },
            child: Container(
              height: 32,
              width: 32,
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                border: Border.all(),
                color: getColorFromARGB(getPixel(index, widget.pixelart)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
