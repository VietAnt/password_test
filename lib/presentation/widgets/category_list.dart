import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:password_id/data/category_operations.dart';
import 'package:password_id/models/category.dart';

class CategoryList extends StatelessWidget {
  List<Category> category;
  CategoryOperations categoryOperations = CategoryOperations();

  CategoryList(this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: category.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key('${category[index].id}'),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Số Thứ Tự : ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${category[index].id}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Tên Ngân Hàng : ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${category[index].name}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            // onDismissed: (direction) {
            //   categoryOperations.deleteCategory(category[index]);
            // },
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
                              categoryOperations
                                  .deleteCategory(category[index]);
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
          );
        },
      ),
    );
  }
}
