import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tot_atomic_design/tot_atomic_design.dart';

import '../../core/routes/routes.dart';
import '../widgets/doctor_item.dart';
import '../widgets/section_header_widget.dart';
import '../widgets/tot_text_form_filed_search_atom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final bool hasNextPage = context.read<DoctorBloc>().state.maybeMap(
        orElse: () => false, success: (value) => value.hasNextPage ?? true);
    if (!hasNextPage) return;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    if (currentScroll >= (maxScroll * 0.20)) {
      context.read<DoctorBloc>().add(const DoctorEvent.getAllDoctors());
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? userName = preferences.getString(SharedKeys.userName);
    return Scaffold(
        body: SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.only(top: 50, bottom: 30),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, $userName",
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Doctors",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      "assets/images/clinc_logo.png",
                      width: 50,
                      height: 50,
                    )
                  ]),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TotTextFormFiledSearchAtom(
                onTap: () => context.pushNamed(Routes.search),
                focusedBorderColor: Theme.of(context).colorScheme.primary,
                controller: searchController,
                radius: 16,
                isPrefix: true,
                borderColor: Theme.of(context).colorScheme.surfaceDim,
                onChanged: (p0) {
                  // context.pushNamed(Routes.search);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  return state.maybeMap(orElse: () {
                    return Container();
                  }, loadInProgress: (value) {
                    return const CircularProgressIndicator.adaptive();
                  }, success: (value) {
                    return SectionHeaderWidget(
                      subTitlePadding: const EdgeInsets.all(0),
                      titlePadding: const EdgeInsets.symmetric(vertical: 0),
                      size: 16,
                      titleFontWeight: FontWeight.w400,
                      showButton: true,
                      title: 'Categories',
                      // subtitle: 'View all',
                      subTitleColor: Theme.of(context).colorScheme.surfaceDim,
                      onTap: () {},
                      // themeIcon: Icons.keyboard_arrow_right_sharp,
                      iconSize: 30,
                    );
                  });
                },
              ),
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                return state.maybeMap(
                  orElse: () {
                    return Container();
                  },
                  loadInProgress: (value) {
                    return const CircularProgressIndicator.adaptive();
                  },
                  success: (value) {
                    return Container(
                      height: 100,
                      margin: const EdgeInsets.only(top: 20.0),
                      alignment: Alignment.topLeft,
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: value.categories?.value?.data?.length ?? 0,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              context.pushNamed(Routes.category, extra: {
                                "categoryId": value
                                        .categories?.value?.data?[index].id
                                        .toString() ??
                                    "",
                                "categoryName": value.categories?.value
                                        ?.data?[index].specializationName ??
                                    ""
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: const TOTImageAtom.asset(
                                      "assets/images/clinc_logo.png",
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  TOTTextAtom.titleMedium(
                                    value.categories?.value?.data?[index]
                                            .specializationName ??
                                        "",
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SectionHeaderWidget(
                subTitlePadding: const EdgeInsets.all(0),
                titlePadding: const EdgeInsets.symmetric(vertical: 0),
                size: 16,
                titleFontWeight: FontWeight.w400,
                showButton: true,
                title: 'Recommendation',
                // subtitle: 'View all',
                subTitleColor: Theme.of(context).colorScheme.surfaceDim,
                onTap: () {},
                // themeIcon: Icons.keyboard_arrow_right_sharp,
                iconSize: 30,
              ),
            ),
            BlocBuilder<DoctorBloc, DoctorState>(
              builder: (context, state) {
                return state.maybeMap(orElse: () {
                  return Container();
                }, loadInProgress: (value) {
                  return const CircularProgressIndicator.adaptive();
                }, success: (value) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.48,
                    child: value.doctors!.isEmpty
                        ? const Center(
                            child: Text("No Doctors found."),
                          )
                        : CustomScrollView(
                            controller: scrollController,
                            slivers: [
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    final doctors = value.doctors;
                                    if (doctors == null || doctors.isEmpty) {
                                      return const CircularProgressIndicator
                                          .adaptive();
                                    }

                                    final doctor = doctors[index];
                                    return DoctorItem(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
                                      imagePath: "assets/images/app_logo.png",
                                      doctorDescription:
                                          doctor.doctorEmail ?? "",
                                      doctorName:
                                          "Dr / ${doctors[index].userName ?? ""}",
                                      doctorType: doctor.specialization
                                              ?.specializationName ??
                                          "",
                                      onTap: () {
                                        if (doctor.id != null) {
                                          context.pushNamed(
                                              Routes.doctorDetails,
                                              extra: doctor.id);
                                        }
                                      },
                                    );
                                  },
                                  childCount: value.doctors?.length ?? 0,
                                ),
                              ),
                            ],
                          ),
                  );
                });
              },
            )
          ],
        ),
      ),
    ));
  }
}
