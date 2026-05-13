import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/dio_request.dart';
import 'package:hm_shop/viewmodels/user.dart';

Future<UserInfo> loginAPI(Map<String, dynamic> data) async {
  return UserInfo.fromJSON(
    await dioRequest.post(HttpConstants.LOGIN, data: data),
  );
}
