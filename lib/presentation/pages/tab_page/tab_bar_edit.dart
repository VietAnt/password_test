import 'package:flutter/material.dart';
import 'package:password_id/presentation/pages/edit_page/edit_contact_page.dart';
import 'package:password_id/presentation/pages/edit_page/edit_it_apge.dart';

class TabbarEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('---Chọn Loại Thẻ---'),
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
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.edit_note,
                    color: Colors.deepOrange,
                  ),
                  text: "E-Banking",
                ),
                Tab(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.green,
                  ),
                  text: "Thẻ ATM",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  EditInterPage(),
                  EditContactPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
