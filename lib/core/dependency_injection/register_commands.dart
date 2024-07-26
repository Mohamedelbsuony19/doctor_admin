
import 'package:clinic_package/clinic_package.dart';

import 'di_container.dart';

void registerCommands() {
  getIt.registerSingleton<DeleteAppointmentCommand>(
      DeleteAppointmentCommandImpl(appointmentRepo: getIt()));
  getIt.registerSingleton<AddAppointmentCommand>(
      AddAppointmentCommandImpl(appointmentRepo: getIt()));


  getIt.registerSingleton<SearchDoctorByTextCommand>(
      SearchDoctorByTextCommandImpl(searchRepo: getIt()));
  getIt.registerSingleton<ChangeStatusAppointmentCommand >(
      ChangeAppointmentStatusCommandImpl(appointmentRepo: getIt()));

  // getIt.registerSingleton<DeleteDoctorCommand>(
  //     DeleteDoctorCommandImpl(repo: getIt()));
}

  // getIt.registerSingleton<DeleteTimeSlotCommand>(
  //     DeleteTimeSlotCommandImpl(timeSlotRepo: getIt()));