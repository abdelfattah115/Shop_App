import 'package:flutter/material.dart';
import '../layout/shop_cubit/shop_cubit.dart';
import '../models/category_model.dart';
import '../shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildItemCategories(
        ShopCubit.get(context).categoriesModel!.data!.data[index],
      ),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
    );
  }

  Widget buildItemCategories(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading2.gif',
              image: model.image!,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              model.name!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
