List<Task> tasks = [];

class Task {
  final String taskTitle;
  final String taskDesc;
  final String taskPoints;
  final String createdAt;
  final String dueDate;
  final String assignedTo;
  final String originalPoster;
  final TaskStatus taskStatus;

  Task(
      {this.taskTitle,
      this.taskDesc,
      this.createdAt,
      this.dueDate,
      this.taskPoints,
      this.taskStatus,
      this.originalPoster,
      this.assignedTo});
}

enum TaskStatus { IDLE, IN_REVIEW, DONE }
