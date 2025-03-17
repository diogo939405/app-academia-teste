import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_academia_teste/widgtes/cardData.dart';
import 'package:app_academia_teste/services/firestore.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreService().getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List userList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot user = userList[index];

                Map<String, dynamic> userData =
                    user.data() as Map<String, dynamic>;

                return CardData(userData: userData);
              },
            );
          } else if (snapshot.hasLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text('Não há usuários cadastrados.'));
          }
        },
      ),
    );
  }
}

extension on AsyncSnapshot<QuerySnapshot<Object?>> {
  bool get hasLoading =>
      null != connectionState && connectionState == ConnectionState.waiting;
}
