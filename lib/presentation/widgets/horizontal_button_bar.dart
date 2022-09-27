import 'package:flutter/material.dart';

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
                        Navigator.of(context)
                            .pushReplacementNamed('/tabBarPage');
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
                        Navigator.of(context)
                            .pushReplacementNamed('/addCategoryPage');
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
                          Navigator.of(context)
                              .pushReplacementNamed('/tabBarSearchPage');
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
