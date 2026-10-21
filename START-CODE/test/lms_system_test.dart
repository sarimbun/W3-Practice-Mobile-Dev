import 'package:test/test.dart';

import '../lib/service/lms_system.dart';

void main() {
  test('creates a student', () {
    final lms = LmsSystem();

    // Create a student
    lms.addStudent(studentId: 'S1', studentName: "ronan");

    expect(lms.students.first.name, 'ronan');

    // Remove the student
    lms.removeStudent(studentId: 'S1');
    expect(lms.students.length, 0);
  });
  
  test('creates a course', () {
    final lms = LmsSystem();

    lms.addCourse(courseId: 'C1', courseName: "Mobile Development");
    expect(lms.courses.first.name, 'Mobile Development');

    lms.removeCourse(courseId: 'C1');
    expect(lms.courses.length, 0);
  });
  
  test('Reject a duplicate course ID', () {
    final lms = LmsSystem();

    // Create a course
    lms.addCourse(courseId: 'C1', courseName: "Mobile Development");

    // reject duplicate course
    expect(
      () => lms.addCourse(courseId: 'C1', courseName: 'Game Development'),
      throwsException
    );

  });

  test('Reject removal of a nonexistent course', () {
    final lms = LmsSystem();

    expect(
      () => lms.removeCourse(courseId: 'C5'),
      throwsException
    );
  });

  test('add a student to a course', () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: 'Ronan');
    lms.addCourse(courseId: 'C1', courseName: 'Mobile Development');
    
    //Enroll an existing student in an existing course. 
    lms.enrollStudent(studentId: 'S1', courseId: 'C1');

    expect(lms.courses.first.studentIds, contains('S1'));

  });

  test('Reject enrollment if the student does not exist', () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: 'Ronan');
    lms.addCourse(courseId: 'C1', courseName: 'Mobile Development');

    expect(
      () => lms.enrollStudent(studentId: 'S9', courseId: 'C1'),
      throwsException,
    );
  });

  test('Reject enrollment if the course does not exist', () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: 'Ronan');
    lms.addCourse(courseId: 'C1', courseName: 'Mobile Development');

    expect(
      () => lms.enrollStudent(studentId: 'S1', courseId: 'C5'),
      throwsException,
    );
  });

  test('Reject duplicate enrollment', () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: 'Ronan');
    lms.addCourse(courseId: 'C1', courseName: 'Mobile Development');

    lms.enrollStudent(studentId: 'S1', courseId: 'C1');

    expect(
      () => lms.enrollStudent(studentId: 'S1', courseId: 'C1'),
      throwsException,
    );
  });
 
 }

