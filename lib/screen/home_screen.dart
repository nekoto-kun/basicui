import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:money2/money2.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'settings_screen.dart';
import 'messages_screen.dart';
import 'transfers_screen.dart';

import '../util/colors.dart';
import '../util/dummy.dart';
import '../util/money.dart';
import '../widgets/card_carousel_widget.dart';
import '../widgets/nav_button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeContent(scrollController: _scrollController),
          TransferScreen(),
          MessageScreen(),
          SettingScreen(scrollController: _scrollController),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _tabController.index,
        onTap: (i) => setState(() => _tabController.animateTo(i)),
        selectedItemColor: Color(0xFF2E2A2A),
        unselectedItemColor: Colors.black38,
        margin: const EdgeInsets.all(16),
        items: [
          SalomonBottomBarItem(
            icon: Icon(FeatherIcons.home),
            title: Text(
              'Home',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            selectedColor: Colors.amber,
          ),
          SalomonBottomBarItem(
            icon: Icon(FeatherIcons.send),
            title: Text(
              'Transfers',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            selectedColor: Colors.blue,
          ),
          SalomonBottomBarItem(
            icon: Icon(FeatherIcons.messageSquare),
            title: Text(
              'Messages',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            selectedColor: Colors.green,
          ),
          SalomonBottomBarItem(
            icon: Icon(FeatherIcons.settings),
            title: Text(
              'Settings',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            selectedColor: Colors.indigo,
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final ScrollController scrollController;

  const HomeContent({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  _header(context),
                  _goal(context),
                  _lastTransactions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      height: 372,
      color: Color(primaryYellow),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 32),
            child: Row(
              children: [
                Expanded(
                  flex: MediaQuery.of(context).orientation ==
                              Orientation.portrait &&
                          MediaQuery.of(context).size.width <= 768
                      ? 5
                      : 11,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AutoSizeText(
                        'Good morning',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        maxFontSize: 18,
                        minFontSize: 8,
                        maxLines: 1,
                      ),
                      SizedBox(height: 4),
                      AutoSizeText(
                        'Andre',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                        ),
                        maxFontSize: 32,
                        minFontSize: 16,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: NavigationButton(
                    color: Color(0xFFFEEDA9),
                    child: Icon(FeatherIcons.user),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: CardCarousel()),
        ],
      ),
    );
  }

  Widget _goal(BuildContext context) {
    return HomeContainer(
      title: 'Current Goal',
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
            ),
          ],
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        height: 128,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                child: LayoutBuilder(
                  builder: (_, parent) => CircularPercentIndicator(
                    radius: parent.maxHeight,
                    lineWidth: 12,
                    percent: .8,
                    animation: true,
                    animationDuration: 2000,
                    circularStrokeCap: CircularStrokeCap.round,
                    linearGradient: LinearGradient(
                      colors: [Colors.blue, Colors.blue[300]!],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    center: Container(
                      height: parent.maxHeight - 36,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Center(
                              child: AutoSizeText(
                                '80%',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFeatures: [FontFeature.tabularFigures()],
                                ),
                                maxFontSize: 20,
                                minFontSize: 12,
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
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 8,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: AutoSizeText(
                        'Accumulate Rp750.000',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        maxFontSize: 18,
                        minFontSize: 6,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 8,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: AutoSizeText(
                        'Interest every month with a savings account',
                        maxFontSize: 16,
                        minFontSize: 8,
                        maxLines: 2,
                      ),
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

  Widget _lastTransactions() {
    return HomeContainer(
      title: 'Transactions',
      child: ListView.builder(
        itemCount: 6,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (_, i) {
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/icons/${dummyTransactions[i].image}',
              ),
            ),
            title: Text('${dummyTransactions[i].title}'),
            subtitle: Text('${dummyTransactions[i].category}'),
            trailing:
                Text('${Money.fromInt(dummyTransactions[i].amount, idr)}'),
          );
        },
      ),
    );
  }
}

class HomeContainer extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry padding;
  final Widget child;

  const HomeContainer({
    Key? key,
    required this.title,
    required this.child,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: padding,
                child: child,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
