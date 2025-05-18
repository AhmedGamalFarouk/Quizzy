import 'package:flutter/material.dart';
import 'package:quizz_app/Screens/question_page.dart';
import 'package:quizz_app/constants/app_constants.dart';
import 'package:quizz_app/models/category.dart';
import 'package:quizz_app/theme/app_theme.dart';

class CategoriesPage extends StatefulWidget {
  final String username;

  const CategoriesPage({super.key, required this.username});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
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
    final size = MediaQuery.of(context).size;

    final categories = [
      Category(
          title: 'Math',
          color: theme.colorScheme.primary,
          icon: Icons.calculate_rounded),
      Category(
          title: 'English', color: Colors.green, icon: Icons.menu_book_rounded),
      Category(
          title: 'IQ', color: Colors.orange, icon: Icons.psychology_rounded),
      Category(title: 'Art', color: Colors.purple, icon: Icons.palette_rounded),
      Category(
          title: 'Science', color: Colors.teal, icon: Icons.science_rounded),
      Category(
          title: 'History',
          color: Colors.brown,
          icon: Icons.history_edu_rounded),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Categories'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Log Out?'),
                  content: const Text('Are you sure you want to log out?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: const Text('Log Out'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background decoration
          Positioned(
            top: size.height * 0.15,
            left: -size.width * 0.15,
            child: Container(
              height: size.width * 0.5,
              width: size.width * 0.5,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -size.height * 0.1,
            right: -size.width * 0.1,
            child: Container(
              height: size.width * 0.6,
              width: size.width * 0.6,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.mediumSpacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Welcome header
                  FadeTransition(
                    opacity: _fadeInAnimation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -0.2),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: _controller,
                        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
                      )),
                      child: Container(
                        padding:
                            const EdgeInsets.all(AppConstants.mediumSpacing),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.colorScheme.primary.withOpacity(0.7),
                              theme.colorScheme.primary,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(
                              AppConstants.borderRadiusLarge),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Colors.white.withOpacity(0.2),
                                  radius: 24,
                                  child: const Icon(
                                    Icons.person_rounded,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Welcome,',
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                          color: Colors.white.withOpacity(0.9),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        widget.username,
                                        style: theme.textTheme.headlineMedium
                                            ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Choose a category to start the quiz!',
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppConstants.mediumSpacing),

                  // Stats summary
                  FadeTransition(
                    opacity: CurvedAnimation(
                      parent: _controller,
                      curve: const Interval(0.2, 0.8, curve: Curves.easeIn),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(AppConstants.mediumSpacing),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(
                            AppConstants.borderRadiusLarge),
                        boxShadow: [
                          BoxShadow(
                            color: theme.shadowColor.withOpacity(0.05),
                            blurRadius: 10,
                            spreadRadius: 0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem(
                            context,
                            Icons.quiz_rounded,
                            '${categories.length}',
                            'Categories',
                            theme.colorScheme.primary,
                          ),
                          _buildDivider(context),
                          _buildStatItem(
                            context,
                            Icons.timer_rounded,
                            '5 min',
                            'Per quiz',
                            theme.colorScheme.secondary,
                          ),
                          _buildDivider(context),
                          _buildStatItem(
                            context,
                            Icons.emoji_events_rounded,
                            '100%',
                            'Top score',
                            AppTheme.warningColor,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: AppConstants.mediumSpacing),

                  Text(
                    'Quiz Categories',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: AppConstants.smallSpacing),

                  // Categories grid
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: AppConstants.mediumSpacing,
                        mainAxisSpacing: AppConstants.mediumSpacing,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        // Staggered animation for each category
                        final delay = index * 0.1;
                        return AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            final animation = CurvedAnimation(
                              parent: _controller,
                              curve: Interval(
                                0.4 + delay, // Staggered start time
                                0.8 + delay, // Staggered end time
                                curve: Curves.easeOut,
                              ),
                            );

                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 0.5),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              ),
                            );
                          },
                          child: CategoryCard(
                            category: categories[index],
                            onTap: () =>
                                _startQuiz(context, categories[index].title),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, IconData icon, String value,
      String label, Color color) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 40,
      width: 1,
      decoration: BoxDecoration(
        color: theme.dividerColor.withOpacity(0.3),
      ),
    );
  }

  void _startQuiz(BuildContext context, String categoryTitle) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => QuestionPage(
          username: widget.username,
          categoryName: categoryTitle,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutQuint,
                ),
              ),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shadowColor: category.color.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
        splashColor: category.color.withOpacity(0.1),
        highlightColor: category.color.withOpacity(0.05),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                category.color.withOpacity(0.8),
                category.color,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.mediumSpacing),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  category.icon ?? Icons.quiz_rounded,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(height: AppConstants.smallSpacing),
                Text(
                  category.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
