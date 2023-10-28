import 'package:cron/cron.dart';

class CronSchedule {
  static final cron = Cron();
  static Map<int, ScheduledTask?> activeCrons = {};
  static Map<int, int> cronCounter = {};

  static void createCron(String cronExpression, int cronID, Function function) {
    activeCrons[cronID] = cron.schedule(Schedule.parse(cronExpression), () {
      function();
    });
  }

  static void endCron(int cronID) {
    activeCrons[cronID]!.cancel();
    activeCrons[cronID] = null;
  }
}
