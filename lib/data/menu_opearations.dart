import 'package:password_id/data/database.dart';
import 'package:password_id/models/menu_bank.dart';

class MenuOperations {
  MenuOperations? menuOperations;

  final dbProvider = DatabaseRepository.privateConstructor();

  createMenu(MenuBanking menuBanking) async {
    final db = await dbProvider.database;
    db!.insert('menu', menuBanking.toMap());
  }

  Future<List<MenuBanking>> getAllMenus() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> allRows = await db!.query('menu');
    List<MenuBanking> menus =
        allRows.map((menu) => MenuBanking.fromMap(menu)).toList();
    return menus;
  }

  //Xóa Category:
  deleteCategory(MenuBanking menuBanking) async {
    final db = await dbProvider.database;
    await db!.delete('menu', where: 'menuId=?', whereArgs: [menuBanking.id]);
  }
}
