import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:money2/money2.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../model/card.dart';
import '../model/writeoff.dart';
import '../screen/home_screen.dart';
import '../util/dummy.dart';
import '../util/misc.dart';
import '../util/money.dart';
import '../widgets/nav_button_widget.dart';

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
          color: Colors.white,
          margin: EdgeInsets.all(24),
        ),
        leadingWidth: 100,
        actions: [
          SizedBox(
            width: 100,
            child: NavigationButton(
              displayShadow: true,
              child: Icon(FeatherIcons.settings),
              color: Colors.white,
              margin: EdgeInsets.all(24),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 90,
        padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
        child: ElevatedButton(
          child: AutoSizeText(
            'Operation History',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            maxFontSize: 18,
            minFontSize: 6,
            maxLines: 1,
          ),
          style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith<double>(
              (_) => 0,
            ),
            shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
              (_) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          onPressed: () => print('Ehe'),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Details and Card
            Container(
              height: 256,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  _cardDetails(),
                  if (MediaQuery.of(context).orientation ==
                          Orientation.landscape ||
                      MediaQuery.of(context).size.width > 480)
                    _landscapeButtons(),
                  _cardImage(),
                ],
              ),
            ),
            if (MediaQuery.of(context).orientation == Orientation.portrait ||
                MediaQuery.of(context).size.width <= 480)
              _buttons(),
            // Write-offs
            HomeContainer(
              title: 'Next write-offs',
              child: SizedBox(
                height: 256,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  children: dummyWriteOffs
                      .map((wo) => WriteOffWidget(data: wo))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttons() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CardButton(
              icon: Icon(FeatherIcons.lock),
              text: 'Block',
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: CardButton(
              icon: Icon(FeatherIcons.arrowUpCircle),
              text: 'Pay',
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: CardButton(
              icon: Icon(FeatherIcons.plusCircle),
              text: 'Top Up',
            ),
          ),
        ],
      ),
    );
  }

  Widget _landscapeButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CardButton(
              icon: Icon(FeatherIcons.lock, size: 18),
              text: 'Block',
              padding: EdgeInsets.all(16),
              radius: BorderRadius.circular(16),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: CardButton(
              icon: Icon(FeatherIcons.arrowUpCircle, size: 18),
              text: 'Pay',
              padding: EdgeInsets.all(16),
              radius: BorderRadius.circular(16),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: CardButton(
              icon: Icon(FeatherIcons.plusCircle, size: 18),
              text: 'Top Up',
              padding: EdgeInsets.all(16),
              radius: BorderRadius.circular(16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardImage() {
    return Flexible(
      flex: MediaQuery.of(context).orientation == Orientation.portrait ||
              MediaQuery.of(context).size.width <= 480
          ? 2
          : 1,
      child: Builder(
        builder: (_) {
          String? _imagePath = cardLogoPath('${widget.card.type}');
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
                          style: cardTextStyle('${widget.card.color}')
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
    );
  }

  Widget _cardDetails() {
    return Expanded(
      flex: 6,
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
            SizedBox(height: 16),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    'For the current billing period, you will earn ${Money.fromInt(widget.card.balance * 5 ~/ 1000, idr)} cashback!',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 14,
                    ),
                    maxFontSize: 14,
                    minFontSize: 8,
                    maxLines: 2,
                  ),
                  SizedBox(height: 8),
                  Row(
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
                ],
              ),
            ),
            Spacer(),
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
  final EdgeInsetsGeometry padding;
  final BorderRadius? radius;

  const CardButton({
    Key? key,
    required this.icon,
    required this.text,
    this.color = const Color(0x0C000000),
    this.padding = const EdgeInsets.all(24),
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: radius ?? BorderRadius.circular(24),
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
              style: TextStyle(fontWeight: FontWeight.w500),
              maxFontSize: 16,
              minFontSize: 4,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class WriteOffWidget extends StatelessWidget {
  final WriteOff data;

  const WriteOffWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: EdgeInsets.fromLTRB(0, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8),
        ],
        color: Colors.white,
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Image(
                    image: AssetImage('assets/icons/${data.assetIcon}'),
                    height: 60,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: AutoSizeText(
                            '${Money.fromInt(data.amount, idr)}',
                            style: Theme.of(context).textTheme.subtitle2,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: AutoSizeText(
                            '${data.category}',
                            style: Theme.of(context).textTheme.caption,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                '${data.name}',
                style: TextStyle(fontWeight: FontWeight.bold),
                maxFontSize: 18,
                minFontSize: 8,
                maxLines: 1,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: LayoutBuilder(
                    builder: (_, parent) => CircularPercentIndicator(
                      radius: parent.maxWidth,
                      lineWidth: 8,
                      percent: data.daysBeforeCancel / data.maxDays,
                      animation: true,
                      animationDuration: 3000,
                      curve: Curves.easeOutCubic,
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Color(0xFF2E2A2A),
                      center: Container(
                        height: parent.maxHeight - 36,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Center(
                                child: AutoSizeText(
                                  '${data.daysBeforeCancel}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFeatures: [
                                      FontFeature.tabularFigures()
                                    ],
                                  ),
                                  maxFontSize: 16,
                                  minFontSize: 8,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 3,
                  child: AutoSizeText(
                    'Days before cancellation',
                    maxFontSize: 16,
                    minFontSize: 8,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
