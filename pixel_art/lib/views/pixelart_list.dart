import 'package:flutter/material.dart';
import 'package:pixel_art/views/pixelart_canvas.dart';
import 'package:pixel_art/widgets/create_pixelart_modal.dart';
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
  late Future<CRUDResult<List<PixelArt>>> listFuture;

  @override
  void initState() {
    listFuture = repository.list();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void updateList() {
      listFuture = repository.list();
      setState(() {});
    }

    void goToCanvas(PixelArt pixelart) async {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PixelArtCanvas(
            pixelart: pixelart,
          ),
        ),
      );
      updateList();
    }

    void deletePixelart(String id) async {
      await repository.delete(id);
      updateList();
    }

    void createPixelart(PixelArt pixelart) async {
      await repository.create(pixelart);
      updateList();
    }

    void handleDelete(String id) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm delte pixelart'),
            actionsAlignment: MainAxisAlignment.end,
            actions: [
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  deletePixelart(id);
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );
    }

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
                                  key: UniqueKey(),
                                  onTap: () {
                                    goToCanvas(pixelart);
                                  },
                                  title: Text(pixelart.name),
                                  subtitle: Text(pixelart.description),
                                  trailing: IconButton(
                                      onPressed: () {
                                        handleDelete(pixelart.id);
                                      },
                                      icon: const Icon(Icons.delete)),
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
        onPressed: () async => showModalBottomSheet(
            useSafeArea: true,
            context: context,
            builder: (BuildContext context) {
              return CreatePixelModal(createPixelart: createPixelart);
            }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
