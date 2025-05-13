part of 'news_cubit.dart';

abstract class NewsState {
  const NewsState();
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final NewsModel newsModel;
  
  const NewsLoaded(this.newsModel);
}

class NewsError extends NewsState {
  final String message;
  
  const NewsError(this.message);
}