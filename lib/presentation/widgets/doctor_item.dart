import 'package:flutter/material.dart';

class DoctorItem extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String imagePath;
  final String doctorName;
  final String doctorType;
  final String doctorDescription;
  final String? price;
  final bool? showPrice;
  final Color? color;

  const DoctorItem({
    super.key,
    this.onTap,
    required this.imagePath,
    required this.doctorName,
    required this.doctorDescription,
    required this.doctorType,
    this.price,
    this.showPrice = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 65,
              height: 65,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.07,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  doctorDescription,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                Text(
                  doctorType,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
            const Spacer(),
            showPrice!
                ? Text("$price EGP",
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.bold))
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
