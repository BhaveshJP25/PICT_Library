import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  // collection reference
  final CollectionReference bookCollection = Firestore.instance.collection('Books');



}