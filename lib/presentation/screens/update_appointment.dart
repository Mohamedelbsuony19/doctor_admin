// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// import 'package:clinic_package/clinic_package.dart';// import '../../core/utils/show_snack_bar.dart';
// import '../../domain/entities/appointment_entity.dart';
// import '../blocs/appointment/appointment_bloc.dart';
// import '../blocs/schedule/schedule_bloc.dart';
// import '../widgets/validation_alert_dialog.dart';

// class UpdateAppointmentScreen extends StatefulWidget {
//   final String appointmentId;
//   final String doctorId;
//   final int scheduleId;
//   final String patientId;

//   const UpdateAppointmentScreen({
//     super.key,
//     required this.appointmentId,
//     required this.doctorId,
//     required this.scheduleId,
//     required this.patientId,
//   });

//   @override
//   State<UpdateAppointmentScreen> createState() =>
//       _UpdateAppointmentScreenState();
// }

// class _UpdateAppointmentScreenState extends State<UpdateAppointmentScreen> {
//   int? scheduleId;
//   @override
//   void initState() {
//     context
//         .read<ScheduleBloc>()
//         .add(ScheduleEvent.getSchedulesByDoctorId(doctorId: widget.doctorId));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Rescheduled appointment"),
//       ),
//       body: BlocConsumer<AppointmentBloc, AppointmentState>(
//         listener: (context, appointmentState) {
//           appointmentState.maybeMap(
//               orElse: () {},
//               success: (value) {
//                 if (value.isDeleted) {
//                   ShowSnackbar.showCheckTopSnackBar(
//                     context,
//                     text: 'Appointment updated successfully',
//                     type: SnackBarType.success,
//                   );
//                   context
//                       .read<AppointmentBloc>()
//                       .add(const AppointmentEvent.getAppointment());
//                 }
//               });
//         },
//         builder: (context, appointmentState) {
//           return Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: BlocBuilder<ScheduleBloc, ScheduleState>(
//               builder: (context, state) {
//                 return Column(
//                   children: [
//                     state.maybeMap(
//                       orElse: () => const SizedBox(),
//                       success: (schedules) {
//                         return DropdownButtonFormField(
//                             decoration: InputDecoration(
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: const BorderSide(
//                                   color: Colors.black,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: const BorderSide(
//                                   color: Colors.black,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             hint: const Text("Select Time"),
//                             items: schedules.schedules.value?.map((schedule) {
//                                   return DropdownMenuItem(
//                                     value: schedule.id,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "Time: ${schedule.timeSlot?.startTime}",
//                                           style: const TextStyle(
//                                               color: Theme.of(context).colorScheme.primary),
//                                         ),
//                                         Text("day: ${schedule.timeSlot?.day}"),
//                                       ],
//                                     ),
//                                   );
//                                 }).toList() ??
//                                 [],
//                             validator: (v) {
//                               if (v == null) {
//                                 return "Please select time";
//                               }
//                               return null;
//                             },
//                             onChanged: (value) {
//                               log("$value");
//                               scheduleId = value as int;
//                             });
//                       },
//                     ),
//                     const Spacer(),
//                     ElevatedButton(
//                         onPressed: () {
//                           showValidationDialog(context,
//                               itemName: "appointment",
//                               validationName: 'Reschedule', onYesPressed: () {
//                             state.maybeMap(
//                                 orElse: () => const SizedBox(),
//                                 success: (schedules) {
//                                   if (_isScheduleIdUsed(
//                                       appointments: appointmentState.maybeMap(
//                                           orElse: () => [],
//                                           success: (value) => value
//                                               .getAppointmentsData!.value!),
//                                       scheduleId: scheduleId!)) {
//                                     ShowSnackbar.showCheckTopSnackBar(
//                                       context,
//                                       text: "Appointment already booked",
//                                       type: SnackBarType.error,
//                                     );
//                                   } else {
//                                     context.read<AppointmentBloc>().add(
//                                           AppointmentEvent.updateAppointment(
//                                             appointmentId: widget.appointmentId,
//                                             patientId: widget.patientId,
//                                             doctorId: widget.doctorId,
//                                             scheduleId: scheduleId ?? 0,
//                                           ),
//                                         );
//                                     Future.delayed(
//                                         const Duration(seconds: 2),
//                                         () => context
//                                             .read<AppointmentBloc>()
//                                             .add(const AppointmentEvent
//                                                 .getAppointment()));
//                                     context.pop();
//                                   }
//                                 });
//                           });
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFFBCCBF9),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           fixedSize: Size(
//                             MediaQuery.sizeOf(context).width * 0.8,
//                             50,
//                           ),
//                         ),
//                         child: const Text(
//                           'Save',
//                           style: TextStyle(
//                             color: Theme.of(context).colorScheme.onPrimaryContainer,
//                             fontSize: 16,
//                           ),
//                         )),
//                   ],
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }

//   bool _isScheduleIdUsed(
//       {required List<Appointment> appointments, required int scheduleId}) {
//     for (Appointment appointment in appointments) {
//       if (appointment.scheduleId == scheduleId) {
//         return true;
//       }
//     }
//     return false;
//   }
// }
