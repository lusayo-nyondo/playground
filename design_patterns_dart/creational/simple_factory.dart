/***
 * Simple factory implementation using dart's language
 * features.
 */

class Person {
  Person();

  factory Person.create(String type) {
    return switch (type) {
      'teacher' => Teacher(),
      'student' => Student(),
      _ => throw Exception(),
    };
  }
}

class Teacher extends Person {}

class Student extends Person {}

void main() {
  Teacher teacher = Person.create('teacher') as Teacher;
  Student student = Person.create('student') as Student;

  print("Teacher is: $teacher");
  print("Student is: $student");
}
