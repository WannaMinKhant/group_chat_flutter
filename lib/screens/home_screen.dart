import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_chat_flutter/controller/account.dart';
import 'package:group_chat_flutter/screens/chat_room.dart';
import 'package:group_chat_flutter/screens/group_chats_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool isLoading = false;
  Map<String, dynamic> userMap = <String, dynamic>{};
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    setStatus("Online");
    print("Online");
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  late AppLifecycleState _notification;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
    });
    if (_notification == AppLifecycleState.resumed) {
      setStatus("Online");
      print("Online");
    } else {
      setStatus("Offline");
      print("Offline");
    }
  }

  void setStatus(String status) async {
    await fireStore.collection('user').doc(_auth.currentUser!.uid).update({
      "status": status,
    });
  }

  String chatRoomId(String user1, String user2) {
    print(user1);
    print(user2);
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    setState(() {
      isLoading = true;
    });
    await fireStore
        .collection('user')
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      // print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setStatus("Offline");
              logOut(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: SizedBox(
                height: size.height / 20,
                width: size.width / 10,
                child: const CircularProgressIndicator(),
              ),
            )
          : Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height / 20,
                ),
                SizedBox(
                  height: size.height / 14,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SizedBox(
                      height: size.height / 14,
                      width: size.width / 1.5,
                      child: TextField(
                        controller: _search,
                        decoration: const InputDecoration(
                            hintText: "Search",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                ElevatedButton(
                  onPressed: onSearch,
                  child: const Text("Search"),
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                userMap.isNotEmpty
                    ? ListTile(
                        onTap: () {
                          String roomId = chatRoomId(
                              _auth.currentUser!.displayName.toString(),
                              userMap['name']);
                          print(userMap['name']);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ChatRoom(
                                    chatRoomId: roomId,
                                    userMap: userMap,
                                  )));
                        },
                        leading: const Icon(
                          Icons.person,
                          size: 45,
                          color: Colors.pink,
                        ),
                        title: Text(
                          userMap['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(userMap['email']),
                        trailing: const Icon(
                          Icons.chat,
                          color: Colors.blueGrey,
                        ),
                      )
                    : Container(),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.group),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => GroupChatScreen()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
