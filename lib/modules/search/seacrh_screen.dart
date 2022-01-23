import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/modules/search/cubit/search_cubit.dart';
import 'package:shoping_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultTextFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      label: 'Search',
                      prefix: Icons.search,
                      validate: (val) {
                        if (val!.isEmpty) {
                          return 'Enter text to search';
                        }
                        return null;
                      },
                      onSubmitted: (String? text){
                        SearchCubit.get(context).search(text!);
                      }
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildListProduct(
                              SearchCubit.get(context)
                                  .searchModel!
                                  .data!
                                  .data[index],
                              context,
                              isOldPrice: false),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: SearchCubit.get(context)
                              .searchModel!
                              .data!
                              .data
                              .length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
