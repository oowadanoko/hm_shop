import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/home/hm_category.dart';
import 'package:hm_shop/components/home/hm_hot.dart';
import 'package:hm_shop/components/home/hm_more_list.dart';
import 'package:hm_shop/components/home/hm_slider.dart';
import 'package:hm_shop/components/home/hm_suggestion.dart';
import 'package:hm_shop/utils/toast_utils.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _paddingTop),
        duration: Duration(milliseconds: 300),
        child: CustomScrollView(
          slivers: _getSlivers(),
          controller: _controller,
        ),
      ),
    );
  }

  List<BannerItem> _bannerList = [
    //   BannerItem(
    //     id: "1",
    //     imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg",
    //   ),
    //   BannerItem(
    //     id: "2",
    //     imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.png",
    //   ),
    //   BannerItem(
    //     id: "3",
    //     imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg",
    //   ),
  ];
  List<CategoryItem> _categoryList = [];
  SpecialRecommendResult _specialRecommendResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  SpecialRecommendResult _inVogueResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  SpecialRecommendResult _oneStopResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  List<GoodDetailItem> _recommendList = [];
  final ScrollController _controller = ScrollController();
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  final GlobalKey<RefreshIndicatorState> _key = GlobalKey();
  double _paddingTop = 0;

  @override
  void initState() {
    super.initState();
    _registerEvent();
    Future.microtask(() {
      setState(() {
        _paddingTop = 100;
      });
      _key.currentState?.show();
    });
  }

  Future<void> _getBannerList() async {
    _bannerList = await getBannerListAPI();
  }

  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
  }

  Future<void> _getSpecialRecommendList() async {
    _specialRecommendResult = await getSpecialRecommendListAPI();
  }

  Future<void> _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
  }

  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
  }

  Future<void> _getRecommendList() async {
    if (_isLoading || !_hasMore) {
      return;
    }
    final limit = 8 * _page;
    _isLoading = true;
    _recommendList = await getRecommendListAPI({"limit": limit});
    _isLoading = false;
    _hasMore = _recommendList.length >= limit;
    _page++;
    setState(() {});
  }

  void _registerEvent() {
    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 50) {
        _getRecommendList();
      }
    });
  }

  Future<void> _onRefresh() async {
    _page = 1;
    _isLoading = false;
    _hasMore = true;
    await _getBannerList();
    await _getCategoryList();
    await _getSpecialRecommendList();
    await _getInVogueList();
    await _getOneStopList();
    await _getRecommendList();
    setState(() {
      _paddingTop = 0;
      ToastUtils.showToast(context, "加载成功");
    });
  }

  List<Widget> _getSlivers() {
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: HmSuggestion(specialRecommendResult: _specialRecommendResult),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(
                  specialRecommendResult: _inVogueResult,
                  type: "inVogue",
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(
                  specialRecommendResult: _oneStopResult,
                  type: "oneStop",
                ),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(recommendList: _recommendList),
    ];
  }
}
