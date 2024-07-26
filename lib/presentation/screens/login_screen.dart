import 'dart:developer';

import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tot_atomic_design/tot_atomic_design.dart';

import '../../core/routes/routes.dart';
import '../widgets/custom/labled_text_form.dart';
import '../widgets/show_snack_bar.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
              orElse: () {},
              failure: (message) {
                log("Failure $message");
                return ShowSnackbar.showCheckTopSnackBar(
                  context,
                  text: message,
                  type: SnackBarType.error,
                );
              });
        },
        child: Stack(
          children: [
            Image.asset(
              'assets/images/spalsh.png',
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              fit: BoxFit.fill,
            ),
            Positioned(
              top: 50,
              left: 30,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    width: 40,
                    height: 40,
                    color: Theme.of(context).colorScheme.primaryFixed,
                    child: Image.asset(
                      'assets/images/tot_logo.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  const SizedBox(width: 5),
                   Text(
                    '',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryFixed,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: MediaQuery.sizeOf(context).width * 0.15,
              left: MediaQuery.sizeOf(context).width * 0.05,
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isDismissible: true,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(22))),
                      builder: (_) {
                        return const _LogInBtmSheet();
                      });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primaryFixed,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fixedSize: Size(
                    MediaQuery.sizeOf(context).width * 0.9,
                    50,
                  ),
                  // Set the background color here
                ),
                child:  Text(
                  'Login',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogInBtmSheet extends StatefulWidget {
  const _LogInBtmSheet();

  @override
  State<_LogInBtmSheet> createState() => _LogInBtmSheetState();
}

class _LogInBtmSheetState extends State<_LogInBtmSheet> {
  bool isSecure = false;
  double initialChildSize = 0.60;
  late TextEditingController userNameController;
  late TextEditingController passController;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    userNameController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = MediaQuery.viewInsetsOf(context).bottom > 0;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: isKeyboardVisible ? 0.80 : 0.60,
      minChildSize: 0.50,
      maxChildSize: 0.90,
      builder: (context, scrollController) {
        return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
                color: const Color(0xFFefefee),
                borderRadius: BorderRadius.circular(20)),
            child:

                // BlocConsumer<AuthBloc, AuthState>(
                // listener: (context, state) {
                //   state.maybeWhen(
                //     loginSuccess: (model) async {
                //       Navigator.pushNamed(context, LayoutScreen.routeName);
                //       ShowSnackbar.showCheckTopSnackBar(
                //         context,
                //         text: 'You are welcome',
                //         type: SnackBarType.success,
                //       );
                //     },
                //     loginError: () async {
                //       ShowSnackbar.showCheckTopSnackBar(context,
                //           text: 'Please, enter valid user data!',
                //           type: SnackBarType.error);
                //     },
                //     orElse: () {},
                //   );
                // },
                // builder: (context, state) {
                // return
                BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                state.maybeMap(
                  success: (model) async {
                    context.pushNamed(Routes.layout);
                    ShowSnackbar.showCheckTopSnackBar(
                      context,
                      text: 'Welcome, back',
                      type: SnackBarType.success,
                    );
                  },
                  failure: (v) async {
                    ShowSnackbar.showCheckTopSnackBar(
                      context,
                      text: v.message,
                      type: SnackBarType.error,
                    );
                  },
                  orElse: () {},
                );
              },
              builder: (context, state) {
                return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    controller: scrollController,
                    child: Form(
                      key: formKey,
                      child: Column(children: [
                        Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            const Spacer(),
                            const Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                          ],
                        ),
                        LabledTextField(
                          hintText: "Username",
                          controller: userNameController,
                          title: 'Username',
                          validatee: (v) {
                            if (v!.isEmpty) {
                              return 'Please enter user name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Password',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextFormField(
                              controller: passController,
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return 'Please enter pass';
                                }
                                return null;
                              },
                              obscureText: isSecure,
                              cursorColor:
                                  Theme.of(context).colorScheme.primary,
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: "Enter your password",
                                border:  OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer)),
                                focusedBorder:  OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer)),
                                suffixIcon: TOTIconButtonAtom.displayMedium(
                                  codePoint: isSecure ? 0xe6be : 0xe6bd,
                                  iconColor: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  onPressed: () {
                                    setState(
                                      () {
                                        isSecure = !isSecure;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.07,
                        ),
                        ElevatedButton(
                            onPressed: _onPressedMethod,
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
                            child: state.maybeWhen(
                              orElse: () {
                                return  Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryFixed,
                                    fontSize: 16,
                                  ),
                                );
                              },
                              loadInProgress: () {
                                return  SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryFixed,
                                    strokeWidth: 3,
                                  ),
                                );
                              },
                            )

                            // },
                            // loading: () {
                            //
                            // },
                            // ),
                            ),
                      ]),
                    ));
              },
            )
            // },
            );
      },
    );
  }

  void _onPressedMethod() {
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthEvent.login(
              username: userNameController.text,
              password: passController.text,
            ),
          );
    }
  }
}
