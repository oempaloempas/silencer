import 'package:logger/logger.dart';

class Logging {
  static final Logger _logger = Logger(printer: PrettyPrinter());
  static final Logger _noTraceLogger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
  ));

  static void traceLog(String traceMessage, {bool trace = true}) {
    if (trace) {
      _logger.t(traceMessage);
    } else {
      _noTraceLogger.t(traceMessage);
    }
  }

  static void debugLog(String debugMessage, {bool trace = true}) {
    if (trace) {
      _logger.d(debugMessage);
    } else {
      _noTraceLogger.d(debugMessage);
    }
  }

  static void infoLog(String infoMessage, {bool trace = true}) {
    if (trace) {
      _logger.i(infoMessage);
    } else {
      _noTraceLogger.i(infoMessage);
    }
  }

  static void warningLog(String warningMessage, {bool trace = true}) {
    if (trace) {
      _logger.w(warningMessage);
    } else {
      _noTraceLogger.w(warningMessage);
    }
  }

  static void errorLog(String errorMessage, {bool trace = true}) {
    if (trace) {
      _logger.e(errorMessage);
    } else {
      _noTraceLogger.e(errorMessage);
    }
  }

  static void changeLogLevel(Level loglevel) {
    Logger.level = loglevel;
  }
}
