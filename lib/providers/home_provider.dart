import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fudex/helpers/constants.dart';
import 'package:fudex/models/categories.dart';

import '../models/sliders.dart';

class HomeProvider with ChangeNotifier {
  late Sliders _sliders = Sliders();
  late Categories _categories = Categories();

  Categories get categories => _categories;
  Sliders get sliders => _sliders;

  set sliders(Sliders value) {
    _sliders = value;
  }

  set categories(Categories value) {
    _categories = value;
  }

  Future<void> fetchSliders() async {
    try {
      Response response =
          await Dio(BaseOptions(baseUrl: baseUrl)).get('general-slider');

      if (response.statusCode == 200) {
        print(response.data);
        if (response.data["mainCode"] == 1) {
          sliders = Sliders.fromJson(response.data);
          notifyListeners();
        } else {
          Fluttertoast.showToast(msg: response.data["error"]);
        }
      }
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future<void> fetchCategories() async {
    try {
      Response response =
          await Dio(BaseOptions(baseUrl: baseUrl)).get('categories');
      if (response.statusCode == 200) {
        print(response.data);
        if (response.data["mainCode"] == 1) {
          categories = Categories.fromJson(response.data);
          notifyListeners();
        } else {
          Fluttertoast.showToast(msg: response.data["error"]);
        }
      }
    } on DioError catch (e) {
      print(e.response);
    }
  }
}
