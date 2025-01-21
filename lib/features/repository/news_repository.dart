/*
Репозиторий отвечает за обращение к информации с сайта
 */

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:project_2810/features/repository/response_from_api.dart';
import '../model/news_model.dart';

class NewsRepository {
  final Dio _dio;

  NewsRepository({Dio? dio}) : _dio = dio ?? Dio();

  // Метод для получения новостей с сайта, используй его если сайт работает
  Future<List<News>> fetchNews() async {
    try {

      // Получаем ответы от сайтов с апи
      final responses = await Future.wait([
        _dio.get('https://exams2.masqed.ru/api1'),
        _dio.get('https://exams2.masqed.ru/api2'),
      ]);

      // Обработка данных из первого API
      final api1News = (responses[0].data as List)
          .map((e) => News.fromApi1(e))
          .toList();

      // Обработка данных из второго API
      final api2News = (responses[1].data['newsLine'] as List)
          .map((e) => News.fromApi2(e))
          .toList();

      // Объединение и сортировка новостей по дате
      final combinedNews = [...api1News, ...api2News];
      combinedNews.sort((a, b) => b.date.compareTo(a.date));

      return combinedNews;
    } catch (e) {
      throw Exception('$e');
    }
  }

  // Метод для получения данных со строки из файла response_from_api
  List<News> fetchNewsFromString() {
    try {
      ResponseFromApi responseFromApi = ResponseFromApi();

      // Парсим данные из строк
      final List<dynamic> api1Parsed = jsonDecode(responseFromApi.api1);
      final List<dynamic> api2Parsed = jsonDecode(responseFromApi.api2)['newsLine'];

      // Преобразуем данные в единый формат
      final List<News> api1News = api1Parsed.map((e) => News.fromApi1(e)).toList();
      final List<News> api2News = api2Parsed.map((e) => News.fromApi2(e)).toList();

      // Объединяем данные и сортируем по дате
      final combinedNews = [...api1News, ...api2News];
      combinedNews.sort((a, b) => b.date.compareTo(a.date));

      return combinedNews;
    } catch (e) {
      throw Exception('$e');
    }
  }
}
