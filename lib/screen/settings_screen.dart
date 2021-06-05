import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  final ScrollController scrollController;

  const SettingScreen({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Container(
              child: Text('Title'),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (_, i) {
                return ListTile(
                  title: Text('$i'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
