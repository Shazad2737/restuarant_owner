import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_owner/blocs/auth/sign_in/sign_in_bloc.dart';
import 'package:restaurant_owner/ui/screens/home.dart';
import 'package:restaurant_owner/ui/widgets/custom_button.dart';
import 'package:restaurant_owner/ui/widgets/custom_card.dart';
import 'package:restaurant_owner/ui/widgets/custom_input_form_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (Supabase.instance.client.auth.currentUser != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    });
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1424847651672-bf20a4b0982b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 350,
              child: CustomCard(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  child: BlocProvider<SignInBloc>(
                    create: (context) => SignInBloc(),
                    child: BlocConsumer<SignInBloc, SignInState>(
                      listener: (context, state) {
                        if (state is SignInFailureState) {
                          showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                              title: Text("Login Failed"),
                              content: Text(
                                'Please check your email and password and try again.',
                              ),
                            ),
                          );
                        } else if (state is SignInSuccessState) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Restaurent Owner',
                                style: GoogleFonts.oswald(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Colors.green[800],
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Enter email and password to login',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const Divider(
                                color: Colors.green,
                                height: 40,
                                thickness: 0.5,
                              ),
                              // Text(
                              //   'Login',
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .headlineSmall!
                              //       .copyWith(
                              //         color: Colors.black,
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              // ),
                              // const SizedBox(
                              //   height: 5,
                              // ),

                              CustomInputFormField(
                                controller: _emailController,
                                prefixIcon: Icons.email,
                                labelText: 'Email',
                                validator: (value) {
                                  if (value != null &&
                                      value.trim().isNotEmpty) {
                                    return null;
                                  } else {
                                    return "Please enter an email";
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomInputFormField(
                                controller: _passwordController,
                                isObscure: isObscure,
                                labelText: 'Password',
                                prefixIcon: Icons.lock,
                                validator: (value) {
                                  if (value != null &&
                                      value.trim().isNotEmpty) {
                                    return null;
                                  } else {
                                    return "Please enter password";
                                  }
                                },
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    isObscure = !isObscure;
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.green[700],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButton(
                                buttonColor: Colors.green,
                                labelColor: Colors.white,
                                label: 'Login',
                                isLoading: state is SignInLoadingState,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    String email = _emailController.text.trim();
                                    String password =
                                        _passwordController.text.trim();

                                    BlocProvider.of<SignInBloc>(context).add(
                                      SignInEvent(
                                        email: email,
                                        password: password,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Branding extends StatelessWidget {
  const Branding({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.pets,
          color: Colors.pink,
          size: 50,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'PetsMart',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
