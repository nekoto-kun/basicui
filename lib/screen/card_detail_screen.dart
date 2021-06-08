import 'package:auto_size_text/auto_size_text.dart';
import 'package:basicui/model/card.dart';
import 'package:basicui/screen/home_screen.dart';
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
        toolbarHeight: 100,
        title: Text(
          '${widget.card.name}',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: NavigationButton(
          displayShadow: true,
          child: Icon(FeatherIcons.arrowLeft),
          color: Theme.of(context).scaffoldBackgroundColor,
          margin: EdgeInsets.all(24),
        ),
        leadingWidth: 100,
        actions: [
          SizedBox(
            width: 100,
            child: NavigationButton(
              displayShadow: true,
              child: Icon(FeatherIcons.settings),
              color: Theme.of(context).scaffoldBackgroundColor,
              margin: EdgeInsets.all(24),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Details and Card
            Container(
              height: MediaQuery.of(context).size.height / 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  // Details
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Spacer(),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: AutoSizeText(
                                '${widget.card.name}',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxFontSize: 24,
                                minFontSize: 18,
                                maxLines: 1,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: AutoSizeText(
                              '${Money.fromInt(widget.card.balance, idr)}',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 36,
                              ),
                              maxFontSize: 36,
                              minFontSize: 24,
                              maxLines: 1,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 2,
                            child: AutoSizeText(
                              'For the current billing period, you will earn ${Money.fromInt(widget.card.balance * 5 ~/ 1000, idr)} cashback!',
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 14,
                              ),
                              maxFontSize: 14,
                              minFontSize: 8,
                              maxLines: 2,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  FeatherIcons.arrowUpCircle,
                                  color: Colors.greenAccent[400],
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: AutoSizeText(
                                    '${Money.fromInt(widget.card.balance * 5 ~/ 1000, idr)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                  // Card
                  Flexible(
                    child: Builder(
                      builder: (_) {
                        String? _imagePath =
                            cardLogoPath('${widget.card.type}');
                        return Container(
                          height: 256,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              bottomLeft: Radius.circular(24),
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
                              Spacer(flex: 4),
                              Flexible(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: AutoSizeText(
                                        '${widget.card.cardNumber.substring(widget.card.cardNumber.length - 9).replaceRange(0, 4, '****')}',
                                        style: cardTextStyle(
                                                '${widget.card.color}')
                                            .copyWith(fontFamily: 'Fira Code'),
                                        maxFontSize: 16,
                                        minFontSize: 6,
                                        maxLines: 1,
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
            Padding(
              padding: const EdgeInsets.all(24),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  childAspectRatio: 6 / 5,
                ),
                shrinkWrap: true,
                children: [
                  CardButton(
                    icon: Icon(FeatherIcons.lock),
                    text: 'Block',
                  ),
                  CardButton(
                    icon: Icon(FeatherIcons.arrowUpCircle),
                    text: 'Pay',
                  ),
                  CardButton(
                    icon: Icon(FeatherIcons.plusCircle),
                    text: 'Top Up',
                  ),
                ],
              ),
            ),
            HomeContainer(
              title: 'Next write-offs',
              child: Text('Horizontal view here'),
            ),
          ],
        ),
      ),
    );
  }
}

class CardButton extends StatelessWidget {
  final Icon icon;
  final String text;
  final Color color;

  const CardButton({
    Key? key,
    required this.icon,
    required this.text,
    this.color = const Color(0x0C000000),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: color,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          AutoSizeText(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
