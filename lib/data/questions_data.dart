import 'package:quizz_app/models/question.dart';

class QuestionsData {
  static final Map<String, List<Question>> questionsByCategory = {
    'Math': [
      Question(
        questionText: 'What is 2 + 2?',
        options: ['3', '4', '5', '6'],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText: 'What is the square root of 9?',
        options: ['3', '4', '2', '6'],
        correctAnswerIndex: 0,
      ),
      Question(
        questionText: 'What is 7 × 8?',
        options: ['54', '56', '48', '64'],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText: 'What is 10% of 200?',
        options: ['10', '20', '30', '40'],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText: 'If x = 5, what is 2x + 3?',
        options: ['8', '10', '13', '15'],
        correctAnswerIndex: 2,
      ),
    ],
    'English': [
      Question(
        questionText: 'Which word is a synonym for "happy"?',
        options: ['Sad', 'Joyful', 'Angry', 'Tired'],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText: 'Which sentence is grammatically correct?',
        options: [
          'She don\'t like pizza.',
          'They was at the park.',
          'He doesn\'t want to go.',
          'We is going to school.'
        ],
        correctAnswerIndex: 2,
      ),
      Question(
        questionText: 'What is the plural form of "child"?',
        options: ['Childs', 'Childes', 'Children', 'Childrens'],
        correctAnswerIndex: 2,
      ),
      Question(
        questionText: 'Which word is an antonym for "big"?',
        options: ['Large', 'Huge', 'Small', 'Enormous'],
        correctAnswerIndex: 2,
      ),
      Question(
        questionText: 'What part of speech is the word "quickly"?',
        options: ['Noun', 'Verb', 'Adjective', 'Adverb'],
        correctAnswerIndex: 3,
      ),
    ],
    'IQ': [
      Question(
        questionText:
            'Which number comes next in the sequence: 2, 4, 8, 16, ...?',
        options: ['24', '32', '20', '18'],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText: 'If a = 2b and b = 3c, then a = ?',
        options: ['5c', '6c', '8c', 'c/6'],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText:
            'Which shape doesn\'t belong? Circle, Square, Triangle, Rectangle',
        options: ['Circle', 'Square', 'Triangle', 'Rectangle'],
        correctAnswerIndex: 0,
      ),
      Question(
        questionText:
            'What is the next letter in the sequence: A, C, E, G, ...?',
        options: ['H', 'I', 'J', 'K'],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText:
            'If you rearrange the letters "ANLDEG" you get the name of a:',
        options: ['Animal', 'Country', 'City', 'Fruit'],
        correctAnswerIndex: 1, // ENGLAND
      ),
    ],
    'Art': [
      Question(
        questionText: 'Who painted the Mona Lisa?',
        options: [
          'Vincent van Gogh',
          'Pablo Picasso',
          'Leonardo da Vinci',
          'Michelangelo'
        ],
        correctAnswerIndex: 2,
      ),
      Question(
        questionText: 'Which art movement is Salvador Dalí associated with?',
        options: [
          'Impressionism',
          'Cubism',
          'Surrealism',
          'Abstract Expressionism'
        ],
        correctAnswerIndex: 2,
      ),
      Question(
        questionText: 'In which city is the Louvre Museum located?',
        options: ['Rome', 'Paris', 'London', 'New York'],
        correctAnswerIndex: 1,
      ),
      Question(
        questionText:
            'Which color is not considered a primary color in painting?',
        options: ['Red', 'Yellow', 'Green', 'Blue'],
        correctAnswerIndex: 2,
      ),
      Question(
        questionText: 'Who created the sculpture "David"?',
        options: ['Donatello', 'Michelangelo', 'Leonardo da Vinci', 'Raphael'],
        correctAnswerIndex: 1,
      ),
    ],
  };
}
