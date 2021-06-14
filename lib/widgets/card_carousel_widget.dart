import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';

import '../model/card.dart';
import '../screen/card_detail_screen.dart';
import '../util/dummy.dart';
import '../util/misc.dart';
import '../util/money.dart';

class CardCarousel extends StatefulWidget {
  const CardCarousel({
    Key? key,
  }) : super(key: key);

  @override
  _CardCarouselState createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, parent) => Column(
        children: [
          CarouselSlider(
            items: dummyCards.map((i) => BankCardWidget(data: i)).toList(),
            options: CarouselOptions(
              height: parent.maxHeight - 48,
              aspectRatio: 1.586,
              enableInfiniteScroll: false,
              viewportFraction:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? .6
                      : .3,
              onPageChanged: (index, reason) =>
                  setState(() => _current = index),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: dummyCards.map((url) {
              int index = dummyCards.indexOf(url);
              return Container(
                width: 8,
                height: 8,
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _current == index ? Color(0xFFFFFFFF) : Color(0xFFFCC428),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class BankCardWidget extends StatelessWidget {
  const BankCardWidget({
    Key? key,
    required BankCard data,
  })  : _data = data,
        super(key: key);

  final BankCard _data;

  @override
  Widget build(BuildContext context) {
    String? _imagePath = cardLogoPath('${_data.type}');
    return AspectRatio(
      aspectRatio: 1.586,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CardDetailScreen(card: _data),
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: cardColor('${_data.color}'),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                '${_data.name}',
                style: cardTextStyle('${_data.color}').copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: AutoSizeText(
                  '${Money.fromInt(_data.balance, idr)}',
                  style: cardTextStyle(
                    '${_data.color}',
                    opacity: .5,
                  ).copyWith(fontFamily: 'Fira Code'),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        '${_data.cardNumber}',
                        style: cardTextStyle('${_data.color}')
                            .copyWith(fontFamily: 'Fira Code'),
                      ),
                    ),
                    if (_imagePath != null)
                      Image(
                        image: AssetImage(_imagePath),
                        height: 60,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
