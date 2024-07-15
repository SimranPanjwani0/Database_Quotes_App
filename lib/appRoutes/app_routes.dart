import 'package:db_miner/pages/detailPage/detail_page.dart';
import 'package:db_miner/pages/favPage/fav_page.dart';
import 'package:db_miner/pages/homePage/home_page.dart';
import 'package:db_miner/pages/splashPage/splash_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  String splash = '/';
  String home = 'home';
  String detail = 'detail';
  String fav = 'fav';

  Map<String, WidgetBuilder> allRoutes = {
    '/': (context) => const SplashPage(),
    'home': (context) => const HomePage(),
    'detail': (context) => DetailPage(),
    'fav': (context) => FavPage(),
  };
  AppRoutes._();
  static final AppRoutes instance = AppRoutes._();
}
