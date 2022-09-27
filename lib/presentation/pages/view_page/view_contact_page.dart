import 'package:flutter/material.dart';
import 'package:password_id/data/contact_operations.dart';
import 'package:password_id/models/contact.dart';

class ViewContactPage extends StatefulWidget {
  Contact? contact;

  ViewContactPage({Key? key, this.contact})
      : super(
          key: key,
        );

  @override
  _ViewContactPageState createState() => _ViewContactPageState();
}

//tắt viết chữ
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class _ViewContactPageState extends State<ViewContactPage> {
  ContactOperations contactOperations = ContactOperations();

  var _nameController = TextEditingController();
  var _numberController = TextEditingController();
  var _dateController = TextEditingController();
  var _passwordController = TextEditingController();
  var _nametypeController = TextEditingController();
  var _bankController = TextEditingController();

  bool isHiddenPass = true;
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
      return 'Chưa đủ 16 số, cần chỉnh sửa';
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
      return 'Chưa đủ 6 số, cần chỉnh sửa';
    }
    // return null if the text is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.contact!.name!;
    _numberController.text = widget.contact!.number.toString();
    _dateController.text = widget.contact!.date!;
    _passwordController.text = widget.contact!.password.toString();
    _nametypeController.text = widget.contact!.nametype!.toString();
    _bankController.text = widget.contact!.category.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text(' Thông Tin Thẻ'),
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.of(context).pushReplacementNamed('/homePage');
        //   },
        //   child: const Icon(
        //     Icons.arrow_back, // add custom icons also
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _nameController,
                  enableInteractiveSelection: false, // tắt viết chữ, mới thêm
                  focusNode: new AlwaysDisabledFocusNode(), //mới thêm
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Tên Chủ Thẻ'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _numberController,
                  enableInteractiveSelection: false, // tắt viết chữ, mới thêm
                  focusNode: new AlwaysDisabledFocusNode(), //mới thêm

                  onChanged: (text) => setState(() => _text), //mới thêm
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Số Thẻ',
                      errorText: _errorText),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _dateController,
                  enableInteractiveSelection: false, // tắt viết chữ, mới thêm
                  focusNode: new AlwaysDisabledFocusNode(), //mới thêm
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Hạn Dùng'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: isHiddenPass,
                  enableInteractiveSelection: false, // tắt viết chữ, mới thêm
                  focusNode: new AlwaysDisabledFocusNode(),
                  onChanged: (text) => setState(() => _text2), //mới thêm

                  //mới thêm
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    errorText: _errorText2,
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _nametypeController,
                  enableInteractiveSelection: false, // tắt viết chữ, mới thêm
                  focusNode: new AlwaysDisabledFocusNode(), //mới thêm
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Loại Thẻ'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _bankController,
                  enableInteractiveSelection: false, // tắt viết chữ, mới thêm
                  focusNode: new AlwaysDisabledFocusNode(), //mới thêm
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Ngân Hàng'),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.delete,
        ),
        onPressed: () {
          // widget.contact?.name = _nameController.text;
          // widget.contact?.numberContact = _numberController.text;
          // widget.contact?.date = _dateController.text;
          // widget.contact?.passwordContact = _passwordController.text;
          // widget.contact?.nametype = _nametypeController.text;
          //---------------------------------//
          contactOperations.deleteContact(widget.contact!);
          Navigator.of(context).pushReplacementNamed('/homePage');
        },
      ),
    );
  }

  void dispose() {
    _numberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //*-->Nút Ẩn
  void _togglePassView() {
    if (isHiddenPass == true) {
      isHiddenPass = false;
    } else {
      isHiddenPass = true;
    }
    setState(() {});
  }
}
