import 'package:flutter/material.dart';
import 'package:tree_view_tractian_challenge/repository/companies/companie_repository.dart';
import 'package:tree_view_tractian_challenge/repository/companies/companie_state.dart';
import 'package:tree_view_tractian_challenge/responsive/text_scale.dart';
import 'package:tree_view_tractian_challenge/services/api_handler.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repository = CompanieRepository(ApiHandler());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await repository.fetchCompanie();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff17192D),
        actions: [
          Expanded(
            child: IconButton(
              icon: Image.asset(
                scale: 1.2,
                alignment: Alignment.center,
                'assets/images/logo.png',
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ValueListenableBuilder<CompanieState>(
              valueListenable: repository,
              builder: (context, state, child) {
                if (state is CompanieLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is ComapnieSuccessState) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = state.list[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 25,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset("assets/images/enterprise.png"),
                              Text(
                                "${item.name} Unit",
                                textScaler: TextScaler.linear(
                                  ScaleSize.textScaleFactor(context),
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .fontSize,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 30),
                    itemCount: state.list.length,
                  );
                }

                if (state is CompanieErrorState) {
                  return Text(state.message);
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
