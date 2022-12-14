import 'package:flutter/material.dart';
import 'package:password_id/data/contact_operations.dart';
import 'package:password_id/data/inter_operations.dart';
import 'package:password_id/main.dart';
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
        title: const Text('Manager Smart '),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                var route =
                    MaterialPageRoute(builder: (context) => MyHomePage());
                Navigator.pushReplacement(context, route);
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          edgeOffset: 20,
          displacement: 200,
          strokeWidth: 5,
          onRefresh: () async {
            var route = MaterialPageRoute(builder: (context) => ContactsPage());
            Navigator.pushReplacement(context, route);
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
                        'Th???(Card)',
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
                                  child: Text('Vui l??ng th??m th??? v??o'));
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'e-Banking',
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
                              : Center(child: Text('Vui l??ng th??m e-Banking'));
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
