import 'dart:math';

import 'package:db_miner/controller/quote_controller.dart';
import 'package:db_miner/helper/wallpaper_helper.dart';
import 'package:db_miner/modals/quote_modal.dart';
import 'package:db_miner/modals/wallpaper_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WallpaperController extends ChangeNotifier {
  List<Wallpaper> allWallpaper = [];

  WallpaperController() {
    loadData();
  }

  Future<void> loadData() async {
    allWallpaper = await WallpaperHelper.wHelper.getWallpaperData();
    notifyListeners();
  }

  void getImage({required Quote quote, required int index}) {
    quote.image = allWallpaper[index].previewUrl;
    notifyListeners();
  }
}
