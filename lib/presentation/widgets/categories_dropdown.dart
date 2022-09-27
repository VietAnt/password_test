import 'package:flutter/material.dart';
import 'package:password_id/models/category.dart';

class CategoriesDropDown extends StatefulWidget {
  List<Category>? categories;

  Function(Category) callback;

  CategoriesDropDown(
    this.categories,
    this.callback, {
    Key? key,
  }) : super(key: key);

  @override
  _CategoriesDropDownState createState() => _CategoriesDropDownState();
}

class _CategoriesDropDownState extends State<CategoriesDropDown> {
  Category? dropdownvalue;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 215, 209, 209)),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
            alignedDropdown: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<Category>(
                  value: dropdownvalue,
                  hint: const Text('Chọn Ngân Hàng'),
                  onChanged: (values) {
                    setState(() {
                      dropdownvalue = widget.callback(values!);
                    });
                  },
                  items: widget.categories!.map((category) {
                    return DropdownMenuItem(
                        value: category,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(category.name),
                        ));
                  }).toList(),
                ),
              ],
            )),
      ),
    );
  }
}
