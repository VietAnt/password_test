import 'package:flutter/material.dart';
import 'package:password_id/presentation/pages/add_page/add__contact_page.dart';
import 'package:password_id/presentation/pages/add_page/add_it_page.dart';

class TabbarPage extends StatelessWidget {
  const TabbarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('---Thêm Dữ Liệu---'),
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
              labelColor: Colors.teal,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.phone_android,
                    color: Colors.deepOrange,
                  ),
                  text: "E-Banking",
                ),
                Tab(
                  icon: Icon(
                    Icons.credit_card,
                    color: Colors.red,
                  ),
                  text: "Thẻ ",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AddInterPage(),
                  AddContactPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
