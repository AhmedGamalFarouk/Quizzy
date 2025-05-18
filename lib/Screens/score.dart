import 'package:flutter/material.dart';
import 'package:quizz_app/constants/app_constants.dart';
import 'package:quizz_app/Screens/categories_page.dart';
import 'package:quizz_app/theme/app_theme.dart';

class ScorePage extends StatefulWidget {
  final String username;
  final int score;
  final int totalQuestions;
  final String categoryName;

  const ScorePage({
    super.key,
    required this.username,
    required this.score,
    this.totalQuestions = 10,
    required this.categoryName,
  });

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scoreAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scoreAnimation = Tween<double>(
      begin: 0,
      end: widget.score.toDouble(),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
    ));

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.4, curve: Curves.elasticOut),
    );

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
    final double percentage = (widget.score / widget.totalQuestions) * 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.info_outline,
                          color: theme.colorScheme.onInverseSurface),
                      const SizedBox(width: 10),
                      Text('Share feature coming soon!'),
                    ],
                  ),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(10),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(AppConstants.largeSpacing),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Header with category
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color:
                            theme.colorScheme.primaryContainer.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        widget.categoryName,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Animated score circle
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: AnimatedBuilder(
                        animation: _scoreAnimation,
                        builder: (context, child) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 200,
                                width: 200,
                                child: CircularProgressIndicator(
                                  value: widget.score / widget.totalQuestions,
                                  strokeWidth: 15,
                                  backgroundColor:
                                      theme.colorScheme.surfaceContainerHighest,
                                  color: _getScoreColor(percentage, theme),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${_scoreAnimation.value.toInt()}',
                                    style:
                                        theme.textTheme.displayLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: _getScoreColor(percentage, theme),
                                    ),
                                  ),
                                  Text(
                                    'out of ${widget.totalQuestions}',
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  Text(
                                    '${percentage.toStringAsFixed(0)}%',
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Congratulations message
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.5),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: _controller,
                          curve:
                              const Interval(0.4, 0.8, curve: Curves.easeOut),
                        ),
                      ),
                      child: FadeTransition(
                        opacity: CurvedAnimation(
                          parent: _controller,
                          curve: const Interval(0.4, 0.8, curve: Curves.easeIn),
                        ),
                        child: Container(
                          padding:
                              const EdgeInsets.all(AppConstants.largeSpacing),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(
                                AppConstants.borderRadiusLarge),
                            boxShadow: [
                              BoxShadow(
                                color: theme.shadowColor.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 0,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Trophy icon based on score
                              Icon(
                                _getTrophyIcon(percentage),
                                size: 60,
                                color: _getScoreColor(percentage, theme),
                              ),
                              const SizedBox(height: 16),

                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: theme.textTheme.headlineSmall,
                                  children: [
                                    const TextSpan(text: 'Well done, '),
                                    TextSpan(
                                      text: widget.username,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                    const TextSpan(text: '!'),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 16),

                              Text(
                                _getFeedbackMessage(percentage),
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Action buttons
            Padding(
              padding: const EdgeInsets.all(AppConstants.mediumSpacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoriesPage(username: widget.username),
                        ),
                      );
                    },
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('TRY ANOTHER QUIZ'),
                  ),
                  const SizedBox(height: AppConstants.smallSpacing),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getScoreColor(double percentage, ThemeData theme) {
    if (percentage >= 80) {
      return AppTheme.successColor;
    } else if (percentage >= 60) {
      return AppTheme.warningColor;
    } else {
      return AppTheme.errorColor;
    }
  }

  IconData _getTrophyIcon(double percentage) {
    if (percentage >= 80) {
      return Icons.emoji_events_rounded;
    } else if (percentage >= 60) {
      return Icons.workspace_premium_rounded;
    } else {
      return Icons.star_rounded;
    }
  }

  String _getFeedbackMessage(double percentage) {
    if (percentage >= 80) {
      return 'Excellent work! You\'ve mastered this category with a great score!';
    } else if (percentage >= 60) {
      return 'Good job! You\'ve done well, but there\'s still room for improvement.';
    } else {
      return 'Keep practicing! Review the material and try again to improve your score.';
    }
  }
}
