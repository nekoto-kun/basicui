import 'package:auto_size_text/auto_size_text.dart';
import 'package:basicui/util/dummy.dart';
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

  String? _cardLogoPath(String? type) {
    switch (type) {
      case 'visa':
        return 'assets/icons/visa.png';
      case 'mastercard':
        return 'assets/icons/mastercard-logo.png';
    }
  }

  Color _cardColor(String color) {
    switch (color) {
      case 'dark':
        return Colors.grey[800]!;
      case 'white':
        return Colors.white;
      case 'blue':
        return Colors.blue[900]!;
      default:
        return Colors.white;
    }
  }

  TextStyle _cardTextStyle(String color, {double opacity = 1.0}) {
    switch (color) {
      case 'dark':
        return TextStyle(color: Colors.white.withOpacity(opacity));
      case 'white':
        return TextStyle(color: Color(0xFF2E2A2A).withOpacity(opacity));
      case 'blue':
        return TextStyle(color: Colors.white.withOpacity(opacity));
      default:
        return TextStyle(color: Color(0xFF2E2A2A).withOpacity(opacity));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, parent) => Column(
        children: [
          CarouselSlider(
            items: cards.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  String? _imagePath = _cardLogoPath('${i['type']}');
                  return AspectRatio(
                    aspectRatio: 1.586,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: _cardColor('${i['color']}'),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            '${i['name']}',
                            style: _cardTextStyle('${i['color']}').copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Expanded(
                            child: AutoSizeText(
                              '${Money.fromInt(i['balance'] as int, idr)}',
                              style: _cardTextStyle(
                                '${i['color']}',
                                opacity: .5,
                              ).copyWith(fontFamily: 'Fira Code'),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: AutoSizeText(
                                    '${i['number']}',
                                    style: _cardTextStyle('${i['color']}')
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
