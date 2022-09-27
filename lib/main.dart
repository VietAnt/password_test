// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocalAuthentication auth = LocalAuthentication();

    Future authenticate() async {
      final bool isBiometricsAvailable = await auth.isDeviceSupported();

      if (!isBiometricsAvailable) return false;

      try {
        return await auth.authenticate(
          localizedReason: 'Quét Vân Tay Hoặc Mật Mã Để Vào Ứng Dụng',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
      } on PlatformException {
        return;
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 190, 230, 226),
      appBar: AppBar(
        title: const Text('Manager Smart Bank'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Đăng Nhập",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images.png',
                    width: 150,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Xác Thực Mật Mã",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 12),
                    width: 190,
                    child: const Text(
                      "Có Thể Xác thực Bằng Vân Tay Hoặc Mật Khẩu Của Bạn ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 24),
                      child: ElevatedButton(
                        onPressed: () async {
                          bool isAuthenticated = await authenticate();

                          if (isAuthenticated) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ContactsPage();
                                },
                              ),
                            );
                          } else {
                            Container();
                          }
                        },
                        child: const Text('Xác thực Mật Mã'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
