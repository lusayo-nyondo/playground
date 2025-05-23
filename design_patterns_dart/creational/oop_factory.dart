class Person {}

class Teacher extends Person {}

class Student extends Person {}

class PersonFactory {
  static Person create(String type) {
    return switch (type) {
      'teacher' => Teacher(),
      'student' => Student(),
      _ => throw Exception(),
    };
  }
}

void main() {
  Teacher teacher = PersonFactory.create('teacher') as Teacher;
  Student student = PersonFactory.create('student') as Student;

  print('Teacher is $teacher');
  print('Student is $student');
}
