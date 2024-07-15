import 'dart:convert';
import 'dart:developer';
import 'package:db_miner/modals/quote_modal.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

enum QuoteTable { id, author, text, category, image, color, style }

class QuoteHelper {
  String qApi =
      "https://famous-quotes4.p.rapidapi.com/random?category=all&count=2000";

  Future<List<Quote>> getQuoteData() async {
    List<Quote> allQuote = [];

    http.Response response = await http.get(
      Uri.parse(qApi),
      headers: {
        'X-RapidAPI-Key': 'fccd4589e1msh12b3042ee1e2f3fp132126jsn34bc31a7639c',
        'X-RapidAPI-Host': 'famous-quotes4.p.rapidapi.com'
      },
    );
    log("${response.statusCode}");
    if (response.statusCode == 200) {
      log("${response.statusCode}");

      List data = jsonDecode(response.body);

      allQuote = data.map<Quote>((json) => Quote.fromJson(json)).toList();
    }

    return allQuote;
  }

  late Database database;
  Logger logger = Logger();

  String sql = '';
  String dbName = "db_miner.db";
  String tableName = "quotes";

  Future<Database> initDb() async {
    String path = await getDatabasesPath();
    path = "$path/$dbName";
    database = await openDatabase(path, version: 2, onCreate: (db, version) {
      String query = """create table 
              $tableName (${QuoteTable.id.name} integer primary key , 
              ${QuoteTable.author.name} text, 
              ${QuoteTable.text.name} text , 
              ${QuoteTable.category.name} text,
              ${QuoteTable.image.name} text)""";
      db
          .execute(query)
          .then(
            (value) => logger.i("Table created successfully !!!!"),
          )
          .onError(
            (error, stackTrace) => logger.e("ERROR : $error"),
          );
    }, onUpgrade: (db, va, v2) {
      String query = """alter table $tableName add column  )""";
      db
          .execute(query)
          .then(
            (value) => logger.i("Table created successfully !!!!"),
          )
          .onError(
            (error, stackTrace) => logger.e("ERROR : $error"),
          );
    });
    return database;
  }

  Future<void> insertData({required Quote quote}) async {
    sql =
        "insert into $tableName(id,text,author,category,image) values(?,?,?,?,?);";
    List args = [
      quote.id,
      quote.text,
      quote.author,
      quote.category,
      quote.image
    ];
    await database.rawInsert(sql, args);
  }

  Future<void> deleteData({required int id}) async {
    await database
        .delete(
          tableName,
          where: "id=?",
          whereArgs: [id],
        )
        .then(
          (value) => logger.i('Deleted successfully !!!'),
        )
        .onError(
          (error, stackTrace) => logger.e('ERROR : $error'),
        );
  }

  Future<List<Quote>> getAllQuote() async {
    List<Quote> allLikeData = [];

    sql = "select * from $tableName;";
    List data = await database.rawQuery(sql);
    allLikeData = data.map((e) => Quote.fromJson(e)).toList();

    return allLikeData;
  }

  QuoteHelper._();

  static final QuoteHelper qHelper = QuoteHelper._();
}
