import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecommendedInvestmentModel {
  final String title;
  final double amount;
  final String description;
  final double progress;

  RecommendedInvestmentModel({
    required this.title,
    required this.amount,
    required this.description,
    required this.progress,
  });

  factory RecommendedInvestmentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RecommendedInvestmentModel(
      title: data['title'] ?? '',
      amount: (data['amount'] ?? 0).toDouble(),
      description: data['description'] ?? '',
      progress: (data['progress'] ?? 0).toDouble(),
    );
  }

  get id => null;
}
