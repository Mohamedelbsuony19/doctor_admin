import 'package:clinic_package/clinic_package.dart';

void registerDataSources() {
  getIt.registerSingleton<ScheduleDataSource>(
    ScheduleDataSourceImpl(dioClient: getIt()),
  );
  getIt.registerSingleton<AuthDataSource>(
    AuthDataSourceImpl(dioClient: getIt()),
  );
  getIt.registerSingleton<CategoryDataSource>(
    CategoryDataSourceImpl(dioClient: getIt()),
  );
  getIt.registerSingleton<DoctorDataSource>(
    DoctorDataSourceImpl(dioClient: getIt()),
  );
  getIt.registerSingleton<AppointmentDataSource>(
    AppointmentDataSourceImpl(dioClient: getIt()),
  );
  getIt.registerSingleton<SearchDataSource>(
    SearchDataSourceImpl(dioClient: getIt()),
  );
  getIt.registerSingleton<UpdatePersonalDataSource>(
    UpdataPesonalDataSourceImpl(dioClient: getIt()),
  );
  getIt.registerSingleton<PatientDataSource>(
      PatientDataSourceImpl(dioClient: getIt()));
  getIt.registerSingleton<TimeSlotDataSource>(
      TimeSlotDataSourceImpl(baseDio: getIt()));
}
