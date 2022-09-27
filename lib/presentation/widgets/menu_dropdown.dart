import 'package:flutter/material.dart';
import 'package:password_id/models/menu_bank.dart';

class MenuDropDown extends StatefulWidget {
  List<MenuBanking>? menus;

  Function(MenuBanking) callback;

  MenuDropDown(
    this.menus,
    this.callback, {
    Key? key,
  }) : super(key: key);

  @override
  _MenuDropDownState createState() => _MenuDropDownState();
}

class _MenuDropDownState extends State<MenuDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 215, 209, 209)),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<MenuBanking>(
            hint: const Text('Chọn Loại Thẻ'),
            onChanged: (value) {
              setState(() {
                widget.callback(value!);
              });
            },
            items: widget.menus!.map((menu) {
              return DropdownMenuItem(
                  value: menu,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(menu.name),
                  ));
            }).toList(),
          ),
        ),
      ),
    );
  }
}
