#!/bin/bash
#
# Clone this repository and set up everything for a new service
#
# USAGE: create-project-from-template.sh <project-name>
#
# Example: create-project-from-template.sh My-Awesome-Project
#
PROJECT_CAMEL_CASE=$1
PROJECT_LOWER_CASE=$(echo "$PROJECT_CAMEL_CASE" | tr '[:upper:]' '[:lower:]')

function checkArgs() {

    # All parameters must contain a value
    if [ "$1x" != "x" -a "$2x" != "x" ]; then
	return
    fi

    echo 'USAGE: create-project-from-template.sh <project-name>'
    echo
    echo '<project-name>  Project name written with hyphens instead of'
    echo '                spaces and all words in camel case.'
    exit 1
}

checkArgs $PROJECT_CAMEL_CASE $PROJECT_LOWER_CASE
echo "Creating project $PROJECT_CAMEL_CASE in directory $PROJECT_LOWER_CASE"

# Clone this repository to the new project
echo "  1/6 Cloning ..."
git clone /Volumes/SBOOS/MyCloud/git/microservice-template "$PROJECT_LOWER_CASE"
echo "  2/6 Renaming remote origin to template ..."
pushd "$PROJECT_LOWER_CASE"
git remote rename origin template

# Rename all instances of "Microservice-Template" to the new project name
echo "  3/6 Asking the user to rename the project contents from Microservice-Template to $PROJECT_CAMEL_CASE ..."
"/Applications/Rename Project.app/Contents/MacOS/JavaAppLauncher"
git stash

# The rename method above will rename the upstream url as well. Correct this.
echo "  4/6 Reverting rename of the remote tracking branch ..."
git remote set-url template /Volumes/SBOOS/MyCloud/git/microservice-template.git

# Setup tracking the template master branch in a branch different from master
echo "  5/6 Renaming master to microservice-template-master and creating new master"
git branch --move master microservice-template-master
git branch master
git checkout master
git stash pop

echo "  6/6 Committing changes ..."
git commit -a -m "chore (init setup): use RenameProject to rename from microservice-template to $PROJECT_LOWER_CASE (by create-project-from-template.sh)"

popd
echo "Happy coding!"
