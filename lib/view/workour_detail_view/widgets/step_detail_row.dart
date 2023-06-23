import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:fitnessapp/utils/app_colors.dart';
import 'package:flutter/material.dart';

class StepDetailRow extends StatelessWidget {
  final Map sObj;
  final bool isLast;
  const StepDetailRow({Key? key, required this.sObj, required this.isLast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 25,
          child: Text(
            sObj["no"].toString(),
            style: const TextStyle(
              color: AppColors.secondaryColor1,
              fontSize: 14,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(

              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor1,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Container(

                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.whiteColor, width: 3),
                  borderRadius: BorderRadius.circular(9),
                ),) ,
            ),
            if (!isLast)
              const DottedDashedLine(
                  height: 80,
                  width: 0,
                  dashColor: AppColors.secondaryColor1,
                  axis: Axis.vertical)
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sObj["title"].toString(),
                style: const TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 14,
                ),
              ),
              Text(
                sObj["detail"].toString(),
                style: const TextStyle(color: AppColors.grayColor, fontSize: 12),
              ),
            ],
          ),
        )
      ],
    );
  }
}
