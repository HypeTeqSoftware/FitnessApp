import 'calendar.dart';

// CalendarController
class CalendarAgendaController {
  CalendarAgendaState? state;

  void bindState(CalendarAgendaState state) {
    this.state = state;
  }

  void goToDay(DateTime date) {
    state!.getDate(date);
  }

  void dispose() {
    state = null;
  }
}
