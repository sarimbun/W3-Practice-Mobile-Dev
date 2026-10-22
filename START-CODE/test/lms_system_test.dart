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

  test('remove an existing enrollment', () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: 'Ronan');
    lms.addCourse(courseId: 'C1', courseName: 'Mobile Development');
    lms.enrollStudent(studentId: 'S1', courseId: 'C1');

    lms.discardStudentFromCourse(studentId:'S1', courseId: 'C1');

    expect(lms.courses.first.studentIds, isEmpty);

    expect(lms.students.length, 1);
    expect(lms.courses.length, 1);

  });
 

 test('rejects removing a nonexistent enrollment', () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: 'Ronan');
    lms.addCourse(courseId: 'C1', courseName: 'Mobile Development');

    expect(
      () => lms.discardStudentFromCourse(studentId: 'S1', courseId: 'C1'),
      throwsException,
    );
  });

  test('removing a student removes them from all courses', () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: 'Ronan');
    lms.addCourse(courseId: 'C1', courseName: 'Mobile Development');

    lms.addStudent(studentId: 'S2', studentName: 'Sarim');
    lms.addCourse(courseId: 'C2', courseName: 'Game Development');
    //enroll students into both courses
    lms.enrollStudent(studentId: 'S1', courseId: 'C1');
    lms.enrollStudent(studentId: 'S1', courseId: 'C2');

    lms.enrollStudent(studentId: 'S2', courseId: 'C1');
    lms.enrollStudent(studentId: 'S2', courseId: 'C2');

    lms.removeStudent(studentId: 'S1');

    expect(lms.courses[0].studentIds, isNot(contains('S1')));
    expect(lms.courses[1].studentIds, isNot(contains('S1')));

    expect(lms.courses[0].studentIds, contains('S2'));
    expect(lms.courses[1].studentIds, contains('S2'));

    expect(lms.students.length, 1);
  });

  test('Add a valid result', () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: 'Ronan');
    lms.addCourse(courseId: 'C1', courseName: 'Mobile Development');

    lms.enrollStudent(studentId: 'S1', courseId: 'C1');

    lms.addResult(studentId: 'S1', courseId: 'C1', score: 85);

    expect(lms.results.length, 1);
    expect(lms.results.first.score, 85);
    expect(lms.courses.first.studentIds, contains('S1'));
  });

  test('Reject a result for a nonexistent student', () {
    final lms = LmsSystem();
    lms.addCourse(courseId: 'C1', courseName: 'Mobile Development');

    expect(
      () => lms.addResult(studentId: 'S3', courseId: 'C1', score: 85),
      throwsException,
    );
  });

  test('Reject a result for a nonexistent course', () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: 'Ronan');

    expect(
      () => lms.addResult(studentId: 'S1', courseId: 'C3', score: 85),
      throwsException,
    );
  });
  
  test('Reject a result for a student who is not enrolled', () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: 'Ronan');
    lms.addStudent(studentId: 'S2', studentName: 'Sarim');
    lms.addCourse(courseId: 'C1', courseName: 'Mobile Development');

    lms.enrollStudent(studentId: 'S1', courseId: 'C1');

    expect(
      () => lms.addResult(studentId: 'S2', courseId: 'C1', score: 85),
      throwsException,
    );
  });

  test('Reject an invalid score', () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: 'Ronan');
    lms.addCourse(courseId: 'C1', courseName: 'Mobile Development');

    lms.enrollStudent(studentId: 'S1', courseId: 'C1');

    expect(
      () => lms.addResult(studentId: 'S1', courseId: 'C1', score: 101),
      throwsException,
    );

    expect(
      () => lms.addResult(studentId: 'S1', courseId: 'C1', score: -1),
      throwsException,
    );
  });

  test('Test the chosen policy for duplicate results', () {
    final lms = LmsSystem();
    lms.addStudent(studentId: 'S1', studentName: 'Ronan');
    lms.addCourse(courseId: 'C1', courseName: 'Mobile Development');

    lms.enrollStudent(studentId: 'S1', courseId: 'C1');

    lms.addResult(studentId: 'S1', courseId: 'C1', score: 85);

    expect(
      () => lms.addResult(studentId: 'S1', courseId: 'C1', score: 85),
      throwsException,
    );

    expect(lms.results.length, 1);
  });
 }