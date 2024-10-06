#!/bin/bash
mkdir submission_reminder_app
mkdir submission_reminder_app/app
touch submission_reminder_app/app/reminder.sh
cat > submission_reminder_app/app/reminder.sh
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file

mkdir submission_reminder_app/modules
touch submission_reminder_app/modules/functions.sh
cat > submission_reminder_app/modules/functions.sh
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}

mkdir submission_reminder_app/assets
mv submissions.txt submission_reminder_app/assets
cat >> submission_reminder_app/assets/submissions.txt

Claire, Shell Navigation, submitted
Hallellujah, Shell Navigation, not submitted
Claire, Shell Navigation, submitted
Mugisha, Shell Navigation, submitted
Hubert, Shell Navigation, not submitted

mkdir submission_reminder_app/config
touch submission_reminder_app/config/config.env
cat > submission_reminder_app/config/config.env
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2

touch submission_reminder_app/startup.sh
cat > submission_reminder_app/startup.sh
#!/bin/bash
if [ ! -f "submission_reminder_app/app/reminder.sh" ]; then
  echo "Error: Reminder app (submission_reminder_app/app/reminder.sh) not found!"
  exit 1
fi
cd submission_reminder_app/app
./reminder.sh
cd -

