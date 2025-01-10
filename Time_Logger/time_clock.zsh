#!/bin/zsh

# File to store the time log in CSV format (current directory)
LOG_FILE="./time_log.csv"

# Function to initialize the CSV file with headers if it doesn't exist
initialize_log_file() {
  if [[ ! -f $LOG_FILE ]]; then
    echo "Type,Timestamp,Goal,Completion" > "$LOG_FILE"
  fi
}

# Function to log the start of work
start_work() {
  local start_time=$(date '+%Y-%m-%d %H:%M:%S')
  echo "Enter the goal of your work:"
  read -r work_goal
  echo "START,$start_time,\"$work_goal\"," >> "$LOG_FILE"
  echo "Work started at $start_time with goal: $work_goal"
}

# Function to log the end of work
end_work() {
  local end_time=$(date '+%Y-%m-%d %H:%M:%S')
  local work_complete_status=""
  
  while [[ -z $work_complete_status ]]; do
    echo "Is the work complete? (y/n):"
    read -r work_complete
    case $work_complete in
      [yY])
        work_complete_status="Complete"
        ;;
      [nN])
        work_complete_status="Incomplete"
        ;;
      *)
        echo "Invalid input. Please enter 'y' or 'n'."
        ;;
    esac
  done

  echo "END,$end_time,,\"$work_complete_status\"" >> "$LOG_FILE"
  echo "Work ended at $end_time. Completion status: $work_complete_status"
}


# Main menu
initialize_log_file
echo "Time Clock"
echo "1. Start Work"
echo "2. End Work"
echo "3. View Log"
echo "4. Exit"
echo "Choose an option:"
read -r choice

case $choice in
  1)
    start_work
    ;;
  2)
    end_work
    ;;
  3)
    echo "Time Log:"
    if [[ -f $LOG_FILE ]]; then
      column -s, -t "$LOG_FILE"
    else
      echo "No logs available."
    fi
    ;;
  4)
    echo "Goodbye!"
    ;;
  *)
    echo "Invalid option. Please try again."
    ;;
esac
