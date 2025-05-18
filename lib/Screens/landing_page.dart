import 'package:flutter/material.dart';
import 'package:quizz_app/Screens/login_page.dart'; // <-- Import LoginPage
import 'package:quizz_app/constants/app_constants.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppConstants.largeSpacing),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 1),
              // Logo with animation
              FadeTransition(
                opacity: _fadeInAnimation,
                child: Center(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: size.height * 0.25,
                      width: size.height * 0.25,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.quiz,
                        size: size.height * 0.15,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppConstants.largeSpacing),
              // App title with animation
              FadeTransition(
                opacity: _fadeInAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(_fadeInAnimation),
                  child: Text(
                    AppConstants.appName,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displayLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontSize: 48,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppConstants.mediumSpacing),
              // Subtitle with animation
              FadeTransition(
                opacity: _fadeInAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(_fadeInAnimation),
                  child: Text(
                    'Test your knowledge with fun quizzes',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppConstants.extraLargeSpacing),
              // Button with animation
              FadeTransition(
                opacity: _fadeInAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, 0.7),
                    end: Offset.zero,
                  ).animate(_fadeInAnimation),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const LoginPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = const Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.easeOut;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                          transitionDuration: AppConstants.animationDuration,
                        ),
                      );
                    },
                    child: const Text('START QUIZ'),
                  ),
                ),
              ),
              const Spacer(flex: 2),
              // App version
              FadeTransition(
                opacity: _fadeInAnimation,
                child: Text(
                  'Version ${AppConstants.appVersion}',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ),
              SizedBox(height: AppConstants.mediumSpacing),
            ],
          ),
        ),
      ),
    );
  }
}
