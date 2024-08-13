import 'package:flutter/material.dart';
import 'package:tree_view_tractian_challenge/repository/companies/companie_state.dart';
import 'package:tree_view_tractian_challenge/services/api_handler.dart';

class CompanieRepository extends ValueNotifier<CompanieState>{
  CompanieRepository(this.apiHandler): super(CompanieInitialState());

  final ApiHandler apiHandler;

  Future<void> fetchCompanie() async {
    value = CompanieLoadingState();
    try {
      final list = await apiHandler.getCompanies();
      value = ComapnieSuccessState(list: list);
    } catch (e) {
      value = CompanieErrorState(message: e.toString());
    }
  }
}