import 'package:chatapp/Screen/ChatPage.dart';
import 'package:chatapp/components/usertile.dart';
import 'package:chatapp/services/auth/auth_Service.dart';
import 'package:chatapp/components/myDrawer.dart';
import 'package:chatapp/services/chat/chatService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});
  AuthService auth = AuthService();
  Chatservice chat = Chatservice();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      drawer: Mydrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: chat.getUserStream(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return Text("Error");
          }
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          //data loaded
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  //build individual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display all user except current user
    if (userData["email"] != auth.getCurrentUser()?.email) {
      return Usertile(
        text: userData["email"],
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ChatPage(
                receiverEmail: userData['email'],
                receiverId: userData['uid'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
