import 'package:password_id/data/database.dart';
import 'package:password_id/models/category.dart';

class CategoryOperations {
  CategoryOperations? categoryOperations;

  final dbProvider = DatabaseRepository.privateConstructor();

  createCategory(Category category) async {
    final db = await dbProvider.database;
    db!.insert('category', category.toMap());
  }

  Future<List<Category>> getAllCategories() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> allRows = await db!.query('category');
    List<Category> categories =
        allRows.map((category) => Category.fromMap(category)).toList();
    return categories;
  }

  //Xóa Category:
  deleteCategory(Category category) async {
    final db = await dbProvider.database;
    await db!
        .delete('category', where: 'categoryId=?', whereArgs: [category.id]);
  }

  // //Timkiem
  // searchName(List<Category> category, int categoryId) {
  //   final name = category.indexWhere((element) => element.id == categoryId);
  //   if(name >= 0){
  //     print('${category[index].name}')
  //   }
  // }
}
