import 'package:data_modular/services/sampleApiServices.dart';
import 'package:flutter/foundation.dart';


import '../Model/DataModel.dart';

class DataClass extends ChangeNotifier {
  DataModel? post = DataModel(products: [], total: 0, skip: 0, limit: 0);
  List<Product> dummyList = [];
  List<Product> checkList = [];
  bool loading = false;

  bool ischeck = false;

  List<bool> select = [false];

  double price = 0.0;
  int cnt = 0;
  getPostData() async {
    loading = true;
    post = (await getApiDetails())!;
    loading = false;

    notifyListeners();
  }

  searchData(String searchText) async {
    dummyList.clear();
    print("post!.products!.length");print(post!.products!.length);

    if (searchText.isEmpty) {
      for (int j = 0; j < post!.products!.length; j++) {
        print(post!.products!.length);
        dummyList.add(post!.products![j]);
      }
      post!.products = dummyList;
    } else {
      for (int i = 0; i < post!.products!.length; i++) {
        if (post!.products![i].title
            .toString()
            .toLowerCase()
            .startsWith(searchText.toLowerCase())) {
          if (kDebugMode) {
            print('if${post!.products![i].title}');
          }

          dummyList.add(post!.products![i]);
        }
      }
      post!.products = dummyList;
    }

    notifyListeners();
  }

  check(bool value, int postion) {
    post!.products![postion].selectvalue = value;
    notifyListeners();
    checkList.clear();
    for (int a = 0; a < post!.products!.length; a++) {
      if (post!.products![a].selectvalue == true) {
        checkList.add(post!.products![a]);
        cnt++;
      }
    }
    if (kDebugMode) {
      print('count$cnt');
      print('checkListLength${checkList.length}');
    }
  }

  listpriceTotal() {
    for (int a = 0; a < post!.products!.length; a++) {
      if (post!.products![a].selectvalue == true) {
        price = price + post!.products![0].price;
      }
      if (kDebugMode) {
        print("TotalPrice$price");
      }
    }
  }
}
