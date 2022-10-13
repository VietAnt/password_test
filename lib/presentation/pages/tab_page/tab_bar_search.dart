import 'package:flutter/material.dart';
import 'package:password_id/presentation/pages/contacts_page.dart';
import 'package:password_id/presentation/pages/search_page/search_contacts.dart';
import 'package:password_id/presentation/pages/search_page/search_it.dart';

class TabbarSearchPage extends StatelessWidget {
  const TabbarSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(' Tìm Kiếm Dữ Liệu'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  var route =
                      MaterialPageRoute(builder: (context) => ContactsPage());
                  Navigator.pushReplacement(context, route);
                },
                icon: Icon(Icons.logout)),
          ],
        ),
        body: Column(
          children: [
            const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.search,
                    color: Colors.deepOrange,
                  ),
                  text: 'E-Banking',
                ),
                Tab(
                  icon: Icon(
                    Icons.search,
                    color: Colors.green,
                  ),
                  text: 'Thẻ',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SearchBankingPage(),
                  SearchPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
