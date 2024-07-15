import 'package:db_miner/controller/quote_controller.dart';
import 'package:db_miner/controller/theme_controller.dart';
import 'package:db_miner/controller/wallpaper_controller.dart';
import 'package:db_miner/helper/quote_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  QuoteHelper.qHelper.initDb();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => QuoteController(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeController(),
        ),
        ChangeNotifierProvider(
          create: (_) => WallpaperController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
