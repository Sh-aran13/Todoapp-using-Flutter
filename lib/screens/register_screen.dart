import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/auth_provider.dart';
import 'package:myapp/widgets/custom_text_field.dart';
import 'package:myapp/widgets/register_animated_background.dart';
import 'package:myapp/widgets/glass_container.dart';
import 'package:myapp/widgets/success_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _verifyPasswordController = TextEditingController();

  void _submit() async {
    if (_passwordController.text != _verifyPasswordController.text) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: Colors.grey[900],
            title: const Text('An Error Occurred!', style: TextStyle(color: Colors.white)),
            content: const Text('Passwords do not match.', style: TextStyle(color: Colors.white70)),
            actions: <Widget>[
              TextButton(
                child: const Text('Okay', style: TextStyle(color: Colors.purpleAccent)),
                onPressed: () => Navigator.of(ctx).pop(),
              )
            ],
          ),
        );
      }
      return;
    }

    if (_fullNameController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    final success = await Provider.of<AuthProvider>(context, listen: false).register(
      _fullNameController.text,
      _usernameController.text,
      _emailController.text,
      _passwordController.text,
    );

    if (mounted) {
      if (success) {
        showDialog(
          context: context,
          builder: (ctx) => const SuccessDialog(message: 'Registration Successful!'),
        ).then((_) => context.go('/login'));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration failed. Please try again.')),
        );
      }
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _verifyPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Create Account', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const RegisterAnimatedBackground(),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: GlassContainer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CustomTextField(
                          controller: _fullNameController,
                          labelText: 'Full Name',
                          labelStyle: const TextStyle(color: Colors.white70),
                          inputStyle: const TextStyle(color: Colors.white),
                          prefixIcon: Icons.person,
                          iconColor: Colors.white70,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: _usernameController,
                          labelText: 'Username',
                          labelStyle: const TextStyle(color: Colors.white70),
                          inputStyle: const TextStyle(color: Colors.white),
                          prefixIcon: Icons.person_outline,
                          iconColor: Colors.white70,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: _emailController,
                          labelText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          labelStyle: const TextStyle(color: Colors.white70),
                          inputStyle: const TextStyle(color: Colors.white),
                          prefixIcon: Icons.email_outlined,
                          iconColor: Colors.white70,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: _passwordController,
                          labelText: 'Password',
                          obscureText: true,
                          labelStyle: const TextStyle(color: Colors.white70),
                          inputStyle: const TextStyle(color: Colors.white),
                          prefixIcon: Icons.lock_outline,
                          iconColor: Colors.white70,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: _verifyPasswordController,
                          labelText: 'Verify Password',
                          obscureText: true,
                          labelStyle: const TextStyle(color: Colors.white70),
                          inputStyle: const TextStyle(color: Colors.white),
                          prefixIcon: Icons.lock_person_outlined,
                          iconColor: Colors.white70,
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: Colors.purple.withAlpha(179),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            shadowColor: Colors.purpleAccent,
                            elevation: 8,
                          ),
                          child: const Text('REGISTER', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () => context.go('/login'),
                          child: Text(
                            'Already have an account? Login',
                            style: TextStyle(color: Colors.white.withAlpha(204)),
                          ),
                        ),
                      ],
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
