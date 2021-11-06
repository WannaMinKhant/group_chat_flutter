import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:group_chat_flutter/controller/account.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  Map<String, dynamic> userMap = <String, dynamic>{};
  final TextEditingController _search = TextEditingController();

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    setState(() {
      isLoading = true;
    });
    await _firestore
        .collection('user')
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => logOut(context),
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
                        onTap: () {},
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
    );
  }
}
