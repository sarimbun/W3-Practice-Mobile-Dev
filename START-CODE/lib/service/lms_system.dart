import '../model/student.dart';
import '../model/course.dart';

class LmsSystem {
  final List<Student> students = [];
  final List<Course> courses =[];

  void addStudent({required String studentId, required String studentName}) {
    // ! Student shall not exist already
    Student? student = _findStudentOrNull(studentId);
    if (student != null) {
      throw Exception('Student $studentId already exists');
    }

    students.add(Student(id: studentId, name: studentName));
  }
 
 
  void removeStudent({required String studentId}) {
    Student? student = _findStudentOrNull(studentId);
    if (student == null) {
      throw Exception('Student $studentId not found');
    }
    // 1- Remove student from the students list
    students.removeWhere((student) => student.id == studentId);
 
  }

  Student? _findStudentOrNull(String studentId) {
    for (Student s in students) {
      if (s.id == studentId) {
        return s;
      }
    }
    return null; // not found
  } 
// Task 1: add and remove course
  void addCourse({required String courseId, required String courseName}) {
    Course? course = _findCourseOrNull(courseId);
    if (course != null) {
      throw Exception('Course $courseId already exist');
    }
    courses.add(Course(id: courseId, name: courseName));
  }

  void removeCourse({required String courseId}) {
    Course? course = _findCourseOrNull(courseId);
    if (course == null) {
      throw Exception('Course $courseId is not found');
    }
    courses.removeWhere((course) => course.id == courseId);
  }

  Course? _findCourseOrNull(String courseId) {
    for (Course c in courses) {
      if (c.id == courseId) {
        return c;
      }
    }
    return null; // not found
  } 
// Task 2: enroll a student into a course
  void enrollStudent({required String studentId, required String courseId}) {
    Student? student = _findStudentOrNull(studentId);
    Course? course = _findCourseOrNull(courseId);

    if (student == null) {
      throw Exception('There is no student $studentId yet');
    }

    if (course == null) {
      throw Exception('There is no course $courseId yet');
    }

    if (course.studentIds.contains(studentId)) {
      throw Exception('Student $studentId already enrolled in $courseId');
    }
    course.studentIds.add(studentId);
  }

// Task 3: Remove a student from a course 
  void discardStudentFromCourse({required String studentId, required String courseId}) {
    Student? student = _findStudentOrNull(studentId);
    Course? course = _findCourseOrNull(courseId);

    // Student must exist
    if (student == null) {
      throw Exception('There is no student $studentId yet');
    }

    // Course must exist
    if (course == null) {
      throw Exception('There is no course $courseId yet');
    }

    // Student is not enrolled
    if (course.studentIds.contains(studentId)) {
      throw Exception('Student $studentId already enrolled in $courseId');
    }
    course.studentIds.add(studentId);
  }
}
