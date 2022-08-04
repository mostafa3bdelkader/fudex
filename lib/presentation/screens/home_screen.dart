import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fudex/helpers/constants.dart';
import 'package:fudex/providers/home_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: Future.wait([
              Provider.of<HomeProvider>(context, listen: false).fetchSliders(),
              Provider.of<HomeProvider>(context, listen: false).fetchCategories(),
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitDoubleBounce(
                    color: kPrimaryOrange,
                    size: 50.0,
                  ),
                );
              } else {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      centerTitle: true,
                      elevation: 0,
                      backgroundColor: Colors.white,
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: TextField(
                          style: TextStyle(fontSize: 18.sp),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            fillColor: kGrey,
                            filled: true,
                            suffixIcon: Icon(
                              Icons.search,
                              color: kBlack,
                              size: 25,
                            ),
                            hintText: 'كلمة البحث',
                            hintStyle: TextStyle(fontSize: 20.sp),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      floating: true,
                      pinned: true,
                      expandedHeight: 0.1.sh,
                    ),
                    Consumer<HomeProvider>(
                      builder: (context, data, _) => SlidersWidget(data: data),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(24.r),
                        child: Column(
                          children: [
                            Text(
                              'من وين حاب تجمع نقاطك اليوم ؟',
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'اهلا بك Ahmed Hassan',
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Consumer<HomeProvider>(
                      builder: (context, data, _) => CategoriesGrid(data: data),
                    ),
                  ],
                );
              }
            }));
  }
}

class CategoriesGrid extends StatelessWidget {
  final HomeProvider data;
  const CategoriesGrid({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => CategoryItem(
          image: data.categories.data?[index].image,
          title: data.categories.data?[index].name,
        ),
        childCount: data.categories.data?.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
      ),
    );
  }
}

class SlidersWidget extends StatelessWidget {
  final HomeProvider data;
  const SlidersWidget({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 0.32.sh,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 6),
          autoPlayAnimationDuration: const Duration(seconds: 3),
          enableInfiniteScroll: true,
          viewportFraction: 0.82,
          enlargeCenterPage: true,
        ),
        items: data.sliders.data?.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  i.image!,
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String? image;
  final String? title;
  const CategoryItem({required this.image, required this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(image!),
        Text(title!),
      ],
    );
  }
}
