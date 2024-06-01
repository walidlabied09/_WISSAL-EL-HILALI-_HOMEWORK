README

# Overview

This Bash script serves as a task manager, allowing users to efficiently organize their tasks. It provides functionality for creating, updating, deleting, showing, and listing tasks. Tasks are stored in a text file (`tasks.txt`) and identified by unique IDs.

## Design Choices
### Data Storage
- **Text File:** Tasks are stored in a text file named tasks.txt. This format is chosen for its simplicity and ease of use with Bash commands.
- **Fields:** Each task in the text file has the following fields:
    - `id`: Unique identifier for the task.
    - `title`: Title of the task.
    - `description`: Description of the task.
    - `location`: Location where the task is to be performed.
    - `due_date`: Due date of the task in YYYY-MM-DD format.
    - `completion`: Marker indicating whether the task is completed (yes/no).
### Code Organization
The todo.sh script is organized into several key functions, each responsible for a specific operation on the todo list. Here is a detailed overview of the organization and functionality:

- **Initialization:**
`ID_FILE`: The script uses a file named `current_id.txt` to keep track of the current highest task ID.
If `current_id.txt` does not exist, it initializes the current ID to 0. This ensures each new task gets a unique identifier.

- **Main Functionality:**
The script's main functionality is divided into several functions that correspond to different actions users can perform on their todo list. Each function is designed to handle specific tasks, ensuring modular and maintainable code.

- **Functions:**

    - `create_task:`
        Prompts the user for task details, including title, description, location, due date, and completion status.
        Validates required fields (title and due date) and increments the task ID.
        Saves the new task to tasks.txt and updates current_id.txt.
    - `update_task:`
        Lists all tasks and prompts the user to enter the ID of the task they want to update.
        Allows the user to update the title, description, location, due date, and completion status.
        Updates the task in tasks.txt with the new information.
    - `delete_task:`
        Lists all tasks and prompts the user to enter the ID of the task they want to delete.
        Removes the specified task from tasks.txt.
    - `show_task:`
        Prompts the user to enter the title of the task they want to view.
        Displays the details of the specified task.
    - `list_tasks_by_day:`
        Prompts the user to enter a date.
        Lists all tasks due on the specified date, categorized into completed and uncompleted tasks.
    - `search_task_by_title:`
        Prompts the user to enter the title of the task they want to search for.
        Lists all tasks matching the specified title.
    - `list_today_tasks:`
        Automatically lists all tasks due today, categorized into completed and uncompleted tasks.
- **Command Line Options:**
    The script accepts command-line arguments to perform different actions:
    - `create:` Add a new task.
    - `update:` Update an existing task.
    - `delete:` Delete a task.
    - `show:` Display a specific task by title.
    - `listbyday:` List tasks due on a specific date.
    - `search:` Search for tasks by title.
    If no arguments are provided, it lists tasks due today.

## Script Usage

### Running the Script
Make sure the script has executable permissions. You can grant execute permission using the following command: chmod +x todo.sh

### Commands
- **List Today's Tasks (Default)**:

```bash
./todo.sh
```
Lists all tasks scheduled for today, categorized by completion status.

- **Create a Task**:
```bash
./todo.sh create
```
Prompts the user to enter task details and adds the task to the list.

- **Update a Task**:
```bash
./todo.sh update
```
Displays the list of tasks and prompts the user to enter the ID of the task to update. Allows modification of task details.

- **Delete a Task**:
```bash
./todo.sh delete
```
Displays the list of tasks and prompts the user to enter the ID of the task to delete.

- ***Show a Task**:
```bash
./todo.sh show
```
Prompts the user to enter the title of the task to display its details.

- ***List Tasks by Day***:
```bash
./todo.sh listbyday
```
Prompts the user to enter a date and lists tasks scheduled for that day, categorized by completion status.

- ***Search Tasks by Title***:
```bash
./todo.sh search
```
Prompts the user to enter a title and displays tasks that match the title.

### Error Handling
    -The script includes error handling for invalid input, such as empty titles, invalid dates, and non-existent task IDs.
    -Default values are provided for some fields if the user input is invalid or left empty.


