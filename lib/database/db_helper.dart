import 'package:path/path.dart' as p;
import 'dart:collection';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'package:wikipedia_app/database/db_schema.dart';
import 'package:wikipedia_app/models/page.dart';


class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDatabase();
    }
    return _database;
  }

  Future<Database> _initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, "WIKI_DB");

    //open/create database at a given path
    var wikiDatabase = await openDatabase(path,
        version: 1,
        onCreate: _createDb,
        onUpgrade: _upgradeDb,
        onDowngrade: _onDowngrade);

    return wikiDatabase;
  }

  //for creating db
  void _createDb(Database db, int newVersion) async {
    Batch batch = db.batch();
    batch.execute(PageEntry.CREATE_TABLE_PAGE);
    await batch.commit();
  }

//for upgrading db
  void _upgradeDb(Database db, int newVersion, int oldVersion) async {

    Batch batch = db.batch();
    batch.execute(PageEntry.DELETE_PAGE_TABLE);
    await batch.commit();

    // Create new tables
    _createDb(db, newVersion);
    //await db.execute(migrationScript));
  }

//for downgrade db
  void _onDowngrade(Database db, int oldVersion, int newVersion) {
    _upgradeDb(db, oldVersion, newVersion);
  }

  Future<List<WikiPage>> getAllWikiPages() async {
    Database db = await this.database;
    List<WikiPage> pages = List();
    var result = await db.query(PageEntry.TABLE_PAGE);
    if(result != null && result.isNotEmpty) {
      for(Map<String, dynamic> map in result) {
        WikiPage page = WikiPage.fromJson(map);
        pages.add(page);
      }
    }
    return pages;
  }

  // Fetch Operation: Get all note objects from database
  Future<WikiPage> getWikiPage(String pageId) async {
    Database db = await this.database;
    String whereString = '${PageEntry.COLUMN_PAGE_ID} = ?';
    List<dynamic> whereArguments = [pageId];
    var result = await db.query(PageEntry.TABLE_PAGE,
        where: whereString, whereArgs: whereArguments);
    if(result != null && result.isNotEmpty) {
      return WikiPage.fromJson(result[0]);
    }
    return null;
  }

  Future insertWikiPage(WikiPage page) async {
    Database db = await this.database;
    List<dynamic> whereArguments = [page.pageId];
    int result = await db.update(
        PageEntry.TABLE_PAGE, page.toJson(),
        where: PageEntry.PRIMARY_KEY_WHERE_STRING, whereArgs: whereArguments);
    print("REsult after update " + result.toString());
    if (result == 0) {
      result =
      await db.insert(PageEntry.TABLE_PAGE, page.toJson());
      print("Result after insert " + result.toString());
    }
    print("Result before return " + result.toString());
    return result;

  }
}