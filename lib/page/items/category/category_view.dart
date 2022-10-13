import 'package:cloud_toq_system/core/common/theme/app_assets.dart';
import 'package:cloud_toq_system/core/common/theme/app_colors.dart';
import 'package:cloud_toq_system/core/page/items/category/_widgets/category_items.dart';
import 'package:cloud_toq_system/core/page/items/category/category_controller.dart';
import 'package:cloud_toq_system/core/page/product/product.dart';
import 'package:cloud_toq_system/core/page/side_menu/side_menu_view.dart';
import 'package:cloud_toq_system/core/route/app_pages.dart';
import 'package:cloud_toq_system/main.dart';
import 'package:cloud_toq_system/utils/empty.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryView extends StatefulWidget {


   CategoryView({Key? key}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final CategoryController controller = Get.find();

  String? idCategory;
  late Future<List<ProductElement>> _future;

  @override
  void initState() {
    super.initState();
    idCategory = sharedPreferences!.getString('product')!;
    print('IDidID${idCategory}');
    _future=controller.getProducts(idCategory!);
    
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
                    onChanged: (value)=>controller.filterCategory(value),
                    decoration: InputDecoration(
                        hintText: 'ابحث عما تريد',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide(
                              width: 1,
                                color: AppColors.current.dimmedLight.withOpacity(0.3)
                            )
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
                        ),

                      focusedBorder:  OutlineInputBorder(
                        borderSide:
                        BorderSide(color: AppColors.current.dimmedLight.withOpacity(0.2),width: 1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                 Empty(height: 20,),
                 Divider(
                    color: AppColors.current.dimmedLight.withOpacity(0.5),
                    endIndent: 0,
                    indent: 0,
                    thickness: 1,
                    height: 1,

                ),
                Empty(height: 16,),
                // Expanded(
                //   child:Obx((){
                //     return ListView.builder(
                //       itemCount:controller.foundList.value.length,
                //       itemBuilder: (context, index) => Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                //         child: CategoryItem(category:controller.foundList.value[index]),
                //       ),
                //     );
                //   }),
                // ),
                Expanded(
                  child:  FutureBuilder <List<ProductElement>>(
                    future:_future,
                    builder: (context , snapshot){
                      switch(snapshot.connectionState){
                        case ConnectionState.waiting:
                          return const Center(
                            child:  CircularProgressIndicator(

                            ),
                          );

                        case ConnectionState.active:
                          return const Center(
                            child:  CircularProgressIndicator(

                            ),
                          );

                        case ConnectionState.none:
                        // handel connection error
                          return const Text(' هناك خطا ');

                        case ConnectionState.done:
                          if(snapshot.error != null){
                            // handel error
                            return  const Center(child: Text('جارى العمل على تعديل بيانات السيرفر الناقصة'));
                          }
                          else {
                            if(snapshot.hasData ){
                              return ListView.builder(
                                itemCount:snapshot.data!.length,
                                itemBuilder: (context, index) =>
                                    Column(
                                      children: [
                                        Divider(height: 1,color: AppColors.current.dimmedLight.withOpacity(0.3),thickness: 1,),
                                        CategoryItem(product:snapshot.data![index]),
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
                    onTap: ()=>Get.toNamed(Routes.CATEGORYADD),
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
      title:  Text('كل الأصناف',
        style: TextStyle(
            color: AppColors.current.success,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontFamily: 'Tajawal'
        ),
      ),
      actions: [
        GestureDetector(
          child: Icon(Icons.arrow_forward,
          size: 30,
          color: AppColors.current.success,),
          onTap:()=>Get.back(),
        ),
      ],

    );
  }
}
