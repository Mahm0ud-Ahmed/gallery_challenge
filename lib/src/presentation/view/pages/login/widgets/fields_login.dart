import 'package:flutter/material.dart';
import 'package:gellary_challenge/src/core/utils/extension.dart';
import 'package:gellary_challenge/src/presentation/view/pages/login/login_controller.dart';

import '../../../common/generic_text_field.dart';

class FieldsLogin extends StatelessWidget {
  final LoginController controller;
  const FieldsLogin({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GenericTextField(
          controller: controller.userNameController,
          hintText: 'User Name',
          validator: (value) => value!.isEmpty ? 'User Name cannot be empty' : null,
        ),
        (context.sizeSide.height * .04).h,
        ValueListenableBuilder<bool>(
          valueListenable: controller.isObscure,
          builder: (context, value, child) {
            return GenericTextField(
              controller: controller.passwordController,
              hintText: 'Password',
              obscureText: value,
              validator: (value) => value!.isEmpty ? 'Password cannot be empty' : null,
              suffixIcon: IconButton(
                icon: Icon(value ? Icons.visibility_off : Icons.visibility),
                onPressed: () => controller.isObscure.value = !controller.isObscure.value,
              ),
            );
          },
        ),
      ],
    );
  }
}
