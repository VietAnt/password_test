import 'package:flutter/material.dart';
import 'package:password_id/data/contact_operations.dart';
import 'package:password_id/data/inter_operations.dart';
import 'package:password_id/models/contact.dart';
import 'package:password_id/models/interbanking.dart';
import 'package:password_id/presentation/widgets/contact_list.dart';
import 'package:password_id/presentation/widgets/horizontal_button_bar.dart';
import 'package:password_id/presentation/widgets/intern_list.dart';

class ContactsPage extends StatefulWidget {
  ContactsPage({Key? key})
      : super(
          key: key,
        );

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  ContactOperations contactOperations = ContactOperations();
  InterOperations interOperations = InterOperations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager Smart V1'),
      ),
      body: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          edgeOffset: 20,
          displacement: 200,
          strokeWidth: 5,
          onRefresh: () async {
            Navigator.of(context).pushReplacementNamed('/homePage');
          },
          color: Colors.teal,
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  HorizontalButtonBar(),
                  Column(
                    children: [
                      const Text(
                        'Thẻ(Card)',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      FutureBuilder(
                        future: contactOperations.getAllContacts(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            print('error');
                          }
                          var data = snapshot.data;
                          return snapshot.hasData
                              ? ContactsList(data as List<Contact>)
                              : new Center(
                                  child: Text('Vui lòng thêm thẻ vào'));
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'e-Banking(SmartBanking) ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      FutureBuilder(
                        future: interOperations.getAllInters(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print('error');
                          var data = snapshot.data;
                          return snapshot.hasData
                              ? InterList(data as List<InterBanking>)
                              : Center(child: Text('Vui lòng thêm e-Banking'));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
