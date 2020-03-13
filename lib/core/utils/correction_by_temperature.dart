/*
 * Коррекция спирта по температуре
 * N - ((t - 20) * 0.3)
 *
 * @param N - Спиртуозность
 * @param t - Температура спирта
 * @returns {number}
 */
final temperatureCorrection =
    (int N, int t) => ((N - ((t - 20) * 0.3)) * 100).round() / 100;
