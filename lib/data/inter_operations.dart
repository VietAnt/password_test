import 'package:password_id/data/database.dart';
import 'package:password_id/models/category.dart';
import 'package:password_id/models/interbanking.dart';

class InterOperations {
  InterOperations? interOperations;

  //--->dbProvider
  final dbbProvider = DatabaseRepository.privateConstructor();

  //createInter
  createInter(InterBanking interBanking) async {
    final db = await dbbProvider.database;
    db!.insert('banking', interBanking.toMap());
    print('Internet Banking');
  }

  //updateInter
  updateInter(InterBanking interBanking) async {
    final db = await dbbProvider.database;
    db!.update('banking', interBanking.toMap(),
        where: "bankingId=?", whereArgs: [interBanking.idbanking]);
  }

  //deleteInter
  deleteInter(InterBanking interBanking) async {
    final db = await dbbProvider.database;
    await db!.delete('banking',
        where: 'bankingId=?', whereArgs: [interBanking.idbanking]);
  }

  //getAllInternet
  Future<List<InterBanking>> getAllInters() async {
    final db = await dbbProvider.database;
    List<Map<String, dynamic>> allRows = await db!.query('banking');
    List<InterBanking> inters =
        allRows.map((contact) => InterBanking.fromMap(contact)).toList();
    return inters;
  }

  //getAllContactsByCategory
  Future<List<InterBanking>> getAllContactsByCategory(
      Category? category) async {
    final db = await dbbProvider.database;
    List<Map<String, dynamic>> allRows = await db!.rawQuery('''
    SELECT * FROM  banking
    WHERE banking.FK_banking_category = ${category?.id}
    ''');
    List<InterBanking> inters =
        allRows.map((contact) => InterBanking.fromMap(contact)).toList();
    return inters;
  }

  //searchContacts
  Future<List<InterBanking>> searchInters(String keyword) async {
    final db = await dbbProvider.database;
    List<Map<String, dynamic>> allRows = await db!.query('banking',
        where: 'FK_banking_category LIKE ?', whereArgs: ['%$keyword%']);
    List<InterBanking> contacts =
        allRows.map((contact) => InterBanking.fromMap(contact)).toList();
    return contacts;
  }
}
