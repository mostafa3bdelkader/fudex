import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fudex/helpers/constants.dart';
import 'package:fudex/presentation/screens/home_screen.dart';
import 'package:fudex/presentation/screens/my_orders_screen.dart';
import 'package:fudex/presentation/screens/notifications_screen.dart';
import 'package:fudex/presentation/screens/profile_screen.dart';
import 'package:fudex/presentation/screens/settings_screen.dart';

class AnimatedNavigationBar extends StatefulWidget {
  const AnimatedNavigationBar({Key? key}) : super(key: key);

  @override
  State<AnimatedNavigationBar> createState() => _AnimatedNavigationBarState();
}

class _AnimatedNavigationBarState extends State<AnimatedNavigationBar>
    with SingleTickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  late AnimationController _animationController;
  Animation<double>? animation;
  late CurvedAnimation curve;
  final PageController _pageController = PageController();
  int currentTab = 4;

  final List<IconData> iconsList = [
    Icons.settings_outlined,
    Icons.shopping_cart_outlined,
    Icons.person_outlined,
    Icons.notifications_active_outlined
  ];

  final iconsTitles = <String>["الاعدادات", "مشترياتي", "حسابي", "الاشعارات"];

  final List<Widget> _screens = [
    const SettingsScreen(),
    const MyOrdersScreen(),
    const ProfileScreen(),
    const NotificationsScreen(),
  ];

  void _onItemTapped(int selectedIndex) {
    currentTab = selectedIndex;
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      const Duration(seconds: 1),
      () => _animationController.forward(),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentTab = index;
          });
        },
        physics: const NeverScrollableScrollPhysics(),
        children: currentTab == 4
            ? [
                const HomeScreen(),
              ]
            : _screens,
      ),
      floatingActionButton: ScaleTransition(
        scale: animation!,
        child: SizedBox(
          height: 90.r,
          width: 90.r,
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.grey.shade300,
                child: const FaIcon(
                  FontAwesomeIcons.houseChimney,
                  color: Colors.grey,
                ),
                onPressed: () async {
                  setState(() {
                    currentTab = 4;
                  });
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconsList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? kPrimaryOrange : kBlack;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconsList[index],
                color: color,
                size: 28,
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AutoSizeText(
                  iconsTitles[index],
                  maxLines: 1,
                  style: TextStyle(color: color, fontSize: 14),
                  group: autoSizeGroup,
                ),
              )
            ],
          );
        },
        backgroundColor: Colors.white,
        activeIndex: currentTab,
        splashColor: kPrimaryOrange,
        notchAndCornersAnimation: animation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.softEdge,
        gapLocation: GapLocation.center,
        height: MediaQuery.of(context).size.height * 0.12,
        // leftCornerRadius: 32,
        // rightCornerRadius: 32,
        onTap: (index) => setState(() => _onItemTapped(index)),
        blurEffect: true,
      ),
    );
  }
}
