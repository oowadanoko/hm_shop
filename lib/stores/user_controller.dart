import 'package:get/get.dart';
import 'package:hm_shop/viewmodels/user.dart';

class UserController extends GetxController {
  Rx<UserInfo> user = UserInfo.fromJSON({}).obs;

  set userInfo(UserInfo userInfo) {
    user.value = userInfo;
  }
}
