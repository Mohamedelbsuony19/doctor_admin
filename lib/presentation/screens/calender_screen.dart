import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/doctor_item.dart';
import '../widgets/validation_alert_dialog.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    context
        .read<AppointmentBloc>()
        .add(const AppointmentEvent.getAppointments());
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Appointments"),
      ),
      body: BlocConsumer<AppointmentBloc, AppointmentState>(
        listener: (context, state) {
          state.maybeMap(
              orElse: () {},
              success: (value) {
                if (value.isAdded == true || value.isDeleted == true) {
                  context
                      .read<AppointmentBloc>()
                      .add(const AppointmentEvent.getAppointments());
                }
              });
        },
        builder: (context, state) {
          return state.maybeMap(
            orElse: () => Container(),
            success: (value) {
              final appointment = value.appointments;

              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: appointment.length,
                itemBuilder: ((context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.surfaceDim)),
                    width: double.infinity,
                    child: Column(
                      children: [
                        DoctorItem(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          imagePath: "assets/images/app_logo.png",
                          doctorDescription: appointment[index].patientName,
                          doctorName:
                              "${appointment[index].doctorName} \t(${appointment[index].status})",
                          doctorType: appointment[index].startTime,
                          onTap: () {},
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(appointment[index]
                                        .date
                                        .substring(0, 10)),
                                  ],
                                ),
                                SizedBox(
                                    width: MediaQuery.sizeOf(context).width *
                                        0.12),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time_rounded),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(appointment[index].startTime),
                                  ],
                                ),
                                SizedBox(
                                    width: MediaQuery.sizeOf(context).width *
                                        0.09),
                                Row(
                                  children: [
                                    const Icon(Icons.share_arrival_time_sharp),
                                    SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.025),
                                    Text(
                                      appointment[index].endTime,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        appointment[index].status != "Scheduled"
                            ? const SizedBox()
                            : Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width *
                                        0.877,
                                    child: ElevatedButton(
                                        onPressed: appointment[index].status ==
                                                "Canceled"
                                            ? null
                                            : () {
                                                showValidationDialog(context,
                                                    itemName: "appointment",
                                                    onYesPressed: () => context
                                                        .read<AppointmentBloc>()
                                                        .add(
                                                          AppointmentEvent
                                                              .deleteAppointment(
                                                            id: appointment[
                                                                    index]
                                                                .id
                                                                .toString(),
                                                          ),
                                                        ));
                                              },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red.shade300,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                            10,
                                          )),
                                          fixedSize: Size(
                                            MediaQuery.sizeOf(context).width *
                                                0.35,
                                            50,
                                          ),
                                        ),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        )),
                                  ),
                                ],
                              )
                      ],
                    ),
                  );
                }),
              );
            },
          );
        },
      ),
    );
  }
}
