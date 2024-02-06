import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_and_api_for_class/config/router/app_route.dart';
import 'package:hive_and_api_for_class/features/auth/presentation/viewmodel/auth_view_model.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController =
      TextEditingController(text: 'olimanoj1111@gmail.com');
  final _passwordController = TextEditingController(text: '123456');

  bool isObscure = true;
  final _gap = const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Replace with your logo image path
                    height: 100,
                    width: 100,
                  ),
                  _gap,
                  TextFormField(
                    key: const ValueKey('username'),
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                  ),
                  _gap,
                  TextFormField(
                    key: const ValueKey('password'),
                    controller: _passwordController,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                      ),
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await ref
                            .read(authViewModelProvider.notifier)
                            .loginStudent(
                              context,
                              _usernameController.text,
                              _passwordController.text,
                            );
                      }
                    },
                    child: const SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Brand Bold',
                          ),
                        ),
                      ),
                    ),
                  ),
                  _gap,
                  ElevatedButton(
                    key: const ValueKey('registerButton'),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoute.registerRoute);
                    },
                    child: const SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Brand Bold',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
