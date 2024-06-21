import 'package:chatapp/components/myTextField.dart';
import 'package:chatapp/services/auth/auth_Service.dart';
import 'package:chatapp/services/chat/chatService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverId;
  ChatPage({super.key, required this.receiverEmail, required this.receiverId});

  //instance of authservice and chatservice
  AuthService auth = AuthService();
  Chatservice chat = Chatservice();

  TextEditingController inputController = TextEditingController();

  //send message
  void sendMessage() async {
    if (inputController.text.isNotEmpty) {
      await chat.sendMessage(receiverId, inputController.text);

      inputController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildInputItem(),
        ],
      ),
    );
  }

  //buildMessagelist
  Widget _buildMessageList() {
    String senderId = auth.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: chat.getMessage(receiverId, senderId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  //buildMessageItem
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    //is current user
    bool isCurrentUser = data['senderId'] == auth.getCurrentUser()!.uid;

    //alignment the message
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        alignment: alignment,
        child: Text(data['message']));
  }

  //_buildInputItem

  Widget _buildInputItem() {
    return Row(
      children: [
        Expanded(
          child: Mytextfield(
              controller: inputController,
              hintText: "Message",
              obsecure: false),
        ),
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }
}
