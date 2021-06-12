import 'package:flutter/material.dart';

import '../widgets/flex_appbar.dart';

class SettingScreen extends StatelessWidget {
  final ScrollController scrollController;

  const SettingScreen({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, innerBoxIsScrolled) => [
          FlexAppBar(title: 'Settings'),
        ],
        body: Center(
          child: Text("Sample Text"),
        ),
      ),
    );
  }
}
