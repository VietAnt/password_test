import 'package:flutter/material.dart';
import 'package:password_id/presentation/pages/add_category/add_category_page.dart';
import 'package:password_id/presentation/pages/tab_page/tab_bar_add.dart';
import 'package:password_id/presentation/pages/tab_page/tab_bar_search.dart';

class HorizontalButtonBar extends StatelessWidget {
  HorizontalButtonBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      // heroTag: 'contacts',
                      onPressed: () {
                        var route = MaterialPageRoute(
                            builder: (context) => TabbarPage());
                        Navigator.pushReplacement(context, route);
                      },
                      // child: Icon(Icons.person_add),
                      child: Row(
                        children: [Icon(Icons.add), Text('Thêm Thẻ')],
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      // heroTag: 'add category button',
                      onPressed: () {
                        var route = MaterialPageRoute(
                            builder: (context) => AddCategoryPage());
                        Navigator.pushReplacement(context, route);
                      },
                      // child: Icon(Icons.playlist_add_rounded),
                      child: Row(
                        children: [Icon(Icons.add), Text('Thêm Ngân Hàng')],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          var route = MaterialPageRoute(
                              builder: (context) => TabbarSearchPage());
                          Navigator.pushReplacement(context, route);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.search),
                            Text('Tìm kiếm Thẻ/E-Banking')
                          ],
                        )),
                    const SizedBox(width: 10),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.of(context)
                    //         .pushReplacementNamed('/searchContactsByCategory');
                    //   },
                    //   child: Row(
                    //     children: const [
                    //       Icon(Icons.search_off),
                    //       Text('Tìm kiếm Ngân Hàng')
                    //     ],
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
