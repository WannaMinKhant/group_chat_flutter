import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_chat_flutter/screens/home_screen.dart';
import 'package:uuid/uuid.dart';

class CreateGroup extends StatefulWidget {
  final List<Map<String, dynamic>> memberList;

  const CreateGroup({Key? key, required this.memberList}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  TextEditingController groupName = TextEditingController();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  bool isLoading = false;

  void createGroup() async {
    setState(() {
      isLoading = true;
    });
    String groupId = const Uuid().v1();
    await fireStore.collection("groups").doc('groupId').set({
      "members": widget.memberList,
      "id": groupId,
    });

    for (int i = 0; i < widget.memberList.length; i++) {
      String uid = widget.memberList[i]['uid'];

      await fireStore
          .collection('user')
          .doc(uid)
          .collection('groups')
          .doc(groupId)
          .set({
        "name": groupName.text,
        "id": groupId,
      });
    }
    setState(() {
      isLoading = false;
      print("Group Created");
    });
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Group Name"),
      ),
      body: isLoading
          ? Container(
              height: size.height,
              width: size.width,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
          : Column(
              children: [
                SizedBox(
                  height: size.height / 10,
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
                        controller: groupName,
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
                  onPressed: createGroup,
                  child: const Text("Create Group"),
                ),
              ],
            ),
    );
  }
}
