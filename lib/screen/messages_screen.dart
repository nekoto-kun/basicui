import 'package:basicui/widgets/flex_appbar.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, innerBoxIsScrolled) => [
          FlexAppBar(title: 'Messages'),
        ],
        body: Center(
          child: Text("Sample Text"),
        ),
      ),
    );
  }
}
