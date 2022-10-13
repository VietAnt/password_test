import 'package:flutter/material.dart';
import 'package:password_id/data/contact_operations.dart';
import 'package:password_id/models/contact.dart';
import 'package:password_id/presentation/widgets/contact_list.dart';

class SearchPage extends StatefulWidget {
  SearchPage({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ContactOperations contactOperations = ContactOperations();
  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tìm Kiếm Thẻ'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'keyword'),
                  onChanged: (value) {
                    keyword = value;
                    setState(() {});
                  },
                ),
              ),
              FutureBuilder(
                future: contactOperations.searchContacts(keyword),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print('error');
                  var data = snapshot.data;
                  return snapshot.hasData
                      ? ContactsList(data as List<Contact>)
                      : new Center(
                          child: Text('No contacts that include this keyword'),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
