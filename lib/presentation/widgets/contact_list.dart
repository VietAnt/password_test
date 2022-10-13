import 'package:flutter/material.dart';
import 'package:password_id/data/contact_operations.dart';
import 'package:password_id/models/contact.dart';
import 'package:password_id/presentation/pages/edit_page/edit_contact_page.dart';
import 'package:password_id/presentation/pages/view_page/view_contact_page.dart';

class ContactsList extends StatelessWidget {
  List<Contact> contacts;
  // List<Category> category;

  ContactOperations contactOperations = ContactOperations();

  ContactsList(this.contacts, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key('${contacts[index].id}'),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(5)),
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10)),
                        Row(
                          children: [
                            const Text('Ngân Hàng: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              ' ${contacts[index].category} ',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Tên  : ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              ' ${contacts[index].name}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Danh Mục  : ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              '${contacts[index].nametype}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
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
                                          builder: (context) => ViewContactPage(
                                                contact: contacts[index],
                                              )));
                                },
                                // color: Colors.orange,
                                child: const Icon(Icons.remove_red_eye,
                                    size: 22, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditContactPage(
                                                contact: contacts[index],
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
                              contactOperations.deleteContact(contacts[index]);
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
            //   contactOperations.deleteContact(contacts[index]);
            // },
          );
        },
      ),
    );
  }

  // //*-->Phương thuc tim cach
  // void findBankByContact(List<Category> category, String idCategory) {
  //   final indexName =
  //       category.indexWhere((element) => element.id == idCategory);
  //   if (indexName >= 0) {
  //     return print('${category[indexName].name}');
  //   }
  // }
}
