import 'package:flutter/material.dart';
import 'package:password_id/data/inter_operations.dart';
import 'package:password_id/models/interbanking.dart';
import 'package:password_id/presentation/widgets/intern_list.dart';

class SearchBankingPage extends StatefulWidget {
  SearchBankingPage({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _SearchBankingPageState createState() => _SearchBankingPageState();
}

class _SearchBankingPageState extends State<SearchBankingPage> {
  InterOperations interOperations = InterOperations();
  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm Kiếm e-Banking'),
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
                future: interOperations.searchInters(keyword),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print('error');
                  var data = snapshot.data;
                  return snapshot.hasData
                      ? InterList(data as List<InterBanking>)
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
