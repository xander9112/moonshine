import 'package:calc/core/translation_service.dart';

final TranslationService _translationService = new TranslationService();

class Validators {
  static Function validate(List<Function> validators) => (var value) {
        List<String> errors = validators
            .map<String>((item) => item(value))
            .where((String result) => result != null)
            .toList();
        return errors.isEmpty ? null : errors[0];
      };

  static String specificSymbolsFilter(String value) =>
      RegExp(r"[^a-zA-Zа-яА-Я -]+").allMatches(value).length > 0
          ? _translationService.text('validationErrors.specificSymbols')
          : null;

  static String required(var value) => value.isEmpty
      ? _translationService.text('validationErrors.required')
      : null;

  static Function minLength(int minLength) =>
      (var value) => value.length < minLength
          ? _translationService.text('validationErrors.minLength',
              options: {'minLength': minLength})
          : null;

  static Function min(int min) => (var value) => int.parse(value) < min
      ? _translationService
          .text('validationErrors.min', options: {'min': min.toString()})
      : null;

  static Function max(int max) => (var value) => int.parse(value) > max
      ? _translationService
          .text('validationErrors.max', options: {'max': max.toString()})
      : null;

  static String phoneNumber(String value) {
    if (value != null && value.length > 0 && value.length < 18) {
      return _translationService.text('validationErrors.phoneNumber');
    }

    return null;
  }

  static String email(String value) =>
      RegExp(r"^((?!\.)[\w-_.]*[^.])(@\w+)(\.\w+(\.\w+)?[^.\W])$")
              .hasMatch(value)
          ? null
          : _translationService.text('validationErrors.email');

  /*static Function isAfter(String start,
          {String format = 'dd/MM/yyyy', String errorMessage}) =>
      (String value) {
        DateTime end = localDateTimeFormat.parse(value);
        DateTime dateStart = localDateTimeFormat.parse(start);

        DateTime dateEnd =
            new DateTime(end.year, end.month, end.day, end.hour, end.minute);

        if (!(dateEnd.isAfter(dateStart) ||
            dateEnd.isAtSameMomentAs(dateStart))) {
          if (errorMessage == null) {
            return _translationService.text('validationErrors.isAfter');
          }

          return _translationService.text(errorMessage);
        }

        return null;
      };*/
}
