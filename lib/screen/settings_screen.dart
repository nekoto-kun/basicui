import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

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
        body: ListView(
          children: [
            ListTile(
              leading: Icon(FeatherIcons.user),
              title: Text('Account settings'),
            ),
            ListTile(
              leading: Icon(FeatherIcons.bell),
              title: Text('Notification settings'),
            ),
            ListTile(
              leading: Icon(FeatherIcons.fileText),
              title: Text('Terms of Use'),
            ),
            ListTile(
              leading: Icon(FeatherIcons.shield),
              title: Text('Privacy Policy'),
            ),
            ListTile(
              leading: Icon(FeatherIcons.logOut),
              title: Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
