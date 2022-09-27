import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_id/data/category_operations.dart';
import 'package:password_id/models/category.dart';
import 'package:password_id/presentation/widgets/category_list.dart';

class AddCategoryPage extends StatefulWidget {
  AddCategoryPage({Key? key}) : super(key: key);

  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  //*-->ListCategory
  final _categoryController = TextEditingController();

  CategoryOperations categoryOperations = CategoryOperations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm Ngân Hàng'),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/homePage');
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          clipBehavior: Clip.none,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _categoryController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Thêm Ngân Hàng'),
                ),
              ),
              Column(
                children: [
                  FutureBuilder(
                    future: categoryOperations.getAllCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print('error');
                      var data = snapshot.data;
                      return snapshot.hasData
                          ? CategoryList(data as List<Category>)
                          : new Center(
                              child: Text("You have no contacts"),
                            );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final category = Category(name: _categoryController.text);
          categoryOperations.createCategory(category);

          Navigator.of(context).pushReplacementNamed('/addCategoryPage');
          // ignore: prefer_const_constructors
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
