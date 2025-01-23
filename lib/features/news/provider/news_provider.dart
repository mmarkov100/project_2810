/*
Провайдер отвечает за состояние загрузки данных с сайта - загрузка, ошибка или успех
Сейчас если с сайта не грузит, то грузит со строки с файла (некоторые так и делали, тк не работала у них апишка)
 */

import 'package:flutter/material.dart';
import '../repository/news_repository.dart';
import '../model/news_model.dart';

class NewsProvider extends ChangeNotifier {
  final NewsRepository _newsRepository;
  List<News> news = []; // Список под будущие новости
  String status = 'loading'; // Возможные состояния: loading, success, error

  NewsProvider({required NewsRepository newsRepository})
      : _newsRepository = newsRepository;

  Future<void> fetchNews() async {
    status = 'loading';
    notifyListeners();

    try {
      // Попытка загрузки данных с сайта
      news = await _newsRepository.fetchNews();
      status = 'success';
    } catch (e) {
      print('$e');
      try {
        // Если загрузка с сайта не удалась, загружаем данные из строки
        news = _newsRepository.fetchNewsFromString();
        status = 'success';
      } catch (error) {
        print('$error');
        status = 'error';
      }
    }

    notifyListeners();
  }
}
