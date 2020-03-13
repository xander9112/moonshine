/*
 * Содержание абсолютного спирта
 * P * (N / 100)
 *
 * @param P - Объём
 * @param N - Спиртуозность
 * @returns {number}
 */
final absoluteAlcoholContent = (int P, int N) => (P * (N / 96.6)).round();
