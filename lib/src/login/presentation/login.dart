import 'package:bike_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/routes/pages.dart';
import '../../../core/utils/helper_widgets.dart';
import '../../home/presentation/views/home.dart';
import 'bloc/login_bloc.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) async {
                if (state is LoginErrorState) {
                  hideLoadingDialog(context);
                  showNormalSnakbar(context, '${state.model}',
                      isSuccess: false);
                }

                if (state is LoginInitial) {
                  showLoadingDialog(context);
                }

                if (state is GetLoginState) {
                  hideLoadingDialog(context);
                  Navigator.of(context).pushReplacement(AppPages.generateRouteSetting(
                      RouteSettings(name: AppRoutes.HOME)));
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        // Label color
                        fillColor: Colors.black,
                        // Background color
                        filled: true, // Ensures the background color is applied
                      ),
                      style: fontStyle(color: Colors.white), // Text color
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        // Label color
                        fillColor: Colors.black,
                        // Background color
                        filled: true, // Ensures the background color is applied
                      ),
                      style: fontStyle(color: Colors.white), // Text color
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(LoginEmailEvent(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim()));
                        }
                      },
                      child: const Text('Sign In'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(SignUpEmailEvent(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim()));
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
