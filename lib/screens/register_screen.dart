import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/constants.dart';
import '../widgets/custom_button.dart';

/// Register screen
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  late AnimationController _slideAnimationController;
  late Animation<Offset> _slideAnimation;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _slideAnimationController = AnimationController(
      duration: AppDuration.verySlow,
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _slideAnimationController,
            curve: Curves.easeOut,
          ),
        );

    _slideAnimationController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _slideAnimationController.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade600,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  Future<void> _handleRegister() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showErrorSnackBar('Silakan isi semua field.');
      return;
    }

    if (password != confirmPassword) {
      _showErrorSnackBar('Password dan konfirmasi password tidak cocok.');
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _authService.registerWithEmail(
        email: email,
        password: password,
        displayName: name,
      );
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (e) {
      _showErrorSnackBar(_authService.getAuthErrorMessage(e));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textPrimary,
          ),
        ),
        title: const Text(
          'Create Account',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _slideAnimationController,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.lg,
              ),
              child: Column(
                children: [
                  // Intro text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Join Our Community',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      const Text(
                        'Create an account to start exploring',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  // Full Name field
                  CustomTextField(
                    label: 'Full Name',
                    hintText: 'Enter your full name',
                    controller: _nameController,
                    prefixIcon: Icons.person_outlined,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  // Email field
                  CustomTextField(
                    label: 'Email',
                    hintText: 'Enter your email',
                    controller: _emailController,
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  // Password field
                  CustomTextField(
                    label: 'Password',
                    hintText: 'Create a password',
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    prefixIcon: Icons.lock_outlined,
                    suffixIcon: _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    onSuffixIconPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  // Confirm Password field
                  CustomTextField(
                    label: 'Confirm Password',
                    hintText: 'Confirm your password',
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    prefixIcon: Icons.lock_outlined,
                    suffixIcon: _obscureConfirmPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    onSuffixIconPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  _isLoading
                      ? const SizedBox(
                          height: 50,
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : PrimaryButton(
                          label: 'Create Account',
                          onPressed: _handleRegister,
                        ),
                  const SizedBox(height: AppSpacing.md),
                  // Terms text
                  Text(
                    'By creating an account, you agree to our\nTerms of Service and Privacy Policy',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
