import 'package:auto_size_text/auto_size_text.dart';
import 'package:basicui/screen/card_detail_screen.dart';
import 'package:basicui/util/dummy.dart';
import 'package:basicui/util/misc.dart';
import 'package:basicui/util/money.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';

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
            items: cards.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  String? _imagePath = cardLogoPath('${i.type}');
                  return AspectRatio(
                    aspectRatio: 1.586,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CardDetailScreen(card: i),
                        ),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: cardColor('${i.color}'),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              '${i.name}',
                              style: cardTextStyle('${i.color}').copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Expanded(
                              child: AutoSizeText(
                                '${Money.fromInt(i.balance, idr)}',
                                style: cardTextStyle(
                                  '${i.color}',
                                  opacity: .5,
                                ).copyWith(fontFamily: 'Fira Code'),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AutoSizeText(
                                      '${i.cardNumber}',
                                      style: cardTextStyle('${i.color}')
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
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: parent.maxHeight - 48,
              aspectRatio: 1.586,
              enableInfiniteScroll: false,
              viewportFraction:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? .6
                      : .3,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: cards.map((url) {
              int index = cards.indexOf(url);
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
