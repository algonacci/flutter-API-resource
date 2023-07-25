import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_resource/models/user_model.dart';

class FetchingPage extends StatefulWidget {
  const FetchingPage({super.key});

  @override
  State<FetchingPage> createState() => _FetchingPageState();
}

class _FetchingPageState extends State<FetchingPage> {
  late final Future<List<User>> _userList;

  @override
  void initState() {
    super.initState();
    _userList = _getUser();
  }

  Future<List<User>> _getUser() async {
    try {
      var response = await Dio().get('http://127.0.0.1:8000/api/users');
      List<User> userList = [];
      if (response.statusCode == 200) {
        debugPrint(response.data.toString());
        userList = (response.data['data'] as List)
            .map((e) => User.fromJson(e))
            .toList();
      }
      return userList;
    } on DioException catch (e) {
      Future.error(e.message.toString());
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
      body: FutureBuilder<List<User>>(
        future: _userList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userList = snapshot.data!;
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                var user = userList[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  leading: CircleAvatar(
                    child: Text(
                      user.id.toString(),
                    ),
                  ),
                );
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
    );
  }
}
