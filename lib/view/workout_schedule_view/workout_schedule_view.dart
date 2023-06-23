import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:fitnessapp/common_widgets/round_gradient_button.dart';
import 'package:fitnessapp/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../utils/common.dart';
import 'add_schedule_view.dart';

class WorkoutScheduleView extends StatefulWidget {
  static String routeName = "/WorkoutScheduleView";
  const WorkoutScheduleView({Key? key}) : super(key: key);

  @override
  State<WorkoutScheduleView> createState() => _WorkoutScheduleViewState();
}

class _WorkoutScheduleViewState extends State<WorkoutScheduleView> {

  CalendarAgendaController _calendarAgendaControllerAppBar =
  CalendarAgendaController();
  late DateTime _selectedDateAppBBar;

  List eventArr = [
    {
      "name": "Ab Workout",
      "start_time": "22/06/2023 07:30 AM",
    },
    {
      "name": "Upperbody Workout",
      "start_time": "07/06/2023 09:00 AM",
    },
    {
      "name": "Lowerbody Workout",
      "start_time": "07/06/2023 03:00 PM",
    },
    {
      "name": "Ab Workout",
      "start_time": "08/06/2023 10:30 AM",
    },
    {
      "name": "Upperbody Workout",
      "start_time": "08/06/2023 09:00 AM",
    },
    {
      "name": "Lowerbody Workout",
      "start_time": "08/06/2023 03:00 PM",
    },
    {
      "name": "Ab Workout",
      "start_time": "09/06/2023 07:30 AM",
    },
    {
      "name": "Upperbody Workout",
      "start_time": "09/06/2023 09:00 AM",
    },
    {
      "name": "Lowerbody Workout",
      "start_time": "09/06/2023 03:00 PM",
    }
  ];

  List selectDayEventArr = [];

  @override
  void initState() {
    super.initState();
    _selectedDateAppBBar = DateTime.now();
    setDayEventWorkoutList();
  }

  void setDayEventWorkoutList() {
    var date = dateToStartDate(_selectedDateAppBBar);
    selectDayEventArr = eventArr.map((wObj) {
      return {
        "name": wObj["name"],
        "start_time": wObj["start_time"],
        "date": stringToDate(wObj["start_time"].toString(),
            formatStr: "dd/MM/yyyy hh:mm aa")
      };
    }).where((wObj) {
      return dateToStartDate(wObj["date"] as DateTime) == date;
    }).toList();

    if( mounted  ) {
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
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
        title: Text(
          "Workout Schedule",
          style: TextStyle(
              color: AppColors.blackColor, fontSize: 16, fontWeight: FontWeight.w700),
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
                width: 15,
                height: 15,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CalendarAgenda(
            controller: _calendarAgendaControllerAppBar,
            appbar: false,
            selectedDayPosition: SelectedDayPosition.center,
            leading: IconButton(
                onPressed: () {

                },
                icon: Image.asset(
                  "assets/icons/ArrowLeft.png",
                  width: 15,
                  height: 15,
                )),
            training: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/icons/ArrowRight.png",
                  width: 15,
                  height: 15,
                )),
            weekDay: WeekDay.short,
            dayNameFontSize: 12,
            dayNumberFontSize: 16,
            dayBGColor: Colors.grey.withOpacity(0.15),
            titleSpaceBetween: 15,
            backgroundColor: Colors.transparent,
            // fullCalendar: false,
            fullCalendarScroll: FullCalendarScroll.horizontal,
            fullCalendarDay: WeekDay.short,
            selectedDateColor: Colors.white,
            dateColor: Colors.black,
            locale: 'en',

            initialDate: DateTime.now(),
            calendarEventColor: AppColors.primaryColor2,
            firstDate: DateTime.now().subtract(const Duration(days: 140)),
            lastDate: DateTime.now().add(const Duration(days: 60)),

            onDateSelected: (date) {
              _selectedDateAppBBar = date;
              setDayEventWorkoutList();

            },
            selectedDayLogo: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: AppColors.primaryG,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: media.width * 1.5,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var timelineDataWidth = (media.width * 1.5) - (80 + 40);
                      var availWidth = (media.width * 1.2) - (80 + 40);
                      var slotArr = selectDayEventArr.where((wObj) {
                        return (wObj["date"] as DateTime).hour == index;
                      }).toList();

                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 80,
                              child: Text(
                                getTime(index * 60),
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            if (slotArr.isNotEmpty)
                              Expanded(
                                  child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: slotArr.map((sObj) {
                                      var min = (sObj["date"] as DateTime).minute;
                                      //(0 to 2)
                                      var pos = (min / 60) * 2 - 1;

                                      return Align(
                                        alignment: Alignment(pos, 0),
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.transparent,
                                                  contentPadding: EdgeInsets.zero,
                                                  content: Container(
                                                    padding: const EdgeInsets.symmetric( vertical:15 , horizontal: 20 ),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.whiteColor,
                                                      borderRadius:
                                                      BorderRadius.circular(20),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                margin:
                                                                const EdgeInsets
                                                                    .all(8),
                                                                height: 40,
                                                                width: 40,
                                                                alignment:
                                                                Alignment.center,
                                                                decoration: BoxDecoration(
                                                                    color: AppColors
                                                                        .lightGrayColor,
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        10)),
                                                                child: Image.asset(
                                                                  "assets/icons/closed_btn.png",
                                                                  width: 15,
                                                                  height: 15,
                                                                  fit: BoxFit.contain,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              "Workout Schedule",
                                                              style: TextStyle(
                                                                  color: AppColors.blackColor,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                            ),
                                                            InkWell(
                                                              onTap: () {},
                                                              child: Container(
                                                                margin:
                                                                const EdgeInsets
                                                                    .all(8),
                                                                height: 40,
                                                                width: 40,
                                                                alignment:
                                                                Alignment.center,
                                                                decoration: BoxDecoration(
                                                                    color: AppColors
                                                                        .lightGrayColor,
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        10)),
                                                                child: Image.asset(
                                                                  "assets/icons/more_icon.png",
                                                                  width: 15,
                                                                  height: 15,
                                                                  fit: BoxFit.contain,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        Text(
                                                          sObj["name"].toString(),
                                                          style: TextStyle(
                                                              color: AppColors.blackColor,
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight.w700),
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Row(children: [
                                                          Image.asset(
                                                            "assets/icons/time_workout.png",
                                                            height: 20,
                                                            width: 20,
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            "${ getDayTitle(sObj["start_time"].toString()) }|${getStringDateToOtherFormate(sObj["start_time"].toString(), outFormatStr: "h:mm aa")}",
                                                            style: TextStyle(
                                                                color: AppColors.grayColor,
                                                                fontSize: 12),
                                                          )
                                                        ]),

                                                        const SizedBox(
                                                          height: 15,
                                                        ),

                                                        RoundGradientButton(
                                                            title: "Mark Done",
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            }),

                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            height: 35,
                                            width: availWidth * 0.5,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: AppColors.secondaryG),
                                              borderRadius:
                                              BorderRadius.circular(17.5),
                                            ),
                                            child: Text(
                                              "${sObj["name"].toString()}, ${getStringDateToOtherFormate(sObj["start_time"].toString(), outFormatStr: "h:mm aa")}",
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: AppColors.whiteColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ))
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: AppColors.grayColor.withOpacity(0.2),
                        height: 1,
                      );
                    },
                    itemCount: 24),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddScheduleView(
                    date: _selectedDateAppBBar,
                  )));
        },
        child: Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: AppColors.secondaryG),
              borderRadius: BorderRadius.circular(27.5),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))
              ]),
          alignment: Alignment.center,
          child: Icon(
            Icons.add,
            size: 20,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
