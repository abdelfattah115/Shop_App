import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../layout/shop_cubit/shop_cubit.dart';
import '../shared/components/components.dart';
import '../shared/components/constents.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userData;
        emailController.text = model!.data!.email!;
        phoneController.text = model.data!.phone!;
        nameController.text = model.data!.name!;
        return SingleChildScrollView(
          child: Column(
            children: [
              if(state is ShopLoadingUpdateProfileState)
                const LinearProgressIndicator(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                            color: Colors.grey,
                            boxShadow: [ BoxShadow(
                                color: Colors.grey.shade600,
                                blurRadius: 18.0
                            )]
                        ),
                        child: CircleAvatar(
                          radius: 80.0,
                          backgroundImage: NetworkImage('${model.data!.image}'),
                        ),
                      ),
                      const SizedBox(height: 25,),
                      Text(
                        '${model.data!.name}',
                        style: const TextStyle(
                            fontSize: 25.0
                        ),
                      ),
                      const SizedBox(height: 30.0,),
                      Container(
                        decoration: BoxDecoration(
                            color: HexColor('CDD6DB'),
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        width: double.infinity,
                        height: 50.0,
                        child: defaultFormField(
                          border: InputBorder.none,
                          controller: nameController,
                          type: TextInputType.name,
                          prefix: Icons.person,
                          validate: (String? val) {
                            if (val!.isEmpty) {
                              return 'name is not empty';
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: HexColor('CDD6DB'),
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        width: double.infinity,
                        height: 50.0,
                        child: defaultFormField(
                          border: InputBorder.none,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          prefix: Icons.email,
                          validate: (String? val) {
                            if (val!.isEmpty) {
                              return 'Email is not empty';
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: HexColor('CDD6DB'),
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                        width: double.infinity,
                        height: 50.0,
                        child: defaultFormField(
                          border: InputBorder.none,
                          controller: phoneController,
                          type: TextInputType.phone,
                          prefix: Icons.phone,
                          validate: (String? val) {
                            if (val!.isEmpty) {
                              return 'Phone is not empty';
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        decoration: BoxDecoration(
                            color: HexColor('CDD6DB'),
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        width: double.infinity,
                        height: 50.0,
                        child: defaultTextButton(
                            onPressed: (){
                                ShopCubit.get(context).updateUserData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                );
                            },
                            text: 'Update'
                        ),
                      ),
                      const SizedBox(height: 40,),
                      Container(
                        decoration: BoxDecoration(
                            color: HexColor('CDD6DB'),
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        width: double.infinity,
                        height: 50.0,
                        child: defaultTextButton(onPressed: (){
                          signOut(context);
                        }, text: 'Logout',),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
          // ShopCubit.get(context).userData != null;
          // const Center(child: CircularProgressIndicator()),
      },
    );


  }
}
