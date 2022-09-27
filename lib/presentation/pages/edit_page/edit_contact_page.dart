import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:password_id/data/contact_operations.dart';
import 'package:password_id/models/contact.dart';

class EditContactPage extends StatefulWidget {
  Contact? contact;

  EditContactPage({Key? key, this.contact})
      : super(
          key: key,
        );

  @override
  _EditContactPageState createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  ContactOperations contactOperations = ContactOperations();

  var _nameController = TextEditingController();
  var _numberController = TextEditingController();
  var _dateController = TextEditingController();
  var _passwordController = TextEditingController();
  var _nametypeController = TextEditingController();

  bool isHiddenPass = true;

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.contact!.name!;
    _numberController.text = widget.contact!.number.toString();
    _dateController.text = widget.contact!.date!;
    _passwordController.text = widget.contact!.password.toString();
    _nametypeController.text = widget.contact!.nametype!.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh Sửa Thẻ'),
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _numberController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Số thẻ',
                  ),
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _passwordController,
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
                  controller: _nametypeController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'NameType'),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          widget.contact?.name = _nameController.text;
          widget.contact?.number = int.parse(_passwordController.text);
          widget.contact?.date = _dateController.text;
          widget.contact?.password = int.parse(_passwordController.text);
          widget.contact?.nametype = _nametypeController.text;
          //update
          contactOperations.updateContact(widget.contact!);
          //home
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
