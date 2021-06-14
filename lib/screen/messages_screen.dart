import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../util/dummy.dart';
import '../widgets/flex_appbar.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, innerBoxIsScrolled) => [
          FlexAppBar(title: 'Messages'),
        ],
        body: ListView.separated(
          itemBuilder: (_, i) => ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(300),
              child: Image.network(
                  'https://dummyimage.com/64/43a047/fff.png&text=${messages[i].sender.substring(0, 1)}'),
            ),
            title: Text(messages[i].message),
            subtitle: Text(messages[i].sender),
            trailing: Text(
              DateFormat('d MMM yyyy\nH:mm').format(messages[i].sentBy),
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
          ),
          separatorBuilder: (_, i) => Divider(),
          itemCount: 6,
        ),
      ),
    );
  }
}
