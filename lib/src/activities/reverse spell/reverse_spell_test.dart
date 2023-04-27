// import 'package:flutter_test/flutter_test.dart';
// import 'package:test/test.dart';  
// part of 'reverse_spell.dart';
// void main() {
//   group('_ReverseSpellActivityState', () {
//     late _ReverseSpellActivityState reverseSpellActivityState;

//     setUp(() {
//       reverseSpellActivityState = _ReverseSpellActivityState();
//     });

//     test('Correct answer', () {
//       // Set the target word
//       reverseSpellActivityState.target_word = 'hello';

//       // Set the user input to the correct reversed spelling of the target word
//       reverseSpellActivityState._textEditingController.text = 'olleh';

//       // Call the method to evaluate the answer
//       reverseSpellActivityState._onEvaluateAnswer();

//       // Assert that the correct answer is true and the correct text color is green
//       expect(reverseSpellActivityState.correctAns, true);
//       expect(reverseSpellActivityState.correctTextColor, Colors.green);
//     });

//     test('Incorrect answer', () {
//       // Set the target word
//       reverseSpellActivityState.target_word = 'hello';

//       // Set the user input to an incorrect reversed spelling of the target word
//       reverseSpellActivityState._textEditingController.text = 'lehlo';

//       // Call the method to evaluate the answer
//       reverseSpellActivityState._onEvaluateAnswer();

//       // Assert that the correct answer is false and the correct text color is red
//       expect(reverseSpellActivityState.correctAns, false);
//       expect(reverseSpellActivityState.correctTextColor, Colors.red);
//     });
//   });
// }
