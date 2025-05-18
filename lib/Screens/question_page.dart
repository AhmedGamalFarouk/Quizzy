import 'package:flutter/material.dart';
import 'package:quizz_app/Screens/score.dart';
import 'package:quizz_app/constants/app_constants.dart';
import 'package:quizz_app/data/questions_data.dart';
import 'package:quizz_app/models/question.dart';
import 'package:quizz_app/theme/app_theme.dart';

class QuestionPage extends StatefulWidget {
  final String username;
  final String categoryName;

  const QuestionPage({
    super.key,
    required this.username,
    required this.categoryName,
  });

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage>
    with SingleTickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _hasAnswered = false;
  int? _selectedOptionIndex;
  late final List<Question> _questions;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    // Get questions for the selected category
    _questions = QuestionsData.questionsByCategory[widget.categoryName] ?? [];

    // Initialize animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: _questions.isEmpty ? 0.0 : 1 / _questions.length,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _checkAnswer(int selectedIndex) {
    if (_hasAnswered) return; // Prevent multiple answers

    setState(() {
      _selectedOptionIndex = selectedIndex;
      _hasAnswered = true;

      if (selectedIndex ==
          _questions[_currentQuestionIndex].correctAnswerIndex) {
        _score++;
      }
    });

    // Wait a moment to show the answer before moving to the next question
    Future.delayed(AppConstants.animationDuration, () {
      if (_currentQuestionIndex < _questions.length - 1) {
        _animationController.reset();

        setState(() {
          _currentQuestionIndex++;
          _hasAnswered = false;
          _selectedOptionIndex = null;
        });

        _progressAnimation = Tween<double>(
          begin: _progressAnimation.value,
          end: (_currentQuestionIndex + 1) / _questions.length,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

        _animationController.forward();
      } else {
        // Quiz completed, navigate to score page
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, animation, __) => ScorePage(
              username: widget.username,
              score: _score,
              totalQuestions: _questions.length,
              categoryName: widget.categoryName,
            ),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  Color _getOptionColor(int index) {
    if (!_hasAnswered) return Theme.of(context).cardTheme.color ?? Colors.white;

    final correctIndex = _questions[_currentQuestionIndex].correctAnswerIndex;

    if (index == correctIndex) {
      return AppTheme.successColor.withOpacity(0.2);
    } else if (index == _selectedOptionIndex) {
      return AppTheme.errorColor.withOpacity(0.2);
    }

    return Theme.of(context).cardTheme.color ?? Colors.white;
  }

  IconData? _getOptionIcon(int index) {
    if (!_hasAnswered) return null;

    final correctIndex = _questions[_currentQuestionIndex].correctAnswerIndex;

    if (index == correctIndex) {
      return Icons.check_circle_outline_rounded;
    } else if (index == _selectedOptionIndex) {
      return Icons.cancel_outlined;
    }

    return null;
  }

  Color _getOptionIconColor(int index) {
    final correctIndex = _questions[_currentQuestionIndex].correctAnswerIndex;

    if (index == correctIndex) {
      return AppTheme.successColor;
    } else {
      return AppTheme.errorColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_questions.isEmpty) {
      // Handle case where no questions are found for the category
      return Scaffold(
        appBar: AppBar(title: Text('${widget.categoryName} Quiz')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.question_mark_rounded,
                size: 80,
                color: theme.colorScheme.error.withOpacity(0.5),
              ),
              const SizedBox(height: 20),
              Text(
                'No questions available for this category.',
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.categoryName} Quiz'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Quit Quiz?'),
                content: const Text('Your progress will be lost.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      Navigator.pop(context); // Go back to previous screen
                    },
                    child: const Text('Quit'),
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 12.0,
            ),
            margin: const EdgeInsets.only(right: 16.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Q ${_currentQuestionIndex + 1}/${_questions.length}',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Animated progress bar
            AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: _progressAnimation.value,
                  backgroundColor:
                      theme.colorScheme.primaryContainer.withOpacity(0.3),
                  color: theme.colorScheme.primary,
                  minHeight: 8,
                );
              },
            ),

            // Question and options
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.mediumSpacing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Timer/progress indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color:
                                  theme.colorScheme.secondary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.score_rounded,
                                  color: theme.colorScheme.secondary,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Score: $_score',
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: theme.colorScheme.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: AppConstants.mediumSpacing),

                      // Category indicator
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          widget.categoryName,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: AppConstants.largeSpacing),

                      // Question text
                      Container(
                        padding:
                            const EdgeInsets.all(AppConstants.mediumSpacing),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(
                              AppConstants.borderRadiusLarge),
                          boxShadow: [
                            BoxShadow(
                              color: theme.shadowColor.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          currentQuestion.questionText,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: AppConstants.largeSpacing),

                      // Options
                      Expanded(
                        child: ListView.builder(
                          itemCount: currentQuestion.options.length,
                          itemBuilder: (context, index) {
                            return AnimatedOpacity(
                              opacity: 1.0,
                              duration:
                                  Duration(milliseconds: 300 + (index * 100)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: AppConstants.mediumSpacing),
                                child: _buildOptionCard(
                                    index, currentQuestion, theme),
                              ),
                            );
                          },
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
    );
  }

  Widget _buildOptionCard(int index, Question question, ThemeData theme) {
    return Card(
      elevation: _hasAnswered ? 1 : 3,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        side: _hasAnswered &&
                (index == question.correctAnswerIndex ||
                    index == _selectedOptionIndex)
            ? BorderSide(
                color: index == question.correctAnswerIndex
                    ? AppTheme.successColor
                    : AppTheme.errorColor,
                width: 2,
              )
            : BorderSide.none,
      ),
      color: _getOptionColor(index),
      child: InkWell(
        onTap: _hasAnswered ? null : () => _checkAnswer(index),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.mediumSpacing),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                radius: 18,
                child: Text(
                  String.fromCharCode(65 + index), // A, B, C, D
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: AppConstants.mediumSpacing),
              Expanded(
                child: Text(
                  question.options[index],
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (_hasAnswered && _getOptionIcon(index) != null)
                Icon(
                  _getOptionIcon(index),
                  color: _getOptionIconColor(index),
                  size: 28,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
