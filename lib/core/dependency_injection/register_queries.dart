import 'package:clinic_package/clinic_package.dart';

void registerQueries() {
  getIt.registerSingleton<LoginQuery>(LoginQueryImpl(authRepo: getIt()));

  getIt.registerSingleton<GetDoctorScheduleQuery>(
      GetDoctorSchedulesQueryImpl(repo: getIt()));

  // getIt.registerSingleton<AddDoctorQuery>(
  //     AddDoctorQueryImpl(doctorRepo: getIt()));

  getIt.registerSingleton<RegisterQuery>(RegisterQueryImpl(authRepo: getIt()));

  getIt.registerSingleton<GetCategoryQuery>(
      GetCategoryQueryImpl(categoryRepo: getIt()));

  getIt.registerSingleton<GetDoctorByIdQuery>(
      GetDoctorByIdQueryImpl(doctorRepo: getIt()));

  getIt.registerSingleton<GetDoctorsQuery>(
    GetDoctorsQueryImpl(doctorRepo: getIt()),
  );
  getIt.registerSingleton<GetDoctorsBySpecialtyQuery>(
    GetDoctorsBySpecialtyQueryImpl(categoryRepo: getIt()),
  );
  getIt.registerSingleton<GetAllAppointmentQuery>(
      GetAllAppointmentQueryImpl(appointmentRepo: getIt()));

  getIt.registerSingleton<UpdatePersonalDataQuery>(
      UpdatePersonalDataQueryImpl(updatePersonalDataRepo: getIt()));

  getIt.registerSingleton<GetPatientsQuery>(
      GetPatientsQueryImpl(patientsRepo: getIt()));

  getIt.registerSingleton<GetTimeSlotsQuery>(
      GetTimeSlotsQueryImpl(timeSlotRepo: getIt()));

  // getIt.registerSingleton<AddTimeSlotQuery>(
  //     AddTimeSlotQueryImpl(timeSlotRepo: getIt()));

  getIt.registerSingleton<GetSchedulesByDayQuery>(
      GetSchedulesByDayQueryImpl(scheduleRepo: getIt()));
  getIt.registerSingleton<AddScheduleQuery>(
      AddScheduleQueryImpl(scheduleRepo: getIt()));
  getIt.registerSingleton<GetAllScheduleByDotorIdQuery>(
      GetAllScheduleByDotorIdQueryImpl(scheduleRepo: getIt()));
  getIt.registerSingleton<GetAppointmentForDoctorQuery>(
      GetAppointmentForDoctorQueryImpl(appointmentRepo: getIt()));
  getIt.registerSingleton<ChangePasswordQuery>(
      ChangePasswordQueryImpl(authRepo: getIt()));
}
