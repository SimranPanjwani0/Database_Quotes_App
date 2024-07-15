import 'dart:math';

import 'package:db_miner/helper/quote_helper.dart';
import 'package:db_miner/modals/quote_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuoteController extends ChangeNotifier {
  List<Quote> allQuote = [];
  List<Quote> favQuote = [];
  Color txtColor = Colors.black;
  TextStyle quoteStyle = GoogleFonts.abel();
  void changeColor({required Color color}) {
    txtColor = color;
    notifyListeners();
  }

  void changeStyle({required TextStyle style}) {
    quoteStyle = style;
    notifyListeners();
  }

  QuoteController() {
    loadData();
    initDb();
  }

  Future<void> initDb() async {
    QuoteHelper.qHelper.initDb();
    favQuote = await QuoteHelper.qHelper.getAllQuote();
    notifyListeners();
  }

  Future<void> loadData() async {
    allQuote = await QuoteHelper.qHelper.getQuoteData();
    notifyListeners();
  }

  void insertData({required Quote quote}) {
    QuoteHelper.qHelper.insertData(quote: quote);
    initDb();
  }

  void deleteData({required int id}) {
    QuoteHelper.qHelper.deleteData(id: id);
    initDb();
  }

  void addToFav({required Quote quote}) {
    quote.isLiked = true;
    initDb();
    notifyListeners();
  }
}
