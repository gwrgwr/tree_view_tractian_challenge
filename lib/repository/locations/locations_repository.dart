import 'package:flutter/material.dart';
import 'package:tree_view_tractian_challenge/models/companies_model.dart';
import 'package:tree_view_tractian_challenge/repository/locations/locations_state.dart';
import 'package:tree_view_tractian_challenge/services/api_handler.dart';

class LocationsRepository extends ValueNotifier<LocationsState> {
  LocationsRepository(this._apiHandler, this.companiesModel): super(LocationInitialState());

  final ApiHandler _apiHandler;
  final CompaniesModel companiesModel;
  
  Future<void> getLocationsCompany() async {
    value = LocationLoadingState();
    try {
      final list = await _apiHandler.getLocationCompany(companiesModel);
      value = LocationSuccessState(list: list);
    } catch (e) {
      value = LocationErrorState(message: e.toString());
    }
  }
}