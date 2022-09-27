import 'package:flutter/material.dart';
import 'package:password_id/presentation/pages/contacts_page.dart';
import 'package:password_id/presentation/pages/edit_page/edit_contact_page.dart';
import 'package:password_id/presentation/pages/tab_page/tab_bar_add.dart';
import 'package:password_id/presentation/pages/tab_page/tab_bar_search.dart';
import 'package:password_id/presentation/pages/tab_page/tab_search_category.dart';

import 'presentation/pages/add_category/add_category_page.dart';
import 'presentation/pages/view_page/view_contact_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: {
        '/homePage': (context) => ContactsPage(),
        '/edit': (context) => EditContactPage(),
        '/view': (context) => ViewContactPage(),
        '/addCategoryPage': (context) => AddCategoryPage(),
        '/searchContactsByCategory': (context) => TabSearchCategory(),
        '/tabBarPage': (context) => TabbarPage(),
        '/tabBarSearchPage': (context) => TabbarSearchPage(),
        // '/homePage': (context) => GroupList(),
        // '/addContactPage': (context) => AddContactPage(),
        // '/searchPage': (context) => SearchPage(),
      },
      // home: GroupList(),
      home: ContactsPage(),
    );
  }
}
