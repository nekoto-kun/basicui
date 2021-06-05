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
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 64),
        child: Container(
          margin: EdgeInsets.only(top: 36),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              NavigationButton(
                child: Icon(FeatherIcons.arrowLeft),
                color: Theme.of(context).scaffoldBackgroundColor,
                displayShadow: true,
              ),
              Expanded(
                child: Center(
                  child: AutoSizeText(
                    '${widget.card.name}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                    maxFontSize: 18,
                    minFontSize: 12,
                    maxLines: 1,
                  ),
                ),
              ),
              NavigationButton(
                child: Icon(FeatherIcons.settings),
                color: Theme.of(context).scaffoldBackgroundColor,
                displayShadow: true,
              ),
            ],
          ),
        ),
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
