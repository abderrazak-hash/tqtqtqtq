import 'package:cloud_toq_system/core/common/theme/app_assets.dart';
import 'package:cloud_toq_system/core/common/theme/app_colors.dart';
import 'package:cloud_toq_system/core/page/items/department/_widgets/department_items.dart';
import 'package:cloud_toq_system/core/page/items/department/department_controller.dart';
import 'package:cloud_toq_system/core/page/side_menu/side_menu_view.dart';
import 'package:cloud_toq_system/core/route/app_pages.dart';
import 'package:cloud_toq_system/main.dart';
import 'package:cloud_toq_system/utils/empty.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../product/product_controller.dart';



class DepartmentView extends StatefulWidget {


   DepartmentView({Key? key}) : super(key: key);

  @override
  State<DepartmentView> createState() => _DepartmentViewState();
}

class _DepartmentViewState extends State<DepartmentView> {
  final DepartmentController controller = Get.find();

  String? idCategory;

  late Future<List<Category>> _future;

  @override
  void initState() {
    super.initState();
    idCategory = sharedPreferences!.getString('idCategory')!;
    _future=controller.getCategories(sharedPreferences!.getString('idCategory')!);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.current.neutral,
      drawer: SideMenuView(),
      appBar: _buildToolbar(),
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(AppAssets.background_app,fit: BoxFit.fill),
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    onChanged: (value)=>controller.filterDepartment(value),
                    decoration: InputDecoration(
                        hintText: 'ابحث عما تريد',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide(
                                color: AppColors.current.dimmedLight.withOpacity(0.2),
                              width: 1
                            ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.current.dimmedLight.withOpacity(0.2),
                            width: 1
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        hintStyle: TextStyle(
                          color: AppColors.current.dimmedLight,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Tajawal',
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppColors.current.primary,
                          size: 30,
                        )),
                  ),
                ),
                 Empty(height: 20,),

                Expanded(
                  child:  FutureBuilder <List<Category>>(
        future:_future,
        builder: (context , snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return const Center(

              );

            case ConnectionState.active:
              return const Center(

              );

            case ConnectionState.none:
            // handel connection error
              return  Text(' error ');

            case ConnectionState.done:
              if(snapshot.error != null){
                // handel error
                return  Text('snapshot.error');
              }
              else {
                if(snapshot.hasData ){
                  return ListView.builder(
                    itemCount:controller.categories.length,
                    itemBuilder: (context, index) =>
                        Column(
                          children: [
                            Divider(height: 1,color: AppColors.current.dimmedLight.withOpacity(0.3),thickness: 1,),
                            DepartmentItem(department:controller.categories[index]),
                            Divider(height: 1,color: AppColors.current.dimmedLight.withOpacity(0.3),thickness: 1,),
                          ],
                        ),
                  );

                }
                else {
                  // handel empty data
                  return  Center(
                    child: Text('no data found' ,style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Tajawal',
                        color: AppColors.current.text),),
                  );
                }
              }

          }


        },
      ),
                ),

                Align(
                  alignment: Alignment.bottomLeft,
                  child: GestureDetector(
                    onTap: ()=>Get.toNamed(Routes.DEPARTMENTADD),
                  child: Image.asset(AppAssets.floating,fit: BoxFit.fill,),),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildToolbar() {
    return AppBar(
      centerTitle: false,
      backgroundColor: AppColors.current.primary,
      leadingWidth: 40,
      elevation: 0.0,
      titleSpacing: 0,
      foregroundColor: AppColors.current.success,
      title:  Text('الأقسام',
        style: TextStyle(
            color: AppColors.current.success,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontFamily: 'Tajawal'
        ),
      ),
      actions: [
        GestureDetector(child: Icon(Icons.arrow_forward,
          size: 30,
          color: AppColors.current.success,),
          onTap:()=>Get.back(),
        ),
      ],

    );
  }
}
