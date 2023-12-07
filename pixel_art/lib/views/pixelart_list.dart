import 'package:flutter/material.dart';
import 'package:pixel_art/views/pixelart_canvas.dart';
import 'package:pixel_art/widgets/color_picker.dart';
import 'package:pixel_art/widgets/pixel_art_grid.dart';
import 'package:pixelart_client/pixelart_client.dart';
import 'package:pixelart_shared/pixelart_shared.dart';

class PixelArtList extends StatefulWidget {
  const PixelArtList({super.key});

  @override
  State<PixelArtList> createState() => _PixelArtListState();
}

class _PixelArtListState extends State<PixelArtList> {
  final repository =
      const HTTPPixelArtRepository(url: "localhost:8080/pixelart");

  void goToCanvas(PixelArt pixelart) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PixelArtCanvas(
          pixelart: pixelart,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var listFuture = repository.list();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
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
            Expanded(
              child: FutureBuilder(
                  future: listFuture,
                  builder: (context, snapshot) {
                    final result = snapshot.data;
                    if (result != null) {
                      return ListView.builder(
                          itemCount: result.value!.length,
                          itemBuilder: (context, index) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (!snapshot.hasData) {
                              return const Center(
                                child: Text('Empty'),
                              );
                            } else {
                              final pixelart = result.value![index];
                              return Container(
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: ListTile(
                                  // Navigate to canvas for pixelart
                                  onTap: () => goToCanvas(pixelart),
                                  title: Text(pixelart.name),
                                  subtitle: Text(pixelart.description),
                                ),
                              );
                            }
                          });
                    } else {
                      return const Center(
                        child: Text('Something else'),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
