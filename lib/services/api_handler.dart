import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tree_view_tractian_challenge/models/companies_model.dart';
import 'package:tree_view_tractian_challenge/models/location_model.dart';

class ApiHandler {
  // /companies - Returns all companies
  // /companies/:companyId/locations - Returns all locations of the company
  // /companies/:companyId/assets - Returns all assets of the company

  final url = "fake-api.tractian.com";

  Future<List<CompaniesModel>> getCompanies() async {
    List<CompaniesModel> list;
    try {
      final response = await http.get(Uri.parse("$url/comapanies"));
      
      list = (jsonDecode(response.body) as List).map((e) => CompaniesModel.fromMap(e),).toList(); 
    } catch (e) {
      print(e);
      list = [];
    }
    return list;
  }

  Future<List<LocationModel>> getLocationCompany(CompaniesModel companies) async {
    List<LocationModel> list;
    try {
      final response = await http.get(Uri.parse("$url/comapnies/${companies.id}"));
      list = (jsonDecode(response.body) as List).map((e) => LocationModel.fromMap(e),).toList();
    } catch (e) {
      print(e);
      list = [];
    }
    return list;
  }
}
