import 'package:flutter/material.dart';
import 'package:secondbase/pages/signup/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _phoneController = TextEditingController();

  bool _isObsecure = true;
  bool _isActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F9FF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome Back",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Login to access your account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 24),
              _buildTextField(
                "Email Address",
                _emailController,
                "Enter Email",
                false,
              ),
              // SizedBox(height: 16),
              // _buildTextField(
              //   "Phone Number",
              //   _phoneController,
              //   "Enter Phone Number",
              //   false,
              // ),
              SizedBox(height: 16),
              _buildTextField(
                "Password",
                _passwordController,
                "Enter Password",
                true,
              ),
              SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              SizedBox(height: 24),
              _buildLoginButton(),
              SizedBox(height: 16),
              Center(
                child: Text(
                  "Or sign in with",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 16),
              _buildGoogleLoginButton(),
              SizedBox(height: 24),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
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
                          child: Text(
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
            ],
          ),
        ),
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
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey)),
        SizedBox(height: 4),
        TextField(
          controller: controller,
          obscureText: isPassword ? _isObsecure : false,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
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
      onPressed:
          _isActive
              ? () {
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(builder: (context) => SignUpScreen()),
                // );
              }
              : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(vertical: 16),
      ),
      child: Center(
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
    return OutlinedButton(
      onPressed: () {
        // Navigator.of(
        //   context,
        // ).pushReplacement(MaterialPageRoute(builder: (context) => Getscreen()));
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(vertical: 16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/google.jpeg", height: 16),
          SizedBox(width: 8),
          Text(
            "Sign in with Google",
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
