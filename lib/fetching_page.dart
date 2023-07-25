import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_resource/models/user_model.dart';

class FetchingPage extends StatefulWidget {
  const FetchingPage({Key? key}) : super(key: key);

  @override
  State<FetchingPage> createState() => _FetchingPageState();
}

class _FetchingPageState extends State<FetchingPage> {
  late Future<List<User>> _userList;
  final searchController = TextEditingController();
  String filter = "";

  @override
  void initState() {
    super.initState();
    _userList = _getUser();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
  }

  Future<List<User>> _getUser() async {
    try {
      var response = await Dio().get('http://127.0.0.1:8000/api/users');
      List<User> userList = [];
      if (response.statusCode == 200) {
        userList = (response.data['data'] as List)
            .map((e) => User.fromJson(e))
            .toList();
      }
      return userList;
    } on DioException catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Remote API',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                labelStyle: const TextStyle(color: Colors.blue),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<User>>(
              future: _userList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var userList = snapshot.data!;
                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      var user = userList[index];
                      return user.name
                              .toLowerCase()
                              .contains(filter.toLowerCase())
                          ? ListTile(
                              title: Text(user.name),
                              subtitle: Text(user.email),
                              leading: CircleAvatar(
                                child: Text(
                                  user.id.toString(),
                                ),
                              ),
                            )
                          : Container();
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
