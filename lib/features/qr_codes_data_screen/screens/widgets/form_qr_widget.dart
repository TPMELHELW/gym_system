import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_qr_code/core/constans/app_colors.dart';
import 'package:gym_qr_code/core/validation/input_validation.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/screens/widgets/calender_selection_widget.dart';
import 'package:gym_qr_code/features/qr_codes_data_screen/controller/qr_codes_data_controller.dart';
import 'package:gym_qr_code/core/common/noraml_button_widget.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class FormQrWidget extends StatelessWidget {
  const FormQrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final QrCodesDataController homeController = QrCodesDataController.to;
    return Form(
      key: homeController.formKey,
      child: Column(
        spacing: 20,

        children: [
          TextFormField(
            validator: (value) =>
                AppFieldValidator.validateEmpty(value, 'الاسم'),

            controller: homeController.nameController,
            decoration: InputDecoration(
              suffixIcon: Icon(Iconsax.user),
              filled: true,
              fillColor: AppColors.grey,
              hintText: 'ادخل اسم المشترك',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Row(
            spacing: 10,
            children: [
              CalenderSelectionWidget(
                label: 'تاريخ البدء',
                controller: homeController.firstDateController,
              ),
              CalenderSelectionWidget(
                label: 'تاريخ الانتهاء',
                controller: homeController.endDateController,
              ),
            ],
          ),
          TextFormField(
            readOnly: true,

            decoration: InputDecoration(
              suffixIcon: TextButton(
                onPressed: () {
                  Get.bottomSheet(
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.light,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await homeController.chooseImage(false);
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Iconsax.gallery, size: 50),
                                Text(
                                  'المعرض',
                                  style: Theme.of(context).textTheme.bodyLarge!
                                      .copyWith(color: AppColors.dark),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () async {
                              await homeController.chooseImage(true);
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Iconsax.camera, size: 50),
                                Text(
                                  'الكاميرا',
                                  style: Theme.of(context).textTheme.bodyLarge!
                                      .copyWith(color: AppColors.dark),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Text('اختار الصورة'),
              ),
              filled: true,

              fillColor: AppColors.grey,
              hintText: homeController.imagePath == ''
                  ? 'اختر صورة'
                  : 'تم اختيار صورة',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),

          Obx(
            () => NoramlButtonWidget(
              onPressed: () async {
                if (homeController.isEdit.value) {
                  await homeController.editUser();
                } else {
                  await homeController.addUser();
                }
              },
              text: homeController.isEdit.value
                  ? 'تعديل المشترك'
                  : 'عرض رمز الاستجابة السريعة',
            ),
          ),
        ],
      ),
    );
  }
}
