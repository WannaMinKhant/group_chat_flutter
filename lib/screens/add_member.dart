import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_chat_flutter/screens/group_create_screen.dart';

class AddMember extends StatefulWidget {
  const AddMember({Key? key}) : super(key: key);

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  List<Map<String, dynamic>> memberList = [];
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  Map<String, dynamic> userMap = {};
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUserDetails();
  }

  void getCurrentUserDetails() async {
    await fireStore
        .collection('user')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((map) {
      setState(() {
        memberList.add({
          "name": map["name"],
          "email": map['email'],
          "uid": map["uid"],
          "isAdmin": true,
        });
      });
    });
  }

  void onResultTap(){

    bool isAlreadyExist = false;

    for(int i =0; i < memberList.length; i++){
      if(memberList[i]['udi'] == userMap['uid']){
        isAlreadyExist = true;
      }
    }

    if(!isAlreadyExist){
      setState(() {
        memberList.add({
          "name" : userMap['name'],
          "email" : userMap['email'],
          "uid" : userMap['uid'],
          "isAdmin" : false,
        });
      });
    }

    userMap = {};
  }

  void onRemoveMember(int index){

    if(memberList[index]['uid'] != _auth.currentUser!.uid){
      setState(() {
        memberList.removeAt(index);
      });
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
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Member"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: memberList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => onRemoveMember(index),
                    leading: const Icon(Icons.account_circle),
                    title: Text(memberList[index]['name']),
                    subtitle: Text(memberList[index]['email']),
                    trailing: const Icon(Icons.close),
                  );
                },
              ),
            ),
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
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height / 30,
            ),
            isLoading
                ? Container(
                    height: size.height / 12,
                    width: size.width / 12,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    onPressed: onSearch,
                    child: const Text("Search"),
                  ),
            if (userMap.isNotEmpty)
              ListTile(
                onTap: onResultTap,
                leading: const Icon(
                  Icons.account_box,
                  size: 45,
                ),
                title: Text(userMap['name']),
                subtitle: Text(userMap['email']),
                trailing: const Icon(Icons.add_circle,size: 35,color: Colors.green,),
              )
            else
              const SizedBox(),
          ],
        ),
      ),
      floatingActionButton: memberList.length >= 2 ? FloatingActionButton(
        child: const Icon(Icons.forward),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => CreateGroup(memberList: memberList,))),
      ) : const  SizedBox(),
    );
  }
}
