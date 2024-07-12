import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imake/components/build_text_field.dart';
import 'package:imake/components/widgets.dart';
import 'package:imake/routes/pages.dart';
import 'package:imake/tasks/data/local/model/user_model.dart';
import 'package:imake/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:imake/tasks/presentation/bloc/tasks_event.dart';
import 'package:imake/tasks/presentation/bloc/tasks_state.dart';
import 'package:imake/utils/color_palette.dart';
import 'package:imake/utils/font_sizes.dart';
import 'package:imake/utils/util.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier<bool>(false);

  void _validateFields() {
    _isButtonEnabled.value =
        _nomeController.text.isNotEmpty && _senhaController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _nomeController.addListener(_validateFields);
    _senhaController.addListener(_validateFields);
  }

  @override
  void dispose() {
    super.dispose();
    _senhaController.dispose();
    _nomeController.dispose();
    _isButtonEnabled.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: kWhiteColor,
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocConsumer<TasksBloc, TasksState>(
                  listener: (context, state) {
                if (state is LoginSuccess) {
                  Navigator.pushNamed(context, Pages.home);
                }
                if (state is LoginFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }, builder: (context, state) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/app_logo.png',
                        width: 100,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BuildTextField(
                          hint: "Nome",
                          controller: _nomeController,
                          inputType: TextInputType.name,
                          fillColor: kWhiteColor,
                          onChange: (value) {}),
                      const SizedBox(
                        height: 10,
                      ),
                      BuildTextField(
                          hint: "Senha",
                          controller: _senhaController,
                          inputType: TextInputType.text,
                          fillColor: kWhiteColor,
                          onChange: (value) {}),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: ValueListenableBuilder<bool>(
                            valueListenable: _isButtonEnabled,
                            builder: (context, isEnabled, child) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: kGrey0),
                                onPressed: isEnabled
                                    ? () {
                                        UserModel user = UserModel(
                                            name: _nomeController.text,
                                            password: _senhaController.text);
                                        context
                                            .read<TasksBloc>()
                                            .add(LoginEvent(userModel: user));
                                      }
                                    : null,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: buildText(
                                      'Login',
                                      kWhiteColor,
                                      textMedium,
                                      FontWeight.w600,
                                      TextAlign.center,
                                      TextOverflow.clip),
                                ),
                              );
                            }),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: buildText(
                            'Cadastre-se aqui!',
                            kPrimaryColor,
                            textMedium,
                            FontWeight.w500,
                            TextAlign.center,
                            TextOverflow.clip),
                      )
                    ]);
              }),
            ),
          ),
        ));
  }
}
