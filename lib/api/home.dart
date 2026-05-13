import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/dio_request.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListAPI() async {
  return ((await dioRequest.get(HttpConstants.BANNER_LIST)) as List).map((
    item,
  ) {
    return BannerItem.fromJSON(item);
  }).toList();
}

Future<List<CategoryItem>> getCategoryListAPI() async {
  return ((await dioRequest.get(HttpConstants.CATEGORY_LIST)) as List).map((
    item,
  ) {
    return CategoryItem.fromJSON(item);
  }).toList();
}

Future<SpecialRecommendResult> getSpecialRecommendListAPI() async {
  final response = await dioRequest.get(HttpConstants.PRODUCT_LIST);
  return SpecialRecommendResult.fromJSON(response);
}

Future<SpecialRecommendResult> getInVogueListAPI() async {
  final response = await dioRequest.get(HttpConstants.IN_VOGUE_LIST);
  return SpecialRecommendResult.fromJSON(response);
}

Future<SpecialRecommendResult> getOneStopListAPI() async {
  final response = await dioRequest.get(HttpConstants.ONE_STOP_LIST);
  return SpecialRecommendResult.fromJSON(response);
}

Future<List<GoodDetailItem>> getRecommendListAPI(
  Map<String, dynamic> params,
) async {
  // 返回请求
  return ((await dioRequest.get(HttpConstants.RECOMMEND_LIST, params: params))
          as List)
      .map((item) {
        return GoodDetailItem.formJSON(item as Map<String, dynamic>);
      })
      .toList();
}
