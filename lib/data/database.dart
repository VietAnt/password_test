import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseRepository {
  DatabaseRepository.privateConstructor();

  static final DatabaseRepository instance =
      DatabaseRepository.privateConstructor();

  // final _databaseName = 'sasu';
  // final _databaseVersion = 1;

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDatabase();
      return _database;
    }
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'micro.db');
    return await openDatabase(path, version: 1, onCreate: await onCreate);
  }

  Future onCreate(Database db, version) async {
    //*-->Thẻ
    await db.execute('''
          CREATE TABLE contact (
            contactId INTEGER PRIMARY KEY AUTOINCREMENT,
            contactName STRING NOT NULL,
            contactDate STRING NOT NULL,
            passwords INT NOT NULL, 
            numbers INT NOT NULL,
            contactType STRING NOT NULL,
            FK_contact_category INT NOT NULL,
            FOREIGN KEY (FK_contact_category) REFERENCES category (categoryId) 
          )
          ''');

    //*--->Ngân Hàng
    await db.execute('''
          CREATE TABLE category (
            categoryId INTEGER PRIMARY KEY AUTOINCREMENT,
            categoryName STRING NOT NULL
          )
          ''');
    await db.execute(
        '''INSERT INTO category (categoryName) VALUES ('BIDV'), ('VietComBank'), ('TechComBank'),('SeABank'),('VietinBank'),('VIB'),('AgriBank');''');

    //*-->E-Banking
    await db.execute('''
          CREATE TABLE banking (
            bankingId INTEGER PRIMARY KEY AUTOINCREMENT,
            bankingName INT NOT NULL,
            bankingPasse STRING NOT NULL,
            FK_banking_category STRING NOT NULL,
            FOREIGN KEY (FK_banking_category) REFERENCES category (categoryId) 
          )
          ''');
    //*-->MenuBanking
    await db.execute('''
          CREATE TABLE menu (
            menuId INTEGER PRIMARY KEY AUTOINCREMENT,
            menuName STRING NOT NULL
          )
          ''');
    await db.execute(
        '''INSERT INTO menu (menuName) VALUES ('Thẻ ATM'), ('Thẻ Ghi Nợ (Debit Card)'), ('Thẻ Tín Dụng (Credit Card )'),('Thẻ Trả Trước (Prepaid Card)');''');
  }
}
