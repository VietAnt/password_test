import 'package:flutter/material.dart';
import 'package:password_id/data/inter_operations.dart';
import 'package:password_id/models/category.dart';
import 'package:password_id/models/interbanking.dart';
import 'package:password_id/presentation/widgets/categories_dropdown.dart';
import 'package:password_id/presentation/widgets/intern_list.dart';

import '../../../data/category_operations.dart';

class SearchIntersByCategory extends StatefulWidget {
  SearchIntersByCategory({Key? key}) : super(key: key);

  @override
  _SearchIntersByCategoryState createState() => _SearchIntersByCategoryState();
}

class _SearchIntersByCategoryState extends State<SearchIntersByCategory> {
  InterOperations interOperations = InterOperations();
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
        title: const Text('Tìm kiếm Theo Ngân Hàng'),
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.of(context).pushReplacementNamed('/homePage');
        //   },
        //   child: const Icon(
        //     Icons.arrow_back,
        //   ),
        // ),
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
                  interOperations.getAllContactsByCategory(_selectedCategory),
              builder: (context, snapshot) {
                if (snapshot.hasError) print('error');
                var data = snapshot.data;
                return snapshot.hasData
                    ? InterList(data as List<InterBanking>)
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
