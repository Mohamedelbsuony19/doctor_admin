import 'dart:developer';

import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/show_snack_bar.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  const AppointmentDetailsScreen({
    super.key,
    required this.patientId,
    required this.doctorId,
    required this.day,
  });
  final String patientId;
  final String doctorId;
  final int day;
  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  List<String> timeSlots = [];
  String? selectedTime;
  int? selectedValue;

  @override
  void initState() {
    super.initState();
    log(widget.doctorId);
    context.read<ScheduleBloc>().add(ScheduleEvent.getSchedulesByDay(
        doctorId: widget.doctorId, dayOfWeek: widget.day));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointment Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<ScheduleBloc, ScheduleState>(
            listener: (context, state) {
          state.maybeMap(
              orElse: () {},
              error: (value) => ShowSnackbar.showCheckTopSnackBar(
                    context,
                    text: value.message,
                    type: SnackBarType.error,
                  ));
        }, builder: (context, state) {
          return state.map(
              loading: (value) =>
                  const Center(child: CircularProgressIndicator()),
              error: (message) => const SizedBox(),
              success: (value) => value.schedulesByDay == [] ||
                      value.schedulesByDay == null
                  ? const Center(child: Text("No Appointment Available"))
                  : Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Pick Time",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.01),
                        Wrap(
                            spacing: 8.0,
                            children: value.schedulesByDay!.map((schedule) {
                              return ChoiceChip(
                                label: Text(schedule.startTime!),
                                selected: selectedTime == schedule.startTime,
                                onSelected: (selected) {
                                  setState(() {
                                    selectedTime =
                                        selected ? schedule.startTime : null;
                                    selectedValue =
                                        selected ? schedule.id : null;
                                  });
                                },
                                selectedColor: Colors.blue,
                                labelStyle: TextStyle(
                                  color: selectedTime == schedule.startTime
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              );
                            }).toList()),
                        const Spacer(),
                        Center(
                          child: ElevatedButton(
                            onPressed: selectedValue == null
                                ? null
                                : () async {
                                    // scheduleState.maybeMap(
                                    //     orElse: () => const SizedBox(),
                                    //     success: (schedules) {
                                    //       if (_isScheduleIdUsed(
                                    //           appointments:
                                    //               appointmentState.maybeMap(
                                    //                   orElse: () => [],
                                    //                   success: (value) => value
                                    //                       .getAppointmentsData!
                                    //                       .value!),
                                    //           scheduleId: scheduleId!))
                                    //                     ShowSnackbar.showCheckTopSnackBar(
                                    //     context,
                                    //     text:
                                    //         "Appointment already booked",
                                    //     type: SnackBarType.error,
                                    //   );
                                    // } else {
                                    //TODO: add appointment

                                    context.read<AppointmentBloc>().add(
                                          AppointmentEvent.addAppointment(
                                              inputs: AppointmentInputs(
                                            patientId: widget.patientId,
                                            scheduleId: selectedValue!,
                                          )),
                                        );
                                    setState(() {
                                      selectedTime = null;
                                      selectedValue = null;
                                    });
                                    Future.delayed(
                                        const Duration(seconds: 3),
                                        () => context.read<ScheduleBloc>().add(
                                            ScheduleEvent.getSchedulesByDay(
                                                doctorId: widget.doctorId,
                                                dayOfWeek: widget.day)));
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              fixedSize: Size(
                                MediaQuery.sizeOf(context).width * 0.9,
                                50,
                              ),
                            ),
                            child: const Text(
                              'Book Appointment',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ));
        }),
      ),
    );
  }
}
