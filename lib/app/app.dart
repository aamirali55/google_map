import 'package:google_map/core/services/location_service.dart';
import 'package:google_map/ui/views/home/home_view.dart';
import 'package:google_map/ui/views/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(page: SplashView, initial: true),
  MaterialRoute(page: HomeView)
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: LocationService)
])
class App {}
