import 'package:flutter/material.dart';
import 'package:password_id/presentation/pages/search_page/search_contacts_by_category.dart';
import 'package:password_id/presentation/pages/search_page/search_it_by_category.dart';

class TabSearchCategory extends StatelessWidget {
  const TabSearchCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('--Tìm Kiếm Thẻ/E-Banking--'),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/homePage');
            },
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: Column(
          children: [
            const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.blue,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.search,
                    color: Colors.deepOrange,
                  ),
                  text: 'Thẻ ',
                ),
                Tab(
                  icon: Icon(
                    Icons.search,
                    color: Colors.green,
                  ),
                  text: 'E-Banking',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SearchContactsByCategory(),
                  SearchIntersByCategory(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
