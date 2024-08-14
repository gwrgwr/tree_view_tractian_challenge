import 'package:flutter/material.dart';
import 'package:tree_view_tractian_challenge/models/companies_model.dart';
import 'package:tree_view_tractian_challenge/pages/teste_page.dart';
import 'package:tree_view_tractian_challenge/repository/locations/locations_repository.dart';
import 'package:tree_view_tractian_challenge/repository/locations/locations_state.dart';
import 'package:tree_view_tractian_challenge/services/api_handler.dart';

class AssetsPage extends StatelessWidget {
  AssetsPage({required this.companiesModel, super.key});

  final textEditingFilter = TextEditingController();
  final CompaniesModel companiesModel;
  @override
  Widget build(BuildContext context) {
    final repository = LocationsRepository(ApiHandler(), companiesModel);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff17192D),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Assets',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                TextField(
                  controller: textEditingFilter,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffEAEFF3).withOpacity(0.95),
                    hintText: 'Buscar Ativo ou Local',
                    prefixIcon: Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.black.withOpacity(.2),
                        ),
                        color: Color(0xffEAEFF3).withOpacity(0.95),
                      ),
                      width: 180,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/bolt.png',
                            scale: 1.2,
                          ),
                          Text('Sensor de Energia')
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.black.withOpacity(.2),
                        ),
                        color: Color(0xffEAEFF3).withOpacity(0.95),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/critic.png',
                            scale: 1.3,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text('Crítico')
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          FutureBuilder(
            future: repository.getLocationsCompany(),
            builder: (context, snapshot) {
              return ValueListenableBuilder(
                valueListenable: repository,
                builder: (context, state, child) {
                  if (state is LocationLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is LocationSuccessState) {
                    // return ListView.builder(
                    //   shrinkWrap: true,
                    //   itemCount: state.list.length,
                    //   itemBuilder: (context, index) {
                    //     final item = state.list[index];
                    //     return GestureDetector(
                    //       onTap: () {},
                    //       child: AnimatedContainer(
                    //         duration: Duration(milliseconds: 300),
                    //         child: Row(
                    //           children: [
                    //             Icon(Icons.arrow_downward),
                    //             Image.asset(
                    //               'assets/images/location.png',
                    //               scale: 1.2,
                    //             ),
                    //             Text(item.name)
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // );
                    return TreeViewWidget();
                  }

                  if (state is LocationErrorState) {
                    Center(
                      child: Text(state.message),
                    );
                  }

                  return Container();
                },
              );
            },
          )
        ],
      ),
    );
  }
}
