import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import 'core/dependency_injection/di_container.dart';
import 'core/routes/go_routes.dart';

const String baseUrl = "http://192.168.1.66:5252/api";
// const String baseUrl = "http://192.168.1.124:5000/api";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerSingleton<AppConfig>(
    AppConfig(
      restBaseUrl: baseUrl,
      graphQLBaseUrl: "$baseUrl/graphql",
      assetsBaseUrl: "$baseUrl/assets",
      appName: "clincApp",
      flavorName: "dev",
    ),
  );
  await initDependencyInjection();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.red,
  ));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: MaterialApp.router(
        routerConfig: allRoutes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  List<SingleChildWidget> get providers {
    return [
      BlocProvider(
        create: (context) => PatientsBloc(getPatientsQuery: getIt())
          ..add(const PatientsEvent.getAll()),
      ),
      BlocProvider(
        create: (context) {
          return AuthBloc(
              loginQuery: getIt(),
              registerQuery: getIt(),
              changePasswordQuery: getIt());
        },
      ),
      BlocProvider(
        create: (context) {
          return ScheduleBloc(
            addScheduleQuery: getIt(),
            getAllScheduleQuery: getIt(),
            getSchedulesByDoctorId: getIt(),
            getSchedulesByDoctorIdDay: getIt(),
          );
        },
      ),
      BlocProvider(
        create: (context) {
          return TimeSlotBloc(
            getTimeSlotsQuery: getIt(),
          );
        },
      ),
      BlocProvider(
        create: (context) {
          return SearchBloc(
            searchDoctorByTextCommand: getIt(),
          );
        },
      ),
      BlocProvider(
        create: (context) => AppointmentBloc(
          changeStatusAppointmentCommand: getIt(),
          getAppointmentForDoctorQuery: getIt(),
          addAppointmentCommand: getIt(),
          getAppointmentQuery: getIt(),
          deleteAppointmentCommand: getIt(),
        ),
      ),
      BlocProvider(
        create: (context) {
          return CategoryBloc(
            getCategoryQuery: getIt(),
            getDoctorBySpecialtyQuery: getIt(),
          )..add(const CategoryEvent.getAllCategory());
        },
      ),
      BlocProvider(
        create: (context) {
          return DoctorBloc(
            getDoctorQuery: getIt(),
            getDoctorByIdQuery: getIt(),
          )..add(const DoctorEvent.getAllDoctors());
        },
      ),
      BlocProvider(
        create: (context) => PatientsBloc(getPatientsQuery: getIt())
          ..add(const PatientsEvent.getAll()),
      )
    ];
  }
}
