import 'dart:developer';

import 'package:mgramseva/providers/common_provider.dart';
import 'package:mgramseva/providers/home_provider.dart';
import 'package:mgramseva/routers/routers.dart';
import 'package:mgramseva/utils/constants.dart';
import 'package:mgramseva/utils/global_variables.dart';
import 'package:mgramseva/utils/models.dart';
import 'package:provider/provider.dart';

class RoleActionsFiltering {
  List<HomeItem> getFilteredModules() {
    return Constants.HOME_ITEMS.where((e) => isEligibleRole(e)).toList();
  }

  bool isEligibleRole(HomeItem item) {
    var commonProvider = Provider.of<CommonProvider>(
        navigatorKey.currentContext!,
        listen: false);

     var hp = Provider.of<HomeProvider>(
        navigatorKey.currentContext!,
        listen: false);    
    var isEligible = true;

    if(item.link == Routes.ANURAKSHAK_DASHBOARD){
      if(commonProvider.userDetails?.selectedtenant?.code == hp.links?.tenantID){
        return true;
      }
      else{
        return false;
      }
    }

    if (getRolesBasedOnModule(item.link).length == 1) {
      getRolesBasedOnModule(item.link).forEach((element) {
        var roles = commonProvider.userDetails?.userRequest?.roles
            ?.where((e) =>
                e.code == element &&
                commonProvider.userDetails?.selectedtenant?.code == e.tenantId)
            .toList();

        if (roles?.isEmpty ?? true) {
          isEligible = false;
        }
      });
      return isEligible;
    } else if (getRolesBasedOnModule(item.link).length > 1) {
      var roles = commonProvider.userDetails?.userRequest?.roles?.where((e) {
        if (getRolesBasedOnModule(item.link).contains(e.code) &&
            commonProvider.userDetails?.selectedtenant?.code == e.tenantId) {
          return true;
        } else
          return false;
      }).toList();

      if (roles?.isEmpty ?? true) {
        isEligible = false;
      }
      return isEligible;
    } else {
      return isEligible;
    }
  }

  bool isEligibleRoleToRoute(String routerLink) {
    var commonProvider = Provider.of<CommonProvider>(
        navigatorKey.currentContext!,
        listen: false);
    var isEligible = true;

    if (getRolesBasedOnModule(routerLink).length == 1) {
      getRolesBasedOnModule(routerLink).forEach((element) {
        var roles = commonProvider.userDetails?.userRequest?.roles
            ?.where((e) =>
                e.code == element &&
                commonProvider.userDetails?.selectedtenant?.code == e.tenantId)
            .toList();
        if (roles?.isEmpty ?? true) {
          isEligible = false;
        }
      });

      return isEligible;
    } else if (getRolesBasedOnModule(routerLink).length > 1) {
      var roles = commonProvider.userDetails?.userRequest?.roles?.where((e) {
        if (getRolesBasedOnModule(routerLink).contains(e.code) &&
            commonProvider.userDetails?.selectedtenant?.code == e.tenantId) {
          return true;
        } else
          return false;
      }).toList();

      if (roles?.isEmpty ?? true) {
        isEligible = false;
      }
      return isEligible;
    } else {
      return isEligible;
    }
  }

  List<String> getRolesBasedOnModule(String route) {
    switch (route) {
      // GP Admin
      case Routes.HOUSEHOLD:
        return ['COLLECTION_OPERATOR', 'SUPERUSER', 'DIV_ADMIN'];

      case Routes.CONSUMER_UPDATE:
        return ['GP_ADMIN', 'SUPERUSER', 'COLLECTION_OPERATOR', 'DIV_ADMIN'];

      case Routes.CONSUMER_SEARCH_UPDATE:
        return ['GP_ADMIN', 'SUPERUSER', 'COLLECTION_OPERATOR', 'DIV_ADMIN'];

      case Routes.CONSUMER_CREATE:
        return ['GP_ADMIN', 'SUPERUSER', 'COLLECTION_OPERATOR', 'DIV_ADMIN'];

      case Routes.HOUSEHOLD_DETAILS:
        return [
          'BULK_DEMAND_PROCESSING',
          'COLLECTION_OPERATOR',
          'SUPERUSER',
          'DIV_ADMIN'
        ];

      case Routes.SEARCH_CONSUMER_RESULT:
        return [
          'GP_ADMIN',
          'BULK_DEMAND_PROCESSING',
          'COLLECTION_OPERATOR',
          'SUPERUSER',
          'DIV_ADMIN'
        ];

      case Routes.HOUSEHOLD_REGISTER:
        return ['COLLECTION_OPERATOR', 'SUPERUSER', 'DIV_ADMIN'];

      // Expense Processing
      case Routes.EXPENSE_SEARCH:
        return ['EXPENSE_PROCESSING', 'SUPERUSER', 'DIV_ADMIN'];
      case Routes.EXPENSES_ADD:
        return ['EXPENSE_PROCESSING', 'SUPERUSER', 'DIV_ADMIN'];
      case Routes.EXPENSE_UPDATE:
        return ['EXPENSE_PROCESSING', 'SUPERUSER', 'DIV_ADMIN'];
      case Routes.HOUSEHOLDRECEIPTS:
        return [
          'BULK_DEMAND_PROCESSING',
          'COLLECTION_OPERATOR',
          'SUPERUSER',
          'DIV_ADMIN'
        ];

      case Routes.MANUAL_BILL_GENERATE:
        return ['BULK_DEMAND_PROCESSING', 'SUPERUSER', 'DIV_ADMIN'];

      // Collection Operator
      case Routes.CONSUMER_SEARCH:
        return ['COLLECTION_OPERATOR', 'SUPERUSER', 'DIV_ADMIN'];
      case Routes.BILL_GENERATE:
        return ['COLLECTION_OPERATOR', 'SUPERUSER', 'DIV_ADMIN'];

      case Routes.DASHBOARD:
        return ['SUPERUSER', 'DASHBOARD_VIEWER', 'GP_ADMIN', 'DIV_ADMIN'];
      case Routes.REPORTS:
        return ['SUPERUSER', 'DASHBOARD_VIEWER', 'GP_ADMIN', 'DIV_ADMIN'];
      default:
        return [];
    }
  }
}
