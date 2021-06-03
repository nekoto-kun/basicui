import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:money2/money2.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../screen/profile_screen.dart';
import '../util/colors.dart';
import '../util/dummy.dart';
import '../widgets/card_carousel_widget.dart';

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
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.of(context).orientation == Orientation.portrait ||
              MediaQuery.of(context).size.width <= 768
          ? TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomeContent(scrollController: _scrollController),
                ProfileScreen(),
              ],
            )
          : HomeContent(
              scrollController: _scrollController,
            ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _tabController.index,
        onTap: (i) => setState(() => _tabController.animateTo(i)),
        items: [
          SalomonBottomBarItem(
            icon: Icon(FeatherIcons.home),
            title: Text('Home', style: Theme.of(context).textTheme.bodyText1),
            selectedColor: Color(0xFF2E2A2A),
          ),
          SalomonBottomBarItem(
            icon: Icon(FeatherIcons.user),
            title:
                Text('Profile', style: Theme.of(context).textTheme.bodyText1),
            selectedColor: Color(0xFF2E2A2A),
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  final ScrollController scrollController;

  const HomeContent({Key? key, required this.scrollController})
      : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: widget.scrollController,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  _header(),
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

  Container _header() {
    return Container(
      height: 360,
      color: Color(primaryYellow),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 32),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good morning',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Andre',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFFFEEDA9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.person),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CardCarousel(),
          ),
        ],
      ),
    );
  }

  HomeContainer _goal(BuildContext context) {
    return HomeContainer(
      title: 'Current Goal',
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Container(
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
        height: MediaQuery.of(context).size.height *
            (MediaQuery.of(context).orientation == Orientation.portrait ||
                    MediaQuery.of(context).size.width <= 768
                ? 1 / 6
                : 2 / 5),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: LayoutBuilder(
                  builder: (_, parent) => CircularPercentIndicator(
                    radius: parent.maxWidth /
                        (MediaQuery.of(context).orientation ==
                                    Orientation.portrait ||
                                MediaQuery.of(context).size.width <= 768
                            ? 1
                            : 2),
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
                    center: AutoSizeText(
                      '80%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        fontFeatures: [
                          FontFeature.tabularFigures(),
                        ],
                      ),
                      maxFontSize: 24,
                      minFontSize: 12,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 8,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: AutoSizeText(
                        'Accumulate IDR 1.500.000',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        maxFontSize: 18,
                        minFontSize: 6,
                        maxLines: 1,
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

  HomeContainer _lastTransactions() {
    Currency idr = Currency.create(
      'IDR',
      0,
      symbol: 'Rp',
      invertSeparators: true,
      pattern: 'S0.000',
    );

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
              child: Image.network(
                'https://via.placeholder.com/80/000000/FFFFFF/?text=${i + 1}',
              ),
            ),
            title: Text('${dummyData[i]['title']}'),
            subtitle: Text('${dummyData[i]['category']}'),
            trailing:
                Text('${Money.fromInt(dummyData[i]['amount'] as int, idr)}'),
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
