import 'package:basicui/widgets/flex_appbar.dart';
import 'package:flutter/material.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, innerBoxIsScrolled) => [
          FlexAppBar(title: 'Transfers'),
        ],
        body: Center(
          child: Text("Sample Text"),
        ),
      ),
    );
  }
}
