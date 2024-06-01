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
- **List Today's Tasks (Default):**

```bash
./todo.sh
```
Lists all tasks scheduled for today, categorized by completion status.

- **Create a Task:**
```bash
./todo.sh create
```
Prompts the user to enter task details and adds the task to the list.

- **Update a Task**:
```bash
./todo.sh update
```
Displays the list of tasks and prompts the user to enter the ID of the task to update. Allows modification of task details.

- **Delete a Task:**
```bash
./todo.sh delete
```
Displays the list of tasks and prompts the user to enter the ID of the task to delete.

- ***Show a Task:**
```bash
./todo.sh show
```
Prompts the user to enter the title of the task to display its details.

- **List Tasks by Day:**
```bash
./todo.sh listbyday
```
Prompts the user to enter a date and lists tasks scheduled for that day, categorized by completion status.

- **Search Tasks by Title:**
```bash
./todo.sh search
```
Prompts the user to enter a title and displays tasks that match the title.
### Example Workflow
- **Add a Task:**
```bash
./todo.sh create
# Suivez les invites pour entrer les détails de la tâche :
# Titre : Acheter des courses
# Description : Acheter du lait, du pain, des œufs et des fruits.
# Localisation : Supermarché local
# Date d'échéance : 2024-06-02
# Complétion : non
```
- **List Today's Tasks:**
```bash
./todo.sh
# Tâches pour aujourd'hui (2024-06-01) :
# Tâches non complétées :
# ID: 1 - Titre: Acheter des courses - Description: Acheter du lait, des œufs, et du pain - Localisation: Supermarché - Date: 2024-06-01 - Complétée: non
# ID: 4 - Titre: Football - Description: 11 VS 11 - Localisation: Rabat - Date: 2024-06-01 - Complétée: non
# Tâches complétées :
# ID: 7 - Titre: Faire du sport - Description: Aller courir au parc pendant 30 minutes. - Localisation: Parc - Date: 2024-06-01 - Complétée: oui
```
- **Update a Task:**
```bash
./todo.sh update
Liste des tâches :
ID: 1 - Titre: Acheter des courses - Description: Acheter du lait, des œufs, et du pain - Localisation: Supermarché - Date: 2024-06-01 - Complétée: non
ID: 2 - Titre: Faire les devoirs de maths - Description: Résoudre les exercices du chapitre 3 - Localisation: Maison - Date: 2024-06-02 - Complétée: non
ID: 3 - Titre: Lire un livre - Description: Lire 'Le Petit Prince' de Saint-Exupéry - Localisation: Maison - Date: 2024-06-04 - Complétée: non
ID: 4 - Titre: Football - Description: 11 VS 11 - Localisation: Rabat - Date: 2024-06-01 - Complétée: non
ID: 5 - Titre: Appeler le service client - Description: Appeler le service client pour résoudre un problème de facturation. - Localisation: Maison - Date: 2024-06-04 - Complétée: non
ID: 6 - Titre: Réserver un billet d'avion - Description: Réserver un billet pour le voyage d'affaires à Paris. - Localisation: Internet - Date: 2024-06-06 - Complétée: non
ID: 7 - Titre: Faire du sport - Description: Aller courir au parc pendant 30 minutes. - Localisation: Parc - Date: 2024-06-01 - Complétée: oui
ID: 8 - Titre: Lire un chapitre du livre - Description: Lire le chapitre 5 du livre "L'art de la simplicité". - Localisation: Maison - Date: 2024-06-02 - Complétée: non
ID: 9 - Titre: Organiser une réunion - Description: Organiser une réunion avec l'équipe de marketing pour discuter de la nouvelle campagne. - Localisation: Salle de conférence 2 - Date: 2024-06-03 - Complétée: non
ID: 10 - Titre: Planter des fleurs - Description: Planter des tulipes dans le jardin. - Localisation: Jardin - Date: 2024-06-04 - Complétée: non
Entrez l'ID de la tâche à mettre à jour : 1
Entrez les nouvelles informations pour la tâche. Laissez vide pour garder les valeurs actuelles.
Nouveau titre : Acheter des courses alimentaires
Nouvelle description : Acheter du lait, des œufs, du pain et des fruits.
Nouvelle localisation : Supermarché local
Nouvelle date (format YYYY-MM-DD) : 2024-06-02
Marqueur de complétion (oui/non) :
Tâche mise à jour avec succès.
```
### Error Handling
- The script includes error handling for invalid input, such as empty titles, invalid dates, and non-existent task IDs.
- Default values are provided for some fields if the user input is invalid or left empty.


