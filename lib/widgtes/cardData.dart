import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CardData extends StatelessWidget {
  final Map<String, dynamic> userData;

  const CardData({super.key, required this.userData});

  @override
  @override
  Widget build(BuildContext context) {
    String email = userData['email'] ?? 'Sem e-mail';
    // String email = userData['senha'] ?? 'Sem e-mail';

    print(userData); // Veja a estrutura dos dados recebidos

    Timestamp? createdAt = userData['createdAt'];
    String formattedDate =
        createdAt != null
            ? DateFormat('dd/MM/yyyy HH:mm').format(createdAt.toDate())
            : 'Data desconhecida';
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: MouseRegion(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueGrey[200],
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      formattedDate,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
