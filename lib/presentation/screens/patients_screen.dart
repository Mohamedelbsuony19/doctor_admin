import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/doctor_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchController;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Patients"),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            context.read<PatientsBloc>().add(const PatientsEvent.getAll()),
        child: Column(
          children: [
            BlocBuilder<PatientsBloc, PatientsState>(
              builder: (context, state) {
                return state.maybeMap(orElse: () {
                  return Container();
                }, loading: (value) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }, success: (value) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.8,
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: value.patients.length,
                        itemBuilder: ((context, index) {
                          return DoctorItem(
                                                                  color: Theme.of(context).colorScheme.secondaryContainer,

                            imagePath: "assets/images/app_logo.png",
                            doctorDescription:
                                value.patients[index].patientEmail ?? "",
                            doctorName:
                                "${value.patients[index].patientFirstName} ${value.patients[index].patientLastName}",
                            doctorType: "",
                            // onTap: () {
                            //   if (value.patientEntity?.value![index].id != null) {
                            //     context.pushNamed(Routes.doctorDetails,
                            //         extra: value.doctors?.value?[index].id);
                            //   }
                            // },
                          );
                        })),
                  );
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
