import 'package:tree_view_tractian_challenge/models/location_model.dart';

sealed class LocationsState {}

final class LocationInitialState extends LocationsState {}

final class LocationLoadingState extends LocationsState {}

final class LocationSuccessState extends LocationsState {
  final List<LocationModel> list;

  LocationSuccessState({required this.list});
}

final class LocationErrorState extends LocationsState {
  final String message;

  LocationErrorState({required this.message});
}
