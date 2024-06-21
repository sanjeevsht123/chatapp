import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String receiverId;
  final String senderId;
  final String senderEmail;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.receiverId,
    required this.senderId,
    required this.senderEmail,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> tomap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp
    };
  }
}
