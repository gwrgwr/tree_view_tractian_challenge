import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tree_view_tractian_challenge/models/assets_model.dart';
import 'package:tree_view_tractian_challenge/models/companies_model.dart';
import 'package:tree_view_tractian_challenge/models/location_model.dart';
import 'package:tree_view_tractian_challenge/repository/locations/locations_repository.dart';
import 'package:tree_view_tractian_challenge/services/api_handler.dart';

class TreeViewWidget extends StatefulWidget {
  const TreeViewWidget({super.key});


  @override
  State<TreeViewWidget> createState() => _TreeViewWidgetState();
}

class _TreeViewWidgetState extends State<TreeViewWidget> {
  List<LocationModel> locations = [];
  List<AssetsModel> assets = [];
  String selectedCompanyId = '';

  @override
  void initState() {
    super.initState();
    _fetchCompanies();
  }

  Future<void> _fetchCompanies() async {
    // Substitua pela URL correta da sua API
    final response = await http.get(Uri.parse('http://fake-api.tractian.com/companies'));

    if (response.statusCode == 200) {
      List<dynamic> companies = json.decode(response.body);

      if (companies.isNotEmpty) {
        selectedCompanyId = companies[0]['id'];
        await _fetchLocationsAndAssets(selectedCompanyId);
      }
    } else {
      throw Exception('Falha ao carregar as empresas');
    }
  }

  Future<void> _fetchLocationsAndAssets(String companyId) async {
    final locationsResponse = await http.get(Uri.parse('http://fake-api.tractian.com/companies/$companyId/locations'));
    final assetsResponse = await http.get(Uri.parse('http://fake-api.tractian.com/companies/$companyId/assets'));

    if (locationsResponse.statusCode == 200 && assetsResponse.statusCode == 200) {
      setState(() {
        print(json.decode(locationsResponse.body));
        locations = (json.decode(locationsResponse.body) as List)
            .map((data) => LocationModel.fromJson(data))
            .toList();
        assets = (json.decode(assetsResponse.body) as List)
            .map((data) => AssetsModel.fromJson(data))
            .toList();
      });
    } else {
      throw Exception('Falha ao carregar as localizações e ativos');
    }
  }

  List<Widget> _buildTree(
      List<LocationModel> locations, List<AssetsModel> assets) {
    Map<String, List<Widget>> locationToAssets = {};

    for (var asset in assets) {
      if (asset.locationId != null) {
        if (!locationToAssets.containsKey(asset.locationId)) {
          locationToAssets[asset.locationId!] = [];
        }
        locationToAssets[asset.locationId!]!.add(_buildAssetNode(asset));
      } else if (asset.parentId != null) {
        var parentNode = locationToAssets[asset.parentId!];
        if (parentNode != null) {
          parentNode.add(_buildAssetNode(asset));
        }
      }
    }

    return locations.where((loc) => loc.parentId == null).map((location) {
      return ExpansionTile(
        title: Text(location.name),
        children: locationToAssets[location.id] ?? [],
      );
    }).toList();
  }

  Widget _buildAssetNode(AssetsModel asset) {
    if (asset.sensorType != null) {
      return ListTile(
        title: Text('${asset.name} [Component - ${asset.sensorType}]'),
      );
    } else {
      return ExpansionTile(
        title: Text(asset.name),
        children: [],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return locations.isNotEmpty && assets.isNotEmpty
        ? Expanded(
          child: ListView(
              children: _buildTree(locations, assets),
            ),
        )
        : Center(child: CircularProgressIndicator());
  }
}
