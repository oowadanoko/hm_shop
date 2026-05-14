import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmHot extends StatefulWidget {
  final SpecialRecommendResult specialRecommendResult;
  final String type;
  const HmHot({
    super.key,
    required this.specialRecommendResult,
    required this.type,
  });

  @override
  State<HmHot> createState() => _HmHotState();
}

class _HmHotState extends State<HmHot> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4),
        height: 190,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.type == "inVogue"
              ? const Color.fromARGB(255, 177, 231, 243)
              : const Color.fromARGB(255, 240, 234, 167),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildHeader(),
            SizedBox(height: 4),
            Row(
              children: [
                SizedBox(width: 4),
                Expanded(
                  child: Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _getChildren(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          widget.type == "inVogue" ? "爆款推荐" : "一站买全",
          style: TextStyle(
            fontSize: 16,
            color: const Color.fromARGB(255, 159, 53, 8),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 10),
        Text(
          widget.type == "inVogue" ? "最受欢迎" : "精心优选",
          style: TextStyle(
            fontSize: 10,
            color: const Color.fromARGB(255, 201, 89, 41),
          ),
        ),
      ],
    );
  }

  List<GoodsItem> get _items {
    if (widget.specialRecommendResult.subTypes.isEmpty) {
      return [];
    }
    return widget.specialRecommendResult.subTypes.first.goodsItems.items
        .take(2)
        .toList();
  }

  List<Widget> _getChildren() {
    var list = _items;
    return List.generate(list.length, (index) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                list[index].picture,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "lib/assets/home_cmd_inner.png",
                    height: 100,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "￥${list[index].price}",
                style: TextStyle(
                  color: const Color.fromARGB(255, 160, 16, 16),
                  fontSize: 8,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
