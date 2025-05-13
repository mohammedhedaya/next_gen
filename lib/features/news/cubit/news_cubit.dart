import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:next_gen/core/database/api/end_points.dart';
import 'package:next_gen/features/news/presentation/data/news_model/news_model.dart';


part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  final String _apiKey = EndPoints.apiKey;
  final String _baseUrl = EndPoints.baseUrl;

Future<void> getInvestmentNews() async {
  emit(NewsLoading());

  try {
    final uri = Uri.https('newsapi.org', '/v2/everything', {
      'q': 'investment',
      'sortBy': 'publishedAt',
      'language': 'en', // أو 'ar' لو عايز أخبار عربية
      'pageSize': '100',
      'apiKey': _apiKey,
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final newsModel = NewsModel.fromJson(data);
      emit(NewsLoaded(newsModel));
    } else {
      final error = json.decode(response.body);
      emit(NewsError(error['message'] ?? 'Failed to load news'));
    }
  } catch (e) {
    emit(NewsError('An error occurred: ${e.toString()}'));
  }
}



  Future<void> searchNews(String query) async {
    emit(NewsLoading());
    
    try {
      final uri = Uri.https(_baseUrl, '/v2/everything', {
        'q': query,
        'apiKey': _apiKey,
      });

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final newsModel = NewsModel.fromJson(data);
        emit(NewsLoaded(newsModel));
      } else {
        final error = json.decode(response.body);
        emit(NewsError(error['message'] ?? 'Failed to search news'));
      }
    } catch (e) {
      emit(NewsError('An error occurred: ${e.toString()}'));
    }
  }
}