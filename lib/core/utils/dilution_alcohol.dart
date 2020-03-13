/*
 * Разбавление спирта водой
 * X = NP/M - P
 *
 * @param N - Изначальная крепость раствора
 * @param P - Изначальный объём
 * @param M - Необходимая крепость конечного раствора
 */
final dilutionAlcohol = (int N, int P, int M) => ((N * P / M) - P);
