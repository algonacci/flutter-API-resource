import 'package:flutter/material.dart';
import 'package:flutter_api_resource/button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Capstone"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/fetching");
                },
                child: const Button(
                  text: "API",
                  icon: Icons.computer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
