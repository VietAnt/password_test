import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:password_id/data/inter_operations.dart';
import 'package:password_id/models/interbanking.dart';
import 'package:password_id/presentation/pages/edit_page/edit_it_apge.dart';
import 'package:password_id/presentation/pages/view_page/view_it_banking.dart';

class InterList extends StatelessWidget {
  List<InterBanking> inters;
  InterOperations interOperations = InterOperations();

  InterList(this.inters, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: inters.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key('${inters[index].idbanking}'),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 53, 186, 144),
                  borderRadius: BorderRadius.circular(6),
                ),
                width: MediaQuery.of(context).size.width,
                height: 130,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: const [
                            Text(
                              'e-Banking',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            const Text('Ngân Hàng  : ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              ' ${inters[index].category}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('UserName  : ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              ' ${inters[index].usernamebanking}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewInterPage(
                                                inters: inters[index],
                                              )));
                                },
                                // color: Colors.orange,
                                child: const Icon(Icons.remove_red_eye,
                                    color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditInterPage(
                                                inters: inters[index],
                                              )));
                                },

                                // color: Colors.green,
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Cảnh báo!"),
                    content:
                        const Text("Bạn có chắc chắn muốn xóa mục này không?"),
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                              interOperations.deleteInter(inters[index]);
                            },
                            child: Row(
                              children: const [
                                Text("Xóa"),
                                Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Row(
                              children: const [
                                Text("Hủy"),
                                Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
              );
            },
            // onDismissed: (direction) {
            //   interOperations.deleteInter(inters[index]);
            // },
          );
        },
      ),
    );
  }
}
