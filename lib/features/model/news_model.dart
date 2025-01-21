/*
Это модель данных, которая сразу работает и для получения данных с API и сразу перевод этих данных в единую модель
 */

class News {

  // Переменные, которые хранит модель News
  final DateTime date;
  final String title;
  final String description;
  final String author;
  final String source;
  final bool isPopular;

  // Конструктор модели, указываем нужные переменные для создания модели
  News({
    required this.date,
    required this.title,
    required this.description,
    required this.author,
    required this.source,
    required this.isPopular,
  });

  // Приводим данные из первого апи сразу в нужную модель данных через фабричный конструктор
  factory News.fromApi1(Map<String, dynamic> json) {
    return News(
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
      title: json['title'],
      description: json['description'],
      author: json['author'],
      source: json['site'],
      isPopular: json['hot'] ?? false,
    );
  }

  // Приводим данные из второго апи сразу в нужную модель данных через фабричный конструктор
  factory News.fromApi2(Map<String, dynamic> json) {
    return News(
      date: DateTime.parse(json['datetime']),
      title: json['main'],
      description: json['article'],
      author: json['author'],
      source: json['source'],
      isPopular: json['isPopular'] ?? false,
    );
  }
}
