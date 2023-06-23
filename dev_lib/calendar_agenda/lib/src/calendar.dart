import 'dart:convert';

import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'fullcalendar.dart';
import 'typedata.dart';

class CalendarAgenda extends StatefulWidget implements PreferredSizeWidget {
  final CalendarAgendaController? controller;

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function onDateSelected;

  final Color? backgroundColor;
  final SelectedDayPosition selectedDayPosition;
  final Color? selectedDateColor;
  final Color? dateColor;
  final Color? calendarBackground;
  final Color? calendarEventSelectedColor;
  final Color? calendarEventColor;
  final Color? dayBGColor;
  final FullCalendarScroll fullCalendarScroll;
  final Widget? calendarLogo;
  final Widget? selectedDayLogo;
  final double dayNumberFontSize;
  final double dayNameFontSize;
  final double titleSpaceBetween;

  final String? locale;
  final bool? fullCalendar;
  final WeekDay fullCalendarDay;
  final double? padding;
  final Widget? leading;
  final Widget? training;
  final WeekDay weekDay;
  final bool appbar;
  final double leftMargin;
  final List<DateTime>? events;

  CalendarAgenda({
    Key? key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
    this.backgroundColor,
    this.selectedDayLogo,
    this.controller,
    this.selectedDateColor = Colors.black,
    this.dateColor = Colors.white,
    this.calendarBackground = Colors.white,
    this.calendarEventSelectedColor = Colors.white,
    this.calendarEventColor = Colors.blue,
    this.dayBGColor,
    this.calendarLogo,
    this.locale = 'en',
    this.padding,
    this.leading,
    this.training,
    this.dayNumberFontSize = 22,
    this.dayNameFontSize = 12,
    this.titleSpaceBetween = 10,
    this.appbar = false,
    this.events,
    this.fullCalendar = true,
    this.leftMargin = 0,
    this.fullCalendarScroll = FullCalendarScroll.vertical,
    this.fullCalendarDay = WeekDay.short,
    this.weekDay = WeekDay.short,
    this.selectedDayPosition = SelectedDayPosition.left,
  })  : assert(
          initialDate.difference(firstDate).inDays >= 0,
          'initialDate must be on or after firstDate',
        ),
        assert(
          !initialDate.isAfter(lastDate),
          'initialDate must be on or before lastDate',
        ),
        assert(
          !firstDate.isAfter(lastDate),
          'lastDate must be on or after firstDate',
        ),
        super(key: key);

  @override
  CalendarAgendaState createState() => CalendarAgendaState();

  @override
  Size get preferredSize => new Size.fromHeight(250.0);
}

class CalendarAgendaState extends State<CalendarAgenda>
    with TickerProviderStateMixin {
  ItemScrollController _scrollController = new ItemScrollController();

  late Color backgroundColor;
  late double padding;
  late Widget leading;
  late Widget training;
  late double _scrollAlignment;

  List<String> _eventDates = [];
  List<DateTime> _dates = [];
  DateTime? _selectedDate;
  int? _daySelectedIndex;

  String get _locale =>
      widget.locale ?? Localizations.localeOf(context).languageCode;

  static String uri =
      'data:image/jpeg;base64,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';

  @override
  void initState() {
    super.initState();
    initializeDateFormatting(_locale);
    _initCalendar();
    padding = widget.padding ?? 25.0;
    leading = widget.leading ?? Container();
    training = widget.training ?? Container();
    _scrollAlignment = widget.leftMargin / 440;

    if (widget.events != null) {
      for (var element in widget.events!) {
        _eventDates.add(element.toString().split(" ").first);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    backgroundColor = widget.backgroundColor ?? Theme.of(context).primaryColor;

    Widget dayList() {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: widget.appbar ? 125 : 110,
        padding: EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.bottomCenter,
        child: ScrollablePositionedList.builder(
            padding: _dates.length < 5
                ? EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width *
                        (5 - _dates.length) /
                        10)
                : const EdgeInsets.symmetric(horizontal: 10),
            initialScrollIndex: _daySelectedIndex ?? 0,
            // initialAlignment: _scrollAlignment,
            initialAlignment:
                widget.selectedDayPosition == SelectedDayPosition.center
                    ? 78 / 200
                    : _scrollAlignment,
            scrollDirection: Axis.horizontal,
            reverse: widget.selectedDayPosition == SelectedDayPosition.left
                ? false
                : true,
            itemScrollController: _scrollController,
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemCount: _dates.length,
            itemBuilder: (context, index) {
              DateTime date = _dates[index];
              bool isSelected = _daySelectedIndex == index;

              return Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 5.0),
                    child: GestureDetector(
                      onTap: () => _goToActualDay(index),
                      child: Container(
                        height: 100.0,
                        width: MediaQuery.of(context).size.width / 5 - 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: isSelected ? Colors.white : widget.dayBGColor,
                          boxShadow: [
                            isSelected
                                ? BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: Offset(0, 1),
                                  )
                                : BoxShadow(
                                    color: Colors.grey.withOpacity(0.0),
                                    spreadRadius: 5,
                                    blurRadius: 20,
                                    offset: Offset(0, 3),
                                  )
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if (isSelected && widget.selectedDayLogo != null)
                              widget.selectedDayLogo!,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _eventDates.contains(
                                        date.toString().split(" ").first)
                                    ? isSelected
                                        ? Icon(
                                            Icons.bookmark,
                                            size: 16,
                                            color: isSelected
                                                ? widget.selectedDateColor
                                                : widget.dateColor!
                                                    .withOpacity(0.5),
                                          )
                                        : Icon(
                                            Icons.bookmark,
                                            size: 8,
                                            color: isSelected
                                                ? widget.calendarEventColor
                                                : widget.dateColor!
                                                    .withOpacity(0.5),
                                          )
                                    : SizedBox(
                                        height: 5.0,
                                      ),
                                SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  widget.weekDay == WeekDay.long
                                      ? DateFormat.EEEE(
                                              Locale(_locale).toString())
                                          .format(date)
                                      : DateFormat.E(Locale(_locale).toString())
                                          .format(date),
                                  style: TextStyle(
                                    fontSize: widget.dayNameFontSize,
                                    color: isSelected
                                        ? widget.selectedDateColor
                                        : widget.dateColor,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: widget.titleSpaceBetween),
                                Text(
                                  DateFormat("dd").format(date),
                                  style: TextStyle(
                                      fontSize: widget.dayNumberFontSize,
                                      color: isSelected
                                          ? widget.selectedDateColor
                                          : widget.dateColor,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: widget.appbar ? 210 : 140.0,
      child: Stack(
        children: [
          Positioned(
            top: 0.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 190.0,
              color: backgroundColor,
            ),
          ),
          Positioned(
            top: widget.appbar ? 50.0 : 0.0,
            child:  Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    leading,
                    widget.fullCalendar!
                        ? GestureDetector(
                            onTap: () => widget.fullCalendar!
                                ? _showFullCalendar(_locale, widget.weekDay)
                                : null,
                            child: Row(
                              children: [
                                Text(
                                  DateFormat.yMMMM(Locale(_locale).toString())
                                      .format(_selectedDate!),
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: widget.dateColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                    training
                  ],
                ),
              ),
            
          ),
          Positioned(
            bottom: 0.0,
            child: dayList(),
          ),
        ],
      ),
    );
  }

  _generateDates() {
    _dates.clear();

    DateTime first = DateTime.parse(
        "${widget.firstDate.toString().split(" ").first} 00:00:00.000");

    DateTime last = DateTime.parse(
        "${widget.lastDate.toString().split(" ").first} 23:00:00.000");

    DateTime basicDate =
        DateTime.parse("${first.toString().split(" ").first} 12:00:00.000");

    List<DateTime> listDates = List.generate(
        (last.difference(first).inHours / 24).round(),
        (index) => basicDate.add(Duration(days: index)));

    widget.selectedDayPosition == SelectedDayPosition.left
        ? listDates.sort((b, a) => b.compareTo(a))
        : listDates.sort((b, a) => a.compareTo(b));

    setState(() {
      _dates = listDates;
    });
  }

  _showFullCalendar(String locale, WeekDay weekday) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext context) {
        double height;
        DateTime? endDate = widget.lastDate;

        if (widget.firstDate.year == endDate.year &&
            widget.firstDate.month == endDate.month) {
          height = ((MediaQuery.of(context).size.width - 2 * padding) / 7) * 5 +
              150.0;
        } else {
          height = (MediaQuery.of(context).size.height - 100.0);
        }
        return Container(
          height: widget.fullCalendarScroll == FullCalendarScroll.vertical
              ? height
              : (MediaQuery.of(context).size.height / 7) * 4.3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Container(
                width: 60,
                height: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: Color(0xFFE0E0E0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: FullCalendar(
                  startDate: widget.firstDate,
                  endDate: endDate,
                  padding: padding,
                  dateColor: widget.dateColor,
                  dateSelectedBg: widget.calendarEventColor,
                  dateSelectedColor: widget.calendarEventSelectedColor,
                  events: _eventDates,
                  selectedDate: _selectedDate,
                  fullCalendarDay: widget.fullCalendarDay,
                  calendarScroll: widget.fullCalendarScroll,
                  calendarBackground: widget.calendarLogo,
                  locale: locale,
                  onDateChange: (value) {
                    getDate(value);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _selectedDay() {
    DateTime getSelected = DateTime.parse(
        "${_selectedDate.toString().split(" ").first} 00:00:00.000");

    _daySelectedIndex = _dates.indexOf(_dates.firstWhere((dayDate) =>
        DateTime.parse("${dayDate.toString().split(" ").first} 00:00:00.000") ==
        getSelected));
  }

  _goToActualDay(int index) {
    _moveToDayIndex(index);
    setState(() {
      _daySelectedIndex = index;
      _selectedDate = _dates[index];
    });
    widget.onDateSelected(_selectedDate);
  }

  void _moveToDayIndex(int index) {
    _scrollController.scrollTo(
      index: index,
      alignment: widget.selectedDayPosition == SelectedDayPosition.center
          ? 78 / 200
          : _scrollAlignment,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void getDate(DateTime value) {
    setState(() {
      _selectedDate = value;
    });
    _selectedDay();
    _goToActualDay(_daySelectedIndex!);
  }

  _initCalendar() {
    if (widget.controller != null &&
        widget.controller is CalendarAgendaController) {
      widget.controller!.bindState(this);
    }
    _selectedDate = widget.initialDate;
    _generateDates();
    _selectedDay();
  }
}
