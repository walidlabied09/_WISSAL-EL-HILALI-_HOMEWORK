#!/bin/bash

TASK_FILE="tasks.txt"
ID_FILE="current_id.txt"

# Initialiser l'ID actuel à partir du fichier ID_FILE ou définir à 0 si le fichier n'existe pas
if [[ -f "$ID_FILE" ]]; then
    CURRENT_ID=$(cat "$ID_FILE")
else
    CURRENT_ID=0
fi

create_task() {
    while true; do
        echo "Entrez le titre de la tâche (obligatoire) :"
        read -r titre
        if [[ -z "$titre" ]]; then
            echo "Le titre est obligatoire." >&2
        else
            break
        fi
    done

    echo "Entrez la description de la tâche (optionnelle) :"
    read -r description

    echo "Entrez la localisation de la tâche (optionnelle) :"
    read -r localisation

    while true; do
        echo "Entrez la date de la tâche (format YYYY-MM-DD, obligatoire) :"
        read -r datee
        if [[ -z "$datee" ]]; then
            echo "La date est obligatoire." >&2
        elif date -d "$datee" "+%Y-%m-%d" >/dev/null 2>&1; then
            break  
        else
            echo "Format de date invalide. Veuillez utiliser le format YYYY-MM-DD." >&2
        fi
    done

    echo "Entrez le marqueur de complétion (oui/non, obligatoire) :"
    read -r completion
    if [[ "$completion" != "oui" && "$completion" != "non" ]]; then
        completion="non"  
    fi

    ((CURRENT_ID++))
    echo "$CURRENT_ID" > "$ID_FILE"  

\
    echo "$CURRENT_ID,$titre,$description,$localisation,$datee,$completion" >> "$TASK_FILE"

    echo "Tâche créée avec succès :"
    echo "ID : $CURRENT_ID"
    echo "Titre : $titre"
    echo "Description : $description"
    echo "Localisation : $localisation"
    echo "Date : $datee"
    echo "Marqueur de complétion : $completion"
}

update_task() {
    echo "Liste des tâches :"
    while IFS=',' read -r id titre description localisation datee completion; do
        echo "ID: $id - Titre: $titre - Description: $description - Localisation: $localisation - Date: $datee - Complétée: $completion"
    done < "$TASK_FILE"

    while true; do
        read -p "Entrez l'ID de la tâche à mettre à jour : " task_id
        if ! grep -q "^$task_id," "$TASK_FILE"; then
            echo "ID de tâche invalide." >&2
        else
            break
        fi
    done

    echo "Entrez les nouvelles informations pour la tâche. Laissez vide pour garder les valeurs actuelles."
    read -p "Nouveau titre : " new_titre
    read -p "Nouvelle description : " new_description
    read -p "Nouvelle localisation : " new_localisation
    read -p "Nouvelle date (format YYYY-MM-DD) : " new_datee
    read -p "Marqueur de complétion (oui/non) : " new_completion

 
    current_task=$(grep "^$task_id," "$TASK_FILE")
    IFS=',' read -r id current_titre current_description current_localisation current_datee current_completion <<< "$current_task"

    
    new_titre=${new_titre:-$current_titre}
    new_description=${new_description:-$current_description}
    new_localisation=${new_localisation:-$current_localisation}
    new_datee=${new_datee:-$current_datee}
    new_completion=${new_completion:-$current_completion}

    
    sed -i "/^$task_id,/c\\$task_id,$new_titre,$new_description,$new_localisation,$new_datee,$new_completion" "$TASK_FILE"

    echo "Tâche mise à jour avec succès."
}

delete_task() {
    echo "Liste des tâches :"
    while IFS=',' read -r id titre description localisation datee completion; do
        echo "ID: $id - Titre: $titre - Description: $description - Localisation: $localisation - Date: $datee - Complétée: $completion"
    done < "$TASK_FILE"

    while true; do
        read -p "Entrez l'ID de la tâche à supprimer : " task_id
        if ! grep -q "^$task_id," "$TASK_FILE"; then
            echo "ID de tâche invalide." >&2
        else
            break
        fi
    done

    sed -i "/^$task_id,/d" "$TASK_FILE"

    echo "Tâche supprimée avec succès."
}

show_task() {
    while true; do
        read -p "Entrez le titre de la tâche à afficher : " task_title
        if grep -q ",$task_title," "$TASK_FILE"; then
            echo "Informations de la tâche :"
            grep ",$task_title," "$TASK_FILE"
            break
        else
            echo "Titre de tâche invalide ou non trouvé." >&2
        fi
    done
}

list_tasks_by_day() {
    while true; do
        echo "Entrez la date (format YYYY-MM-DD) pour afficher les tâches de cette journée :"
        read -r selected_date
        if date -d "$selected_date" "+%Y-%m-%d" >/dev/null 2>&1; then
            break  
        else
            echo "Format de date invalide. Veuillez utiliser le format YYYY-MM-DD." >&2
        fi
    done

    echo "Tâches pour le jour $selected_date :"

    echo "Tâches non complétées :"
    grep ",$selected_date," "$TASK_FILE" | grep ",non$" | while IFS=',' read -r id titre description localisation datee completion; do
        echo "ID: $id - Titre: $titre - Description: $description - Localisation: $localisation - Date: $datee - Complétée: $completion"
    done

    echo "Tâches complétées :"
    grep ",$selected_date," "$TASK_FILE" | grep ",oui$" | while IFS=',' read -r id titre description localisation datee completion; do
        echo "ID: $id - Titre: $titre - Description: $description - Localisation: $localisation - Date: $datee - Complétée: $completion"
    done
}

search_task_by_title() {
    while true; do
        read -p "Entrez le titre de la tâche à rechercher : " search_title
        if grep -q ",$search_title," "$TASK_FILE"; then
            echo "Tâches avec le titre '$search_title' :"
            grep ",$search_title," "$TASK_FILE"
            break
        else
            echo "Aucune tâche trouvée avec le titre '$search_title'." >&2
        fi
    done
}

list_today_tasks() {
    today=$(date "+%Y-%m-%d")

    echo "Tâches pour aujourd'hui ($today) :"

    echo "Tâches non complétées :"
    grep ",$today," "$TASK_FILE" | grep ",non$" | while IFS=',' read -r id titre description localisation datee completion; do
        echo "ID: $id - Titre: $titre - Description: $description - Localisation: $localisation - Date: $datee - Complétée: $completion"
    done

    echo "Tâches complétées :"
    grep ",$today," "$TASK_FILE" | grep ",oui$" | while IFS=',' read -r id titre description localisation datee completion; do
        echo "ID: $id - Titre: $titre - Description: $description - Localisation: $localisation - Date: $datee - Complétée: $completion"
    done
}

if [[ $# -eq 0 ]]; then
    list_today_tasks
else
    case "$1" in
        create)
            create_task
            ;;
        update)
            update_task
            ;;
        delete)
            delete_task
            ;;
        show)
            show_task
            ;;
        listbyday)
            list_tasks_by_day
            ;;
        search)
            search_task_by_title
            ;;
        *)
            echo "Option invalide. Options disponibles : create, update, delete, show, listbyday, search." >&2
            ;;
    esac
fi