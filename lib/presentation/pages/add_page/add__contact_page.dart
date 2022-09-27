import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:password_id/data/category_operations.dart';
import 'package:password_id/data/contact_operations.dart';
import 'package:password_id/data/menu_opearations.dart';
import 'package:password_id/models/category.dart';
import 'package:password_id/models/contact.dart';
import 'package:password_id/models/menu_bank.dart';
import 'package:password_id/presentation/pages/contacts_page.dart';
import 'package:password_id/presentation/widgets/categories_dropdown.dart';
import 'package:password_id/presentation/widgets/menu_dropdown.dart';

class AddContactPage extends StatefulWidget {
  AddContactPage({Key? key}) : super(key: key);

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _dateController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nametypeController = TextEditingController();
  final _bankController = TextEditingController();
  //***--------- */
  ContactOperations contactOperations = ContactOperations();
  CategoryOperations categoryOperations = CategoryOperations();
  MenuOperations menuOperations = MenuOperations();

  late Category _selectedCategory;
  late MenuBanking _selectedMenu;
  bool isHiddenPass = true;

  callback(selectedCategory) {
    setState(() {
      _selectedCategory = selectedCategory;
      print(_selectedCategory.name);
    });
  }

  //*-->
  callbacks(selectionMenu) {
    setState(() {
      _selectedMenu = selectionMenu;
      print(_selectedMenu.name);
    });
  }

  bool _submitted = false;
  var _text = '';
  var _text2 = '';

  //*->>>báo lỗi thiếu ký tự cho số thẻ và mã pin
  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = _numberController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Không thể để trống';
    }
    if (text.length < 16) {
      return 'Chưa đủ 16 số';
    }
    // return null if the text is valid
    return null;
  }

  String? get _errorText2 {
    // at any time, we can get the text from _controller.value.text

    final text2 = _passwordController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text2.isEmpty) {
      return 'Không thể để trống';
    }
    if (text2.length < 6) {
      return 'Chưa đủ 6 số';
    }
    // return null if the text is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm dữ liệu thẻ'),
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.of(context).pushReplacementNamed('/homePage');
        //   },
        //   child: const Icon(
        //     Icons.arrow_back,
        //   ),
        // ),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Tên chủ thẻ'),
                  keyboardType: TextInputType.text,
                  textCapitalization:
                      TextCapitalization.characters, //viết hoa tất cả chữ cái
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Z ]')),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: TextField(
              //     controller: _numberController,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'Số thẻ',
              //     ),
              //     keyboardType: TextInputType.number,
              //     maxLength: 16,
              //     inputFormatters: <TextInputFormatter>[
              //       FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _numberController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Số thẻ',
                    errorText: _errorText, //báo lỗi thiếu ký tự(mới thêm)
                  ),
                  onChanged: (text) => setState(() => _text), //mới thêm
                  keyboardType: TextInputType.number,
                  maxLength: 16,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ngày hết hạn',
                    suffixIcon: Icon(Icons.date_range),
                  ),
                  onTap: () async {
                    DateTime? pickeddate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2050),
                      errorFormatText: 'Enter valid date',
                      errorInvalidText: 'Enter date in valid range',
                    );
                    if (pickeddate != null) {
                      setState(() {
                        _dateController.text =
                            DateFormat('dd/MM/yyyy').format(pickeddate);
                      });
                    }
                  },
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: TextField(
              //     controller: _passwordController,
              //     maxLength: 6, //giới hạn ký tự
              //     keyboardType: TextInputType.number,
              //     obscureText: isHiddenPass,
              //     decoration: InputDecoration(
              //         border: OutlineInputBorder(),
              //         labelText: 'Mã PIN',
              //         suffixIcon: InkWell(
              //           onTap: _togglePassView,
              //           child: const Icon(
              //             Icons.visibility,
              //           ),
              //         )),
              //     inputFormatters: <TextInputFormatter>[
              //       FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _passwordController,
                  maxLength: 6, //giới hạn ký tự
                  keyboardType: TextInputType.number,
                  obscureText: isHiddenPass,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mã PIN',
                      errorText: _errorText2, //báo lỗi thiếu ký tự (mới thêm)
                      suffixIcon: InkWell(
                        onTap: _togglePassView,
                        child: const Icon(
                          Icons.visibility,
                        ),
                      )),
                  onChanged: (text2) => setState(() => _text2), //mới thêm
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
              ),

              //*-----Menu----------*//
              FutureBuilder<List<MenuBanking>>(
                future: menuOperations.getAllMenus(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? MenuDropDown(snapshot.data, callbacks)
                      : Text('No categories');
                },
              ),
              const SizedBox(height: 30),
              //**-----------Category----------*/
              FutureBuilder<List<Category>>(
                future: categoryOperations.getAllCategories(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? CategoriesDropDown(snapshot.data, callback)
                      : Text('No categories');
                },
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                "Bạn có muốn thêm Thẻ ?",
                style: TextStyle(fontSize: 16),
              ),
              content: Column(
                children: [
                  const Text(
                    "Tên Tài Khoản  :",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(_nameController.text),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Số Tài Khoản  :",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(_numberController.text),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Hạn Thẻ  :",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(_dateController.text),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Mật Khẩu Thẻ :",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(_passwordController.text),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Loại Thẻ :",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(_selectedMenu.name),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Ngân Hàng :",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(_selectedCategory.name),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    final contact = Contact(
                      number: int.parse(_numberController.text),
                      name: _nameController.text,
                      date: _dateController.text,
                      password: int.parse(_passwordController.text),
                      nametype: _selectedMenu.name,
                      category: _selectedCategory.name,
                    );
                    contactOperations.createContact(contact);
                    // Navigator.of(context).pushReplacementNamed('/homePage');
                    var route =
                        MaterialPageRoute(builder: (context) => ContactsPage());
                    Navigator.push(context, route);
                  },
                  child: Container(
                    color: Colors.teal,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.done_outline, color: Colors.amber),
                        SizedBox(width: 10),
                        Text(
                          "Đồng ý",
                          style: TextStyle(color: Colors.amber, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/homePage');
                  },
                  child: Container(
                    color: Colors.teal,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.delete, color: Colors.amber),
                        SizedBox(width: 10),
                        Text(
                          "Hủy ",
                          style: TextStyle(color: Colors.amber, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
          // final contact = Contact(
          //   number: int.parse(_numberController.text),
          //   name: _nameController.text,
          //   date: _dateController.text,
          //   password: int.parse(_passwordController.text),
          //   nametype: _selectedMenu.name,
          //   category: _selectedCategory.name,
          // );
          // contactOperations.createContact(contact);
          // //*----------------*//
          // Navigator.of(context).pushReplacementNamed('/homePage');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void dispose() {
    _numberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePassView() {
    if (isHiddenPass == true) {
      isHiddenPass = false;
    } else {
      isHiddenPass = true;
    }
    setState(() {});
  }
}
