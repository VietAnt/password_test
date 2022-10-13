import 'package:flutter/material.dart';
import 'package:password_id/data/category_operations.dart';
import 'package:password_id/data/contact_operations.dart';
import 'package:password_id/models/category.dart';
import 'package:password_id/models/contact.dart';
import 'package:password_id/presentation/widgets/categories_dropdown.dart';
import 'package:password_id/presentation/widgets/contact_list.dart';

class SearchContactsByCategory extends StatefulWidget {
  SearchContactsByCategory({Key? key}) : super(key: key);

  @override
  _SearchContactsByCategoryState createState() =>
      _SearchContactsByCategoryState();
}

class _SearchContactsByCategoryState extends State<SearchContactsByCategory> {
  ContactOperations contactOperations = ContactOperations();
  CategoryOperations categoryOperations = CategoryOperations();
  Category? _selectedCategory;

  callback(selectedCategory) {
    setState(() {
      _selectedCategory = selectedCategory;
      print(_selectedCategory!.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm kiếm Theo Danh Mục'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<List<Category>>(
              future: categoryOperations.getAllCategories(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? CategoriesDropDown(snapshot.data, callback)
                    : Text('No categories');
              },
            ),
            FutureBuilder(
              future:
                  contactOperations.getAllContactsByCategory(_selectedCategory),
              builder: (context, snapshot) {
                if (snapshot.hasError) print('error');
                var data = snapshot.data;
                return snapshot.hasData
                    ? ContactsList(data as List<Contact>)
                    : new Center(
                        child: Text('You have no contacts'),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
