import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff17192D),
        actions: [
          Expanded(
            child: IconButton(
              icon: Image.asset(
                alignment: Alignment.center,
                'assets/images/logo.png',
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: Column(),
    );
  }
}
