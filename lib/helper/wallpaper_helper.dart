import 'dart:convert';
import 'dart:developer';

import 'package:db_miner/modals/wallpaper_modal.dart';
import 'package:http/http.dart' as http;

class WallpaperHelper {
  String wApi =
      "https://pixabay.com/api/?key=33836237-4d6c3f47d20719c7c29c81a99&q=nature&image_type=vector&page=1&per_page=50";

  Future<List<Wallpaper>> getWallpaperData() async {
    List<Wallpaper> allWallpaper = [];

    http.Response response = await http.get(
      Uri.parse(wApi),
    );
    log("${response.statusCode}");
    if (response.statusCode == 200) {
      log("${response.statusCode}");

      Map data = jsonDecode(response.body);
      List dataList = data["hits"];

      allWallpaper =
          dataList.map<Wallpaper>((json) => Wallpaper.fromJson(json)).toList();
    }

    return allWallpaper;
  }

  WallpaperHelper._();

  static final WallpaperHelper wHelper = WallpaperHelper._();
}
