import 'package:chatapp/components/myTextField.dart';
import 'package:chatapp/services/auth/auth_Service.dart';
import 'package:chatapp/services/chat/chatService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverId;
  ChatPage({super.key, required this.receiverEmail, required this.receiverId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //instance of authservice and chatservice
  AuthService auth = AuthService();

  Chatservice chat = Chatservice();

  TextEditingController inputController = TextEditingController();

  //for TextField focus
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //add focusNode to the Textfield
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(
          const Duration(microseconds: 500),
          () => scrollDown(),
        );
      }
    });

    //when first page is shown up it should scroll down to the latest message

    Future.delayed(
      const Duration(seconds: 1),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
    inputController.dispose();
  }

  //scrollController
  final ScrollController scrollController = ScrollController();
  void scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  //send message
  void sendMessage() async {
    if (inputController.text.isNotEmpty) {
      await chat.sendMessage(widget.receiverId, inputController.text);

      inputController.clear();

      scrollDown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
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
        stream: chat.getMessage(widget.receiverId, senderId),
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
            controller: scrollController,
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

    var textColor =
        isCurrentUser ? const Color.fromARGB(255, 171, 80, 187) : Colors.blue;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          alignment: alignment,
          child: Text(
            data['message'],
            style: TextStyle(color: textColor, fontSize: 14),
          )),
    );
  }

  //_buildInputItem
  Widget _buildInputItem() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Mytextfield(
                controller: inputController,
                hintText: "Message",
                obsecure: false),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.send,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
