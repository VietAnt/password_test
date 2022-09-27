import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_id/data/category_operations.dart';
import 'package:password_id/data/inter_operations.dart';
import 'package:password_id/models/category.dart';
import 'package:password_id/models/interbanking.dart';
import 'package:password_id/presentation/widgets/categories_dropdown.dart';

class AddInterPage extends StatefulWidget {
  const AddInterPage({super.key});

  @override
  State<AddInterPage> createState() => _AddInterPageState();
}

class _AddInterPageState extends State<AddInterPage> {
  final _usernameITController = TextEditingController();
  final _passwordITController = TextEditingController();
  //*----->
  InterOperations interOperations = InterOperations();
  CategoryOperations categoryOperations = CategoryOperations();
  late Category _selectedCategory;

  //*--->
  bool isHiddenPass = true;

  callback(selectedCategory) {
    setState(() {
      _selectedCategory = selectedCategory;
      print(_selectedCategory.name);
    });
  }

  bool _submitted = false;
  var _text = '';

  //*->>>báo lỗi thiếu ký tự cho số thẻ và mã pin
  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = _usernameITController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Không thể để trống';
    }
    if (text.length < 10) {
      return 'Chưa đủ 10 số';
    }
    // return null if the text is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm dữ liệu  E-Banking'),
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.of(context).pushReplacementNamed('/homePage');
        //   },
        //   child: const Icon(
        //     Icons.arrow_back,
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _usernameITController,
                keyboardType: TextInputType.number,
                maxLength: 10, //giới hạn ký tự
                onChanged: (text) => setState(() => _text), //mới thêm
                decoration: InputDecoration(
                  errorText: _errorText,
                  border: OutlineInputBorder(),
                  labelText: 'Tên Tài Khoản',
                  hintText: 'Số Điện Thoại',
                ),
                // keyboardType: TextInputType.text,
                // textCapitalization:
                //     TextCapitalization.characters, //viết hoa tất cả chữ cái
                // inputFormatters: <TextInputFormatter>[
                //   FilteringTextInputFormatter.allow(RegExp(r'[A-Z ]')),
                // ],
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _passwordITController,
                // keyboardType: TextInputType.number,
                obscureText: isHiddenPass,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[a-z]')),
                ],
                // maxLength: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mật Khẩu',
                  suffixIcon: InkWell(
                    onTap: _togglePassView,
                    child: const Icon(
                      Icons.visibility,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<Category>>(
              future: categoryOperations.getAllCategories(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? CategoriesDropDown(snapshot.data, callback)
                    : Text('No categories');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                "Bạn có muốn thêm E-Banking?",
                style: TextStyle(fontSize: 15),
              ),
              content: Column(
                children: [
                  const Text(
                    "Tài Khoản E-Banking :",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(_usernameITController.text),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Mật Khẩu E-Banking :",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(_passwordITController.text),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Ngân Hàng E-Banking :",
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
                    final contact = InterBanking(
                      usernamebanking: int.parse(_usernameITController.text),
                      passwordbanking: _passwordITController.text,
                      category: _selectedCategory.name,
                    );
                    interOperations.createInter(contact);
                    Navigator.of(context).pushReplacementNamed('/homePage');
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
          // final contact = InterBanking(
          //   usernamebanking: int.parse(_usernameITController.text),
          //   passwordbanking: _passwordITController.text,
          //   category: _selectedCategory.name,
          // );
          // interOperations.createInter(contact);
          // Navigator.of(context).pushReplacementNamed('/homePage');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void dispose() {
    _usernameITController.dispose();
    super.dispose();
  }

  //*-->Hien thi
  void _togglePassView() {
    if (isHiddenPass == true) {
      isHiddenPass = false;
    } else {
      isHiddenPass = true;
    }
    setState(() {});
  }
}
