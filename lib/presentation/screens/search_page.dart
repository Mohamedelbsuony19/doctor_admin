import 'package:clinic_admin/presentation/widgets/empty_data_widget.dart';
import 'package:clinic_admin/presentation/widgets/enter_to_search_widget.dart';
import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/routes/routes.dart';
import '../widgets/doctor_item.dart';
import '../widgets/tot_text_form_filed_search_atom.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
        title: const Text("Search"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              TotTextFormFiledSearchAtom(
                focusedBorderColor: Theme.of(context).colorScheme.primary,
                controller: searchController,
                radius: 16,
                isPrefix: true,
                borderColor: Theme.of(context).colorScheme.surfaceDim,
                onChanged: (p0) {
                  context.read<SearchBloc>().add(
                        SearchEvent.searchDoctorByText(
                          text: p0!,
                        ),
                      );
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<DoctorBloc, DoctorState>(
                builder: (context, doctorState) {
                  return doctorState.maybeMap(
                    orElse: () => const SizedBox(),
                    loadInProgress: (state) {
                      return const Center(child: CircularProgressIndicator());
                    },
                    success: (doctorValue) {
                      return BlocBuilder<SearchBloc, SearchState>(
                        builder: (context, state) {
                          return state.maybeMap(
                              orElse: () => const EnterToSearchWidget(),
                              loadInProgress: (state) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              success: (searchValue) {
                                if (searchValue.doctors?.value?.data?.isEmpty ??
                                    true) {
                                  return const EmptyDataWidget();
                                }
                                return SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.75,
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: searchValue
                                              .doctors?.value?.data?.length ??
                                          0,
                                      itemBuilder: ((context, index) {
                                        return DoctorItem(
                                                                                color: Theme.of(context).colorScheme.secondaryContainer,

                                          imagePath:
                                              "assets/images/app_logo.png",
                                          doctorDescription: searchValue
                                                  .doctors
                                                  ?.value
                                                  ?.data?[index]
                                                  .doctorEmail ??
                                              "",
                                          doctorName: searchValue
                                                  .doctors
                                                  ?.value!
                                                  .data?[index]
                                                  .userName ??
                                              "",
                                          doctorType: searchValue
                                                  .doctors
                                                  ?.value
                                                  ?.data?[index]
                                                  .specialization
                                                  ?.specializationName ??
                                              "",
                                          onTap: () {
                                            if (searchValue.doctors?.value
                                                    ?.data?[index].id !=
                                                null) {
                                              context.pushNamed(
                                                  Routes.doctorDetails,
                                                  extra: searchValue.doctors
                                                      ?.value?.data?[index].id);
                                            }
                                          },
                                        );
                                      })),
                                );
                              });
                        },
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
