import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;
  const HmSlider({super.key, required this.bannerList});

  @override
  State<HmSlider> createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getSlider(), _getSearch(), _getDots()]);
  }

  Widget _getSlider() {
    return CarouselSlider(
      carouselController: _controller,
      items: List.generate(widget.bannerList.length, (index) {
        return Image.network(
          widget.bannerList[index].imgUrl,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        );
      }),
      options: CarouselOptions(
        height: 300,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 4),
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _getSearch() {
    return Positioned(
      top: 10,
      left: 60,
      right: 60,
      child: Container(
        height: 40,
        padding: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          "搜索",
          style: TextStyle(color: Colors.white54, fontSize: 16),
        ),
      ),
    );
  }

  Widget _getDots() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.bannerList.length, (index) {
          return GestureDetector(
            onTap: () {
              _controller.animateToPage(index);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: _currentIndex == index ? 30 : 16,
              height: 8,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? Color.fromRGBO(255, 255, 255, 0.9)
                    : Colors.white60,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          );
        }),
      ),
    );
  }
}
