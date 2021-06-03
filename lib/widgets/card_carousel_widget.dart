import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
            items: [1, 2, 3].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Card',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: parent.maxHeight - 48,
              aspectRatio: 1.586,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [1, 2, 3].map((url) {
              int index = [1, 2, 3].indexOf(url);
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
