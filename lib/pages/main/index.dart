import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/pages/cart/index.dart';
import 'package:hm_shop/pages/category/index.dart';
import 'package:hm_shop/pages/home/index.dart';
import 'package:hm_shop/pages/mine/index.dart';
import 'package:hm_shop/stores/token_manager.dart';
import 'package:hm_shop/stores/user_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, String>> _tabList = [
    {
      "icon": "lib/assets/ic_public_home_normal.png",
      "active_icon": "lib/assets/ic_public_home_active.png",
      "text": "首页",
    },
    {
      "icon": "lib/assets/ic_public_pro_normal.png",
      "active_icon": "lib/assets/ic_public_pro_active.png",
      "text": "分类",
    },
    {
      "icon": "lib/assets/ic_public_cart_normal.png",
      "active_icon": "lib/assets/ic_public_cart_active.png",
      "text": "购物车",
    },
    {
      "icon": "lib/assets/ic_public_my_normal.png",
      "active_icon": "lib/assets/ic_public_my_active.png",
      "text": "我的",
    },
  ];

  int _currentIndex = 0;
  final UserController _userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  void _initUser() async {
    await tokenManager.init();
    if (tokenManager.getToken().isNotEmpty) {
      _userController.userInfo = await getUserInfoAPI();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _getViews()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _getTabList(),
        currentIndex: _currentIndex,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }

  List<Widget> _getViews() {
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  List<BottomNavigationBarItem> _getTabList() {
    return List.generate(_tabList.length, (index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]["icon"]!, width: 40, height: 40),
        activeIcon: Image.asset(
          _tabList[index]["active_icon"]!,
          width: 40,
          height: 40,
        ),
        label: _tabList[index]["text"],
      );
    });
  }
}
