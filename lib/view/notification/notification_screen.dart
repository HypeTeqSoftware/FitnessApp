import 'package:fitnessapp/utils/app_colors.dart';
import 'package:fitnessapp/view/notification/widgets/notification_row.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  static String routeName = "/NotificationScreen";

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List notificationArr = [
    {
      "image": "assets/images/Workout1.png",
      "title": "Hey, it’s time for lunch",
      "time": "About 1 minutes ago"
    },
    {
      "image": "assets/images/Workout2.png",
      "title": "Don’t miss your lowerbody workout",
      "time": "About 3 hours ago"
    },
    {
      "image": "assets/images/Workout3.png",
      "title": "Hey, let’s add some meals for your b",
      "time": "About 3 hours ago"
    },
    {
      "image": "assets/images/Workout1.png",
      "title": "Congratulations, You have finished A..",
      "time": "29 May"
    },
    {
      "image": "assets/images/Workout2.png",
      "title": "Hey, it’s time for lunch",
      "time": "8 April"
    },
    {
      "image": "assets/images/Workout3.png",
      "title": "Ups, You have missed your Lowerbo...",
      "time": "8 April"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          centerTitle: true,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.lightGrayColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                "assets/icons/back_icon.png",
                width: 15,
                height: 15,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: const Text(
            "Notification",
            style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
          actions: [
            InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(8),
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColors.lightGrayColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Image.asset(
                  "assets/icons/more_icon.png",
                  width: 12,
                  height: 12,
                  fit: BoxFit.contain,
                ),
              ),
            )
          ],
        ),
        body: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            itemBuilder: ((context, index) {
              var nObj = notificationArr[index] as Map? ?? {};
              return NotificationRow(nObj: nObj);
            }),
            separatorBuilder: (context, index) {
              return Divider(
                color: AppColors.grayColor.withOpacity(0.5),
                height: 1,
              );
            },
            itemCount: notificationArr.length));
  }
}
