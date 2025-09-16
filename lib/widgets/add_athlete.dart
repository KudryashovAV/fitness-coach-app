import 'package:fitness_coach_app/controllers/athletes_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AddAthlete extends StatelessWidget {
  AddAthlete({super.key});
  final athletesCtrl = Get.find<AthletesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавление спортсмена'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Имя'),
              onChanged: (value) => athletesCtrl.name.value = value,
            ),
            // SizedBox(height: 16),
            // TextField(
            //   decoration: InputDecoration(labelText: 'Номер телефона'),
            //   keyboardType: TextInputType.phone,
            //   onChanged: (value) => athletesCtrl.phone.value = value,
            // ),
            SizedBox(height: 16),
            IntlPhoneField(
              decoration: InputDecoration(
                labelText: 'Номер телефона',
                border: OutlineInputBorder(),
              ),
              initialCountryCode: 'BY',
              autovalidateMode: AutovalidateMode.disabled,
              onChanged: (phone) =>
                  athletesCtrl.phone.value = phone.completeNumber,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Количество тренировок'),
              keyboardType: TextInputType.number,
              onChanged: (value) => athletesCtrl.workouts.value = value,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => {
                if (athletesCtrl.name.value.isEmpty)
                  {EasyLoading.showError('Укажите имя спортсмена')}
                else
                  {
                    if (athletesCtrl.phone.value.isEmpty)
                      {
                        EasyLoading.showError(
                            'Укажите номер телефона спортсмена')
                      }
                    else
                      {
                        if (athletesCtrl.phone.value.substring(0, 4) == "+375"
                            ? RegExp(r"^\+\d{12}$")
                                .hasMatch(athletesCtrl.phone.value)
                            : RegExp(r"^\+\d{11}$")
                                .hasMatch(athletesCtrl.phone.value))
                          {
                            athletesCtrl.addAthlete(),
                            athletesCtrl.name.value = '',
                            athletesCtrl.phone.value = '',
                            athletesCtrl.workouts.value = '0',
                            Get.back()
                          }
                        else
                          {
                            EasyLoading.showError(athletesCtrl.phone.value
                                        .substring(0, 4) ==
                                    "+375"
                                ? 'Номер должен быть в формате +ХХХХХХХХХХХХ'
                                : 'Номер должен быть в формате +ХХХХХХХХХХХ')
                          },
                      },
                  },
              },
              child: Text('Создать спортсмена'),
            ),
          ],
        ),
      ),
    );
  }
}
