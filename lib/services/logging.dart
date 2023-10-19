import 'package:logger/logger.dart';

class Logging {
  static final _logger = Logger();

  static void traceLog(String traceMessage) {
    _logger.t(traceMessage);
  }

  static void debugLog(String debugMessage) {
    _logger.d(debugMessage);
  }

  static void infoLog(String infoMessage) {
    _logger.i(infoMessage);
  }

  static void warningLog(String warningMessage) {
    _logger.w(warningMessage);
  }

  static void errorLog(String errorMessage, Object errorObject) {
    _logger.e(errorMessage);
  }

  static void changeLogLevel(Level loglevel) {
    Logger.level = loglevel;
  }
}
