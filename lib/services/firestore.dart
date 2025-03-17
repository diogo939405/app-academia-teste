import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _auth = FirebaseAuth.instance;
  final CollectionReference users = FirebaseFirestore.instance.collection(
    'users',
  );

  // Função para criptografar a senha
  // String hashPassword(String password) {
  //   var bytes = utf8.encode(password);
  //   return sha256.convert(bytes).toString();
  // }

  // Adicionar usuário com email normal e senha criptografada
  Future<void> addUser(String email, String senha) async {
    // String senhaHash = hashPassword(senha);

    try {
      await users.add({
        'email': email, // Email armazenado normalmente (não criptografado)
        'senha': senha, // Senha criptografada
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      print("Erro ao adicionar usuário no Firestore: $e");
    }
  }
  //   try {
  //     await users.add({
  //       'email': senha, // Email armazenado normalmente (não criptografado)
  //       'senha': email, // Senha criptografada
  //       'createdAt': Timestamp.now(),
  //     });
  //   } catch (e) {
  //     print("Erro ao adicionar usuário no Firestore: $e");
  //   }
  // }

  

  // Pegar todos os usuários, ordenados pela data de criação
  Stream<QuerySnapshot> getUsers() {
    return users.orderBy('createdAt', descending: true).snapshots();
  }

  // Atualizar um usuário
  Future<void> updateUser(String newEmail, String id) async {
    try {
      await users.doc(id).update({
        'email': newEmail, // Atualiza o email
        'updatedAt': Timestamp.now(),
      });
    } catch (e) {
      print("Erro ao atualizar o usuário: $e");
    }
  }

  // Criar usuário no Firebase Authentication com email e senha
  Future<User?> createUserWithEmailAndPassword(
    String email,
    String senha,
  ) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      return cred.user;
    } on FirebaseAuthException catch (e) {
      print("Erro ao criar usuário no Firebase: ${e.message}");
      return null;
    }
  }

  // Logout
  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Erro ao sair: $e");
    }
  }
}
