import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tot_atomic_design/tot_atomic_design.dart';

import '../../core/routes/routes.dart';
import '../widgets/profile_item.dart';
import '../widgets/validation_alert_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf4f5f8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const TOTAvatarAtom.asset('assets/images/clinc_logo.png'),
            const SizedBox(
              width: 10,
            ),
            Text('Hi, ${preferences.getString(SharedKeys.userName) ?? ""}'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const SizedBox(height: 10),
          ProfileItem(
            iconCode: 0xe3b3,
            text: "Logout",
            hasNotification: false,
            onPressed: () async {
              showValidationDialog(
                context,
                validationName: "Logout",
                itemName: "",
                onYesPressed: () {
                  preferences.clear();
                  context.go(Routes.login.withSlash);
                },
              );
            },
          ),

        ]),
      ),
    );
  }
}
