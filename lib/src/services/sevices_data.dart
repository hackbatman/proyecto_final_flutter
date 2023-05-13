import 'package:intl/intl.dart';

class detaill {
  static const appName = "Servicios";

  static const String RumiaDB = 'Registro_rumia';
  static const String ActividadesDB = 'Registro_de_Actividades';
  static const String PensamientosDB = 'Registro_de_Pensamiento';
  static const String basicoDB = 'Registro_basico';

  // ignore: non_constant_identifier_names

}

String formatTime(timenow) {
  var dateTime = DateTime.fromMillisecondsSinceEpoch(timenow.seconds * 1000);
  return DateFormat('dd-MM-yyyy hh:mm a').format(dateTime);
}

String formatTiempo(timenow) {
  var dateTime = DateTime.fromMillisecondsSinceEpoch(timenow.seconds * 1000);
  return DateFormat('dd-MM-yyyy').format(dateTime);
}

Actualizar_date(timeAtc) {
  int secondMillis = 1;
  int minuteMillis = 60 * secondMillis;
  int hourMillis = 60 * minuteMillis;
  int dayMillis = 24 * hourMillis;

  var now = DateTime.now();
  var diferencia = timeAtc - now;

  if (timeAtc > now || timeAtc <= 0) {
    return "hace mucho tiempo";
  }
  if (diferencia < minuteMillis) {
    return "justo ahora";
  }
  if (diferencia < 2 * minuteMillis) {
    return "hace un minuto";
  }
  if (diferencia < 60 * minuteMillis) {
    return diferencia / minuteMillis;
  }
  if (diferencia < 2 * hourMillis) {
    return "hace una hora";
  }
  if (diferencia < 24 * hourMillis) {
    return diferencia / hourMillis;
  }
}
