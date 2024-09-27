import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mgramseva/model/mdms/links.dart';
import 'package:mgramseva/screeens/home/home_walk_through/home_walk_through_list.dart';
import 'package:mgramseva/utils/role_actions.dart';

class HomeProvider with ChangeNotifier {
  var streamController = StreamController.broadcast();
  late List<HomeWalkWidgets> homeWalkthroughList;
  int activeIndex = 0;

  String anurakshakDashboardLink = "";
  String  getAnurakshakDashboardLink() => anurakshakDashboardLink;

  void setAnurakshakDashboardLink({required String value,Links? link}) {
    anurakshakDashboardLink = value;
    setLinkInfo(link);
    notifyListeners();
  }
  Links? links;
  String  getLinkInfo() => anurakshakDashboardLink;

  void setLinkInfo(Links? value) {
    links = value;
  }
   


  void setWalkThrough(value) {
    homeWalkthroughList = value
        .where((element) => RoleActionsFiltering()
            .getFilteredModules()
            .where((ele) => ele.label == element.label)
            .isNotEmpty)
        .toList();
  }

  incrementIndex(index, homeKey) async {
    activeIndex = index + 1;
    await Scrollable.ensureVisible(homeKey.currentContext!,
        duration: new Duration(milliseconds: 100));
  }

  dispose() {
    streamController.close();
    super.dispose();
  }

  void updateWalkThrough(value) {
    homeWalkthroughList = value;
  }
}
