import 'package:flutter/material.dart';
import 'package:password_id/data/inter_operations.dart';
import 'package:password_id/models/interbanking.dart';

class ViewInterPage extends StatefulWidget {
  InterBanking? inters;

  ViewInterPage({Key? key, this.inters})
      : super(
          key: key,
        );

  @override
  _ViewInterPageState createState() => _ViewInterPageState();
}

//tắt viết chữ
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class _ViewInterPageState extends State<ViewInterPage> {
  InterOperations interOperations = InterOperations();

  var _nameitController = TextEditingController();
  var _passitController = TextEditingController();
  var _bankitController = TextEditingController();

  bool isHiddenPass = true;
  bool _submitted = false;
  var _text = '';
  //*->>>báo lỗi thiếu ký tự cho số thẻ và mã pin
  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = _nameitController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Không thể để trống';
    }
    if (text.length < 10) {
      return 'Chưa đủ 10 số, cần chỉnh sửa';
    }
    // return null if the text is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _nameitController.text = widget.inters!.usernamebanking.toString();
    _passitController.text = widget.inters!.passwordbanking.toString();
    _bankitController.text = widget.inters!.category.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông Tin E-Banking'),
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
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  enableInteractiveSelection: false, // tắt viết chữ, mới thêm
                  focusNode: new AlwaysDisabledFocusNode(), //mới thê
                  controller: _nameitController,
                  onChanged: (text2) => setState(() => _text), //mới thêm
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Tài Khoản',
                      errorText: _errorText),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _passitController,
                  obscureText: isHiddenPass,
                  enableInteractiveSelection: false, // tắt viết chữ, mới thêm
                  focusNode: new AlwaysDisabledFocusNode(), //mới thêm
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
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
                  controller: _bankitController,
                  enableInteractiveSelection: false, // tắt viết chữ, mới thêm
                  focusNode: new AlwaysDisabledFocusNode(), //mới thêm
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ngân Hàng',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.delete,
          color: Colors.orange,
        ),
        onPressed: () {
          // widget.inters!.passwordbanking = _passitController.text;
          // widget.inters!.usernamebanking = int.parse(_nameitController.text);

          interOperations.deleteInter(widget.inters!);
          Navigator.of(context).pushReplacementNamed('/homePage');
        },
      ),
    );
  }

  void dispose() {
    _nameitController.dispose();
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
