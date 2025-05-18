import 'package:flutter/material.dart';
import 'package:quizz_app/Screens/categories_page.dart';
import 'package:quizz_app/constants/app_constants.dart';
import 'package:quizz_app/utils/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.colorScheme.primary),
      ),
      body: Stack(
        children: [
          // Background decoration
          Positioned(
            top: -size.height * 0.2,
            right: -size.width * 0.2,
            child: Container(
              height: size.width * 0.8,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -size.height * 0.15,
            left: -size.width * 0.15,
            child: Container(
              height: size.width * 0.6,
              width: size.width * 0.6,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.largeSpacing),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo/Icon
                        Hero(
                          tag: 'logo',
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person_rounded,
                              size: 60,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                        SizedBox(height: AppConstants.largeSpacing),

                        // Welcome text with animation
                        SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.3),
                            end: Offset.zero,
                          ).animate(_fadeAnimation),
                          child: Text(
                            'Welcome!',
                            style: theme.textTheme.displayLarge?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),

                        SizedBox(height: AppConstants.mediumSpacing),

                        // Subtitle text with animation
                        SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.3),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: _animationController,
                            curve:
                                const Interval(0.4, 1.0, curve: Curves.easeOut),
                          )),
                          child: Text(
                            'Enter your name to start the quiz',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.7),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        SizedBox(height: AppConstants.extraLargeSpacing),

                        // Username field with animation
                        SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.3),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: _animationController,
                            curve:
                                const Interval(0.5, 1.0, curve: Curves.easeOut),
                          )),
                          child: TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              hintText: 'Enter your username',
                              prefixIcon: Icon(Icons.person,
                                  color: theme.colorScheme.primary),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () => _usernameController.clear(),
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.5),
                              ),
                            ),
                            style: theme.textTheme.bodyLarge,
                            validator: Validators.validateUsername,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _login(),
                            enabled: !_isLoading,
                          ),
                        ),

                        SizedBox(height: AppConstants.extraLargeSpacing),

                        // Login button with animation
                        SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.3),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: _animationController,
                            curve:
                                const Interval(0.6, 1.0, curve: Curves.easeOut),
                          )),
                          child: SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _login,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppConstants.borderRadiusMedium),
                                ),
                              ),
                              child: _isLoading
                                  ? SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        color: theme.colorScheme.onPrimary,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : const Text('START QUIZ'),
                            ),
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

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      FocusScope.of(context).unfocus();

      // Simulate loading for better UX
      Future.delayed(const Duration(milliseconds: 800), () {
        // Navigate to categories page
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                CategoriesPage(
              username: _usernameController.text.trim(),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      });
    }
  }
}
