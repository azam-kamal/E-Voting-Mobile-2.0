import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  getIP() async {
    print("DB Methods!!");
    return Firestore.instance.collection("server").document("server1").get();
  }
  // Future<void> addUserInfo(userData) async {
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser.uid)
  //       .set(userData)
  //       .catchError((e) {
  //     print(e.toString());
  //   });
  // }

  // Future<void> addNumber(num) async {
  //   print('uid below');
  //   print(FirebaseAuth.instance.currentUser.uid);
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser.uid)
  //       .update(num)
  //       .catchError((e) {
  //     print(e.toString());
  //   });
  // }

  // getUserInfo(String email) async {
  //   return FirebaseFirestore.instance
  //       .collection("users")
  //       .where("email", isEqualTo: email)
  //       .get()
  //       .catchError((e) {
  //     print(e.toString());
  //   });
  // }

  // getAllUser() async {
  //   return FirebaseFirestore.instance.collection("users").get().catchError((e) {
  //     print(e.toString());
  //   });
  // }

  // searchByName(String searchField) {
  //   return FirebaseFirestore.instance
  //       .collection("users")
  //       .where('userName', isEqualTo: searchField)
  //       .get();
  // }

  // addChatRoom(chatRoom, chatRoomId) {
  //   FirebaseFirestore.instance
  //       .collection("chatRoom")
  //       .doc(chatRoomId)
  //       .set(chatRoom)
  //       .catchError((e) {
  //     print(e);
  //   });
  // }

  // getChats(String chatRoomId) async {
  //   return FirebaseFirestore.instance
  //       .collection("chatRoom")
  //       .doc(chatRoomId)
  //       .collection("chats")
  //       .orderBy('time')
  //       .snapshots();
  // }

  // getStatus(String userName) async {
  //   return FirebaseFirestore.instance
  //       .collection("users")
  //       .where('userName', isEqualTo: userName)
  //       .snapshots();
  //   // .snapshots();
  // }

  // addMessage(String chatRoomId, chatMessageData) {
  //   FirebaseFirestore.instance
  //       .collection("chatRoom")
  //       .doc(chatRoomId)
  //       .collection("chats")
  //       .add(chatMessageData)
  //       .catchError((e) {
  //     print(e.toString());
  //   });
  // }

  // getUserChats(String itIsMyName) async {
  //   return FirebaseFirestore.instance
  //       .collection("chatRoom")
  //       .where('users', arrayContains: itIsMyName)
  //       .snapshots();
  // }

}
