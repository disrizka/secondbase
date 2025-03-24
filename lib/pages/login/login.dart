import 'package:flutter/material.dart';
import 'package:secondbase/services/auth_service.dart';
import 'package:secondbase/pages/signup/signup.dart';
import 'package:secondbase/utils/app_color.dart';

// <-- tambahkan ini jika kamu punya AppImage

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObsecure = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset('assets/flower.png', fit: BoxFit.cover),
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Welcome Back!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Baloo2",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Login to continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    "Email Address",
                    _emailController,
                    "Enter Email",
                    false,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    "Password",
                    _passwordController,
                    "Enter Password",
                    true,
                  ),
                  const SizedBox(height: 24),
                  _buildLoginButton(),
                  const SizedBox(height: 16),
                  const Center(
                    child: Text(
                      "Or login with",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildGoogleLoginButton(),
                  const SizedBox(height: 24),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        children: [
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 100), // biar tidak ketutupan gambar
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String hint,
    bool isPassword,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          obscureText: isPassword ? _isObsecure : false,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            suffixIcon:
                isPassword
                    ? IconButton(
                      icon: Icon(
                        _isObsecure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObsecure = !_isObsecure;
                        });
                      },
                    )
                    : null,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () async {
        await AuthService().signin(
          email: _emailController.text,
          password: _passwordController.text,
          context: context,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.secondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const Center(
        child: Text(
          "Login",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleLoginButton() {
    return isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton(
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            await AuthService().loginWithGoogle(context);
            setState(() {
              isLoading = false;
            });
          },
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/google.jpeg", height: 16),
              const SizedBox(width: 8),
              const Text(
                "Login with Google",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontFamily: "Poppins",
                ),
              ),
            ],
          ),
        );
  }
}
