import 'package:auto_size_text/auto_size_text.dart';
import 'package:basicui/model/card.dart';
import 'package:basicui/util/misc.dart';
import 'package:basicui/util/money.dart';
import 'package:basicui/widgets/nav_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:money2/money2.dart';

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
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              '${widget.card.name}',
                            ),
                          ),
                          Expanded(
                            child: AutoSizeText(
                              '${Money.fromInt(widget.card.balance, idr)}',
                              style: TextStyle(fontWeight: FontWeight.w700),
                              maxFontSize: 48,
                              minFontSize: 18,
                              maxLines: 1,
                            ),
                          ),
                          Expanded(
                            child: AutoSizeText(
                              'For the current billing period, you will earn ${Money.fromInt(widget.card.balance * 5 ~/ 1000, idr)} cashback!',
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  FeatherIcons.arrowUpCircle,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: AutoSizeText(
                                    '${Money.fromInt(widget.card.balance * 5 ~/ 1000, idr)}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Builder(
                      builder: (_) {
                        String? _imagePath =
                            cardLogoPath('${widget.card.type}');
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                            color: cardColor('${widget.card.color}'),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_imagePath != null)
                                Image(
                                  image: AssetImage(_imagePath),
                                  height: 60,
                                ),
                              Flexible(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: AutoSizeText(
                                        '${widget.card.cardNumber}',
                                        style: cardTextStyle(
                                                '${widget.card.color}')
                                            .copyWith(fontFamily: 'Fira Code'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
