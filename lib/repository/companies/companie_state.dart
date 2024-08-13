import 'package:tree_view_tractian_challenge/models/companies_model.dart';

sealed class CompanieState {}

final class CompanieInitialState extends CompanieState {}

final class CompanieLoadingState extends CompanieState {}

final class ComapnieSuccessState extends CompanieState {
  final List<CompaniesModel> list;

  ComapnieSuccessState({required this.list});
}

final class CompanieErrorState extends CompanieState {
  final String message;

  CompanieErrorState({required this.message});
}