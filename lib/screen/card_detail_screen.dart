import 'package:auto_size_text/auto_size_text.dart';
import 'package:basicui/model/card.dart';
import 'package:basicui/widgets/nav_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CardDetailScreen extends StatefulWidget {
  final BankCard card;
  const CardDetailScreen({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  _CardDetailScreenState createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 84,
        title: Text(
          '${widget.card.name}',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: NavigationButton(
          displayShadow: true,
          child: Icon(FeatherIcons.arrowLeft),
          color: Theme.of(context).scaffoldBackgroundColor,
          margin: EdgeInsets.all(16),
        ),
        leadingWidth: 84,
        actions: [
          SizedBox(
            width: 84,
            child: NavigationButton(
              displayShadow: true,
              child: Icon(FeatherIcons.settings),
              color: Theme.of(context).scaffoldBackgroundColor,
              margin: EdgeInsets.all(16),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [],
        ),
      ),
    );
  }
}
