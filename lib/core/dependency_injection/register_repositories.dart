import 'package:clinic_package/clinic_package.dart';

void registerRepositories() {
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      authDataSource: getIt(),
    ),
  );
  getIt.registerSingleton<ScheduleRepo>(
      ScheduleRepoImpl(scheduleDataSource: getIt()));
  getIt.registerSingleton<CategoryRepo>(
    CategoryRepoImpl(
      categoryDataSource: getIt(),
    ),
  );
  getIt.registerSingleton<DoctorRepo>(
    DoctorRepoImpl(
      doctorDataSource: getIt(),
    ),
  );
  getIt.registerSingleton<AppointmentRepo>(
    AppointmentRepoImpl(
      appointmentDataSource: getIt(),
    ),
  );
  getIt.registerSingleton<SearchRepo>(
    SearchRepoImpl(
      searchDataSource: getIt(),
    ),
  );
  getIt.registerSingleton<UpdatePersonalDataRepo>(
    UpdataPesonalDataRepoImpl(
      updatePersonalDataSource: getIt(),
    ),
  );
  getIt.registerSingleton<PatientsRepo>(
      PatientsRepoImpl(patientDataSource: getIt()));
  getIt.registerSingleton<TimeSlotRepo>(
      TimeSlotRepoImpl(timeSlotDataSource: getIt()));
}
