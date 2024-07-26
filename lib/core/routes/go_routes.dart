import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/appointment_details_screen.dart';
import '../../presentation/screens/category_screen.dart';
import '../../presentation/screens/doctor_details_screen.dart';
import '../../presentation/screens/layout_screen.dart';
import '../../presentation/screens/login_screen.dart';
import '../../presentation/screens/search_page.dart';
import '../../presentation/screens/splash_screen.dart';
import 'routes.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final token = preferences.getString(SharedKeys.accessToken);
final GoRouter allRoutes = GoRouter(
  initialLocation:
      (token == null) ? Routes.login.withSlash : Routes.layout.withSlash,
  navigatorKey: navigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: Routes.splash.withSlash,
      name: Routes.splash,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: Routes.category.withSlash,
      name: Routes.category,
      builder: (context, state) {
        final Map<String, dynamic>? data = state.extra as Map<String, dynamic>?;
        if (data != null) {
          final String id = data["categoryId"] as String;
          final String name = data["categoryName"] as String;
          return CategoryScreen(
            categoryId: id,
            categoryName: name,
          );
        }
        return const CategoryScreen(
          categoryId: "id",
          categoryName: "name",
        );
      },
    ),
    // GoRoute(
    //   path: Routes.updateAppointment.withSlash,
    //   name: Routes.updateAppointment,
    //   builder: (context, state) {
    //     final Map<String, dynamic>? data = state.extra as Map<String, dynamic>?;
    //     if (data != null) {
    //       final String appointmentId = data["appointmentId"] as String;
    //       final String doctorId = data["doctorId"] as String;
    //       final String patientId = data["patientId"] as String;
    //       final int scheduleId = data["scheduleId"] as int;

    //       return UpdateAppointmentScreen(
    //         patientId: patientId,
    //         scheduleId: scheduleId,
    //         appointmentId: appointmentId,
    //         doctorId: doctorId,
    //       );
    //     }
    //     return const UpdateAppointmentScreen(
    //       scheduleId: 1,
    //       patientId: "",
    //       appointmentId: "id",
    //       doctorId: "name",
    //     );
    //   },
    // ),
    GoRoute(
      path: Routes.search.withSlash,
      name: Routes.search,
      builder: (context, state) {
        return const SearchPage();
      },
    ),
    GoRoute(
      path: Routes.login.withSlash,
      name: Routes.login,
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: Routes.layout.withSlash,
      name: Routes.layout,
      builder: (context, state) {
        return const LayoutScreen();
      },
    ),
    GoRoute(
      path: Routes.doctorDetails.withSlash,
      name: Routes.doctorDetails,
      builder: (context, state) {
        final String id = state.extra as String;
        return DoctorDetailsScreen(
          id: id,
        );
      },
    ),
    GoRoute(
      path: Routes.appointmentDetails.withSlash,
      name: Routes.appointmentDetails,
      builder: (context, state) {
        final AppointmentData data = state.extra as AppointmentData;
        return AppointmentDetailsScreen(
          patientId: data.patientId,
          doctorId: data.doctorId,
          day: data.day,
        );
      },
    ),
  ],
);
