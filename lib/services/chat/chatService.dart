import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chatservice {
  //get instance of the firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get the list of users
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //go through each individual user
        final user = doc.data();
        //return user
        return user;
      }).toList();
    });
  }

  //send the message

  Future<void> sendMessage(String receiverId, String message) async {
    //get current user info.
    final String currentUserId = _auth.currentUser!.uid;
    final String currentEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create new message
    Message newMessage = Message(
      receiverId: receiverId,
      senderId: currentUserId,
      senderEmail: currentEmail,
      message: message,
      timestamp: timestamp,
    );

    //construct chat_room id for two users
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatroomId = ids.join("_");

    //add new message to databse
    await _firestore
        .collection("chat_rooms")
        .doc(chatroomId)
        .collection('messages')
        .add(newMessage.tomap());
  }

  //get the message
  Stream<QuerySnapshot> getMessage(String receiverId, String senderId) {
    List<String> id = [senderId, receiverId];
    id.sort();
    String chatroomId = id.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatroomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
