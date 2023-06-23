import 'package:fitnessapp/utils/app_colors.dart';
import 'package:flutter/material.dart';

class LatestActivityRow extends StatelessWidget {
  final Map wObj;
  const LatestActivityRow({Key? key, required this.wObj}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),

        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                wObj["image"].toString(),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 15,),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wObj["title"].toString(),
                      style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),

                    Text(
                      wObj["time"].toString(),
                      style: TextStyle(
                        color: AppColors.grayColor,
                        fontSize: 10,),
                    ),



                  ],
                )),
            IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/icons/sub_menu_icon.png",
                  width: 12,
                  height: 12,
                  fit: BoxFit.contain,
                ))
          ],
        ));
  }
}
