import 'package:flutter/material.dart';
import 'package:group_chat_flutter/screens/group_info_screen.dart';
import 'package:group_chat_flutter/screens/show_image_screen.dart';

class GroupChatRoom extends StatelessWidget {
  GroupChatRoom({Key? key}) : super(key: key);

  final TextEditingController _message = TextEditingController();
  String currentUserName = "User1";
  static const List<Map<String, dynamic>> chatList = [
    {
      "message": "User1 created this Group",
      "type": "notify",
    },
    {
      "message": "Hello",
      "sendBy": "User1",
      "type": "text",
    },
    {
      "message": "Hello",
      "sendBy": "User5",
      "type": "text",
    },
    {
      "message": "Hello",
      "sendBy": "User3",
      "type": "text",
    },
    {
      "message": "Hello",
      "sendBy": "User4",
      "type": "text",
    },
    {
      "message": "Hello",
      "sendBy": "User2",
      "type": "text",
    },
    {
      "message" : "User1 added User8",
      "type" : "notify",
    }
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Name"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const GroupInfo()));
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              height: size.height / 1.27,
              width: size.width,
              child: ListView.builder(
                shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: chatList.length,
                  itemBuilder: (context, index) {
                    return messageTile(size, chatList[index],context);
                  }),
            ),
            Container(
              height: size.height / 10,
              width: size.width,
              alignment: Alignment.center,
              child: SizedBox(
                height: size.height / 12,
                width: size.width / 1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height / 17,
                      width: size.width / 1.3,
                      child: TextField(
                        controller: _message,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              print("get Image");
                            },
                            icon: const Icon(Icons.photo),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: "Type Message...",
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {}, //onSendMessage,
                      icon: const Icon(
                        Icons.send,
                        size: 35,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messageTile(Size size, Map<String, dynamic> chatMap,BuildContext context) {
    return Builder(builder: (_) {
      if (chatMap['type'] == "text") {
        return Container(
          width: size.width,
          alignment: chatMap['sendBy'] == currentUserName
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Text(
                  chatMap['sendBy'],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: size.height / 200,
                ),
                Text(
                  chatMap['message'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (chatMap['type'] == "img") {
        return Container(
          height: size.height / 2.5,
          width: size.width,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          alignment: chatMap["sendBy"] == currentUserName //_auth.currentUser!.displayName
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ShowImage(
                    imageUrl: chatMap['message'],
                  )));
            },
            child: Container(
              height: size.height / 2.5,
              width: size.width / 2,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              alignment: chatMap['message'] != "" ? null : Alignment.center,
              child: chatMap["message"] != ""
                  ? Image.network(
                chatMap['message'],
                fit: BoxFit.cover,
              )
                  : const CircularProgressIndicator(),
            ),
          ),
        );
      } else if (chatMap['type'] == "notify") {
        return Container(
          width: size.width,
          alignment:  Alignment.center,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black38,
            ),
            child: Text(
              chatMap['message'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
