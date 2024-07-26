
import 'package:clinic_package/clinic_package.dart';

import 'di_container.dart';

void registerFactories() {
  getIt.registerFactory<ScheduleBloc>(() => ScheduleBloc(
        getSchedulesByDoctorId: getIt(),
        getSchedulesByDoctorIdDay: getIt(), getAllScheduleQuery: getIt(),
        addScheduleQuery: getIt(),
      ));
      
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      changePasswordQuery: getIt(),
      loginQuery: getIt(),
      registerQuery: getIt(),
    ),
  );
  getIt.registerFactory<CategoryBloc>(
    () => CategoryBloc(
      getCategoryQuery: getIt(),
      getDoctorBySpecialtyQuery: getIt(),
    ),
  );
  getIt.registerFactory<TimeSlotBloc>(
    () => TimeSlotBloc(
      getTimeSlotsQuery: getIt(),
    ),
  );
  getIt.registerFactory<DoctorBloc>(
    () => DoctorBloc(
      getDoctorQuery: getIt(),
      getDoctorByIdQuery: getIt(),
    ),
  );
  getIt.registerFactory<AppointmentBloc>(
    () => AppointmentBloc(
      changeStatusAppointmentCommand: getIt(),
      getAppointmentForDoctorQuery: getIt(),
      addAppointmentCommand: getIt(),
      getAppointmentQuery: getIt(),
      deleteAppointmentCommand: getIt(),
    ),
  );
  getIt.registerFactory<SearchBloc>(
    () => SearchBloc(
      searchDoctorByTextCommand: getIt(),
    ),
  );
  getIt.registerFactory<PatientsBloc>(
      () => PatientsBloc(getPatientsQuery: getIt()));
}
