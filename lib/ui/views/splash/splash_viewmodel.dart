import 'package:google_map/app/app.locator.dart';
import 'package:google_map/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

  Future<void> delay() async {
    await Future.delayed(const Duration(seconds: 3));
    navigationService.replaceWithHomeView();
  }
}
