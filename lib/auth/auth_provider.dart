import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class AuthProvider extends ChangeNotifier {
  User? user;
  bool get isAuthenticated => user != null;

  Future<void> checkAuth() async {
    user = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    user = credential.user;
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    user = credential.user;
    notifyListeners();
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    user = null;
    notifyListeners();
  }

  Future<void> updateProfile({required String name, required String email, String? imageUrl}) async {
    if (user == null) return;
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
    }, SetOptions(merge: true));
    notifyListeners();
  }

  Future<String> uploadProfileImage(File file) async {
    if (user == null) throw Exception('Not logged in');
    final ref = FirebaseStorage.instance.ref().child('profile_images').child('${user!.uid}.jpg');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
} 