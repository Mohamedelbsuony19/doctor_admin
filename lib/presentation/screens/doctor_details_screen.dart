import 'dart:developer';

import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/routes/routes.dart';
import '../widgets/show_snack_bar.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final String id;
  const DoctorDetailsScreen({super.key, required this.id});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

List<String> doctorsPhoto = [
  "assets/images/doctor1.jpg",
  "assets/images/doctor2.jpg",
  "assets/images/doctor3.jpg",
  "assets/images/doctor4.jpg",
];

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  String? date;
  String? startTime;
  String? endTime;
  String? selectedValue;
  String? selectedPatientId;
  int? scheduleId;

  @override
  @override
  void initState() {
    context.read<DoctorBloc>().add(DoctorEvent.getDoctorById(id: widget.id));
    context
        .read<ScheduleBloc>()
        .add(ScheduleEvent.getSchedulesByDoctorId(doctorId: widget.id));
    super.initState();
  }

  final List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentBloc, AppointmentState>(
      listener: (context, appointmentState) {
        appointmentState.maybeMap(
          orElse: () {},
          success: (value) {
            if (value.isAdded) {
              ShowSnackbar.showCheckTopSnackBar(context,
                  text: 'Appointment created successfully',
                  type: SnackBarType.success);
              context
                  .read<AppointmentBloc>()
                  .add(const AppointmentEvent.getAppointments());
            }
          },
          failed: (message) {
            ShowSnackbar.showCheckTopSnackBar(context,
                text: "There was an error", type: SnackBarType.error);
          },
        );
      },
      builder: (context, appointmentState) {
        return BlocBuilder<DoctorBloc, DoctorState>(
          builder: (context, state) {
            doctorsPhoto.shuffle();
            return BlocBuilder<ScheduleBloc, ScheduleState>(
              builder: (context, scheduleState) {
                return state.maybeMap(
                    orElse: () => const SizedBox(),
                    loadInProgress: (state) =>
                        const Center(child: CircularProgressIndicator()),
                    success: (value) {
                      final List<PatientEntity> patients =
                          context.read<PatientsBloc>().state.maybeMap(
                                success: (value) => value.patients,
                                orElse: () => [],
                              );
                      if (value.isLoading) {
                        return const Scaffold(
                            body: Center(child: CircularProgressIndicator()));
                      }

                      return Scaffold(
                        appBar: AppBar(
                            title: Text(value.doctor?.value?.userName ?? "")),
                        body: Container(
                          padding: const EdgeInsets.all(10),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image.asset(
                                    doctorsPhoto.first,
                                    height: 300,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.9,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi.',
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Doctor Name',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  value.doctor?.value?.userName ?? "",
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Cost',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  "200",
                                  style: TextStyle(fontSize: 15),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Doctor Type',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  value.doctor?.value?.specialization
                                          ?.specializationName ??
                                      "",
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const SizedBox(height: 20),
                                 Center(
                                  child: Text(
                                    'Select Patient',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  hint: const Text("Select Patient"),
                                  items: patients.map((patient) {
                                    return DropdownMenuItem(
                                      value: patient.id,
                                      child: Text(
                                        patient.patientFirstName ?? "",
                                        style:  TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value.toString();
                                      selectedPatientId = value.toString();
                                    });
                                    log("$selectedPatientId");
                                  },
                                ),
                                const SizedBox(height: 20),
                                 Center(
                                  child: Text(
                                    'Select Day',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                scheduleState.maybeMap(
                                    orElse: () => const Center(
                                        child: CircularProgressIndicator()),
                                    success: (successState) {
                                      return successState.schedules.isEmpty
                                          ? const Center(
                                              child: Text(
                                                  "No Available schedules"))
                                          : SizedBox(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.15,
                                              child: ListView.builder(
                                                  itemCount: successState
                                                      .schedules.length,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return SizedBox(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width /
                                                          2.5,
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            //TODO: navigate to appointment Details

                                                            if (selectedPatientId ==
                                                                null) {
                                                              ShowSnackbar
                                                                  .showCheckTopSnackBar(
                                                                context,
                                                                text:
                                                                    "Please select patient",
                                                                type:
                                                                    SnackBarType
                                                                        .error,
                                                              );
                                                            } else {
                                                              context.pushNamed(
                                                                  Routes
                                                                      .appointmentDetails,
                                                                  extra: AppointmentData(
                                                                      patientId:
                                                                          selectedPatientId!,
                                                                      doctorId:
                                                                          widget
                                                                              .id,
                                                                      day: successState
                                                                          .schedules[
                                                                              index]
                                                                          .dayOfWeek!));
                                                            }
                                                          },
                                                          child: Card(
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            elevation: 5,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    weekdays[successState
                                                                        .schedules[
                                                                            index]
                                                                        .dayOfWeek!],
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .blue,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "From: ${successState.schedules[index].startTime}",
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black87,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "To: ${successState.schedules[index].endTime}",
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black87,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )),
                                                    );
                                                  }),
                                            );
                                    }),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            );
          },
        );
      },
    );
  }

  bool _isScheduleIdUsed(
      {required List<AppointmentEntity> appointments,
      required int scheduleId}) {
    for (AppointmentEntity appointment in appointments) {
      if (appointment.scheduleId == scheduleId) {
        return true;
      }
    }
    return false;
  }
}
