import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_id/data/inter_operations.dart';
import 'package:password_id/models/interbanking.dart';
import 'package:password_id/presentation/pages/contacts_page.dart';

class EditInterPage extends StatefulWidget {
  InterBanking? inters;

  EditInterPage({Key? key, this.inters})
      : super(
          key: key,
        );

  @override
  _EditInterPageState createState() => _EditInterPageState();
}

class _EditInterPageState extends State<EditInterPage> {
  InterOperations interOperations = InterOperations();

  var _nameitController = TextEditingController();
  var _passitController = TextEditingController();
  var _bankController = TextEditingController();

  bool isHiddenPass = true;

  @override
  Widget build(BuildContext context) {
    _nameitController.text = widget.inters!.usernamebanking.toString();
    _passitController.text = widget.inters!.passwordbanking.toString();
    _bankController.text = widget.inters!.category.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh Sửa E-Banking'),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/homePage');
          },
          child: const Icon(
            Icons.arrow_back, // add custom icons also
          ),
        ),
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
                  controller: _nameitController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Số thẻ',
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _passitController,
                  obscureText: isHiddenPass,
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
                  controller: _bankController,
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
        child: const Icon(Icons.edit),
        onPressed: () {
          widget.inters!.passwordbanking = _passitController.text;
          widget.inters!.usernamebanking = int.parse(_nameitController.text);

          interOperations.updateInter(widget.inters!);
          var route = MaterialPageRoute(builder: ((context) => ContactsPage()));
          Navigator.pushReplacement(context, route);
          // Navigator.of(context).pushReplacementNamed('/homePage');
        },
      ),
    );
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
