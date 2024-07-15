import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:db_miner/controller/quote_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class FavPage extends StatelessWidget {
  FavPage({super.key});

  Future<void> captureAndSetWallpaper(
      GlobalKey key, String fileName, int location) async {
    try {
      // Capture the RepaintBoundary as an image
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      // Convert the image to byte data
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Get the directory to save the file
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);

      // Write the byte data to the file
      await file.writeAsBytes(pngBytes);

      // Set the wallpaper using async_wallpaper
      bool result = await AsyncWallpaper.setWallpaperFromFile(
        filePath: filePath,
        wallpaperLocation: location,
      );

      if (result) {
        print('Wallpaper set successfully');
      } else {
        print('Failed to set wallpaper');
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<GlobalKey> allKeys = List.generate(
      Provider.of<QuoteController>(context).favQuote.length,
      (index) => GlobalKey(),
    );
    QuoteController listenable = Provider.of<QuoteController>(context);
    QuoteController nonListenable =
        Provider.of<QuoteController>(context, listen: false);
    Size s = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://dspncdn.com/a1/media/originals/64/95/d3/6495d3311f1112049ebab1c7b5fb47f5.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: s.height * 0.08,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "Favourites",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                listenable.favQuote.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listenable.favQuote.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              RepaintBoundary(
                                key: allKeys[index],
                                child: Container(
                                  height: s.height * 0.7,
                                  width: s.width,
                                  margin: const EdgeInsets.only(
                                    right: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        listenable.favQuote[index].image,
                                      ),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 70,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: s.height * 0.17,
                                      ),
                                      Text(
                                        listenable.favQuote[index].text,
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      nonListenable.deleteData(
                                          id: listenable.favQuote[index].id);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Colors.black,
                                      ),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text("Set as wallpaper"),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                captureAndSetWallpaper(
                                                  allKeys[index],
                                                  'bgImage.png',
                                                  AsyncWallpaper.HOME_SCREEN,
                                                );
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              child: const Text("HomePage"),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                captureAndSetWallpaper(
                                                  allKeys[index],
                                                  'bgImage.png',
                                                  AsyncWallpaper.LOCK_SCREEN,
                                                );
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Lock screen"),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                captureAndSetWallpaper(
                                                  allKeys[index],
                                                  'bgImage.png',
                                                  AsyncWallpaper.BOTH_SCREENS,
                                                );
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                  "Lock and Home screens"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Set as Wallpaper",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
