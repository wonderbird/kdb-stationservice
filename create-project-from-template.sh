#!/bin/bash
#
# Clone this repository and set up everything for a new service
#
# USAGE: create-project-from-template.sh <project-name>
#
# Example: create-project-from-template.sh My-Awesome-Project
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export PROJECT_CAMEL_CASE=$1
export PROJECT_LOWER_CASE=$(echo "$PROJECT_CAMEL_CASE" | tr '[:upper:]' '[:lower:]')
export REMOTE_URL=

function validateScriptArguments() {
    # All parameters must contain a value
    if [ "x$PROJECT_CAMEL_CASE" != "x" \
	-a "x$PROJECT_LOWER_CASE" != "x" ]; then
	return
    fi

    echo 'USAGE: create-project-from-template.sh <project-name>'
    echo
    echo '<project-name>  Project name written with hyphens instead of'
    echo '                spaces and all words in camel case.'
    exit 1
}

function buildRuntimeEnvironment() {
    pushd "$DIR"
    REMOTE_URL=$(git remote get-url origin)
    popd
}

function validateRuntimeEnvironment() {
    if [ "x$REMOTE_URL" == "x" ]; then
	echo Error: Cannot determine git remote URL.
	exit 1
    fi
}

function cloneToNewProject() {
    # Clone this repository to the new project
    echo "  1/6 Cloning ..."
    git clone "$REMOTE_URL" "$PROJECT_LOWER_CASE"
}

function renameGitRemoteOriginToTemplate() {
    echo "  2/6 Renaming remote origin to template ..."
    git remote rename origin template
}

function renameFilesAndContentsToProjectName() {
    # Rename all instances of "Kdb-StationService" to the new project name
    echo "  3/6 Asking the user to rename the project contents from Kdb-StationService to $PROJECT_CAMEL_CASE ..."
    "/Applications/Rename Project.app/Contents/MacOS/JavaAppLauncher"
}

function revertRenamingUpstreamUrls() {
    # The rename method above will rename the upstream url as well. Correct this.
    echo "  4/6 Reverting rename of the remote tracking branch ..."
    git remote set-url template /Volumes/SBOOS/MyCloud/git/kdb-stationservice.git
}

function correctTrackingBranches() {
    # Setup tracking the template master branch in a branch different from master
    echo "  5/6 Renaming master to kdb-stationservice-master and creating new master"
    git branch --move master kdb-stationservice-master
    git branch master
    git checkout master
}

function commitChangesToNewGitRepository() {
    echo "  6/6 Committing changes ..."
    git commit -a -m "chore (init setup): use RenameProject to rename from kdb-stationservice to $PROJECT_LOWER_CASE (automatic commit by create-project-from-template.sh)"
}

function fixUpstreamUrlAndCreateNewMasterBranch() {
    git stash
    
    revertRenamingUpstreamUrls
    correctTrackingBranches
    
    git stash pop
}

function changeProjectNameInFilesAndDirectories() {
    pushd "$PROJECT_LOWER_CASE"

    renameGitRemoteOriginToTemplate
    renameFilesAndContentsToProjectName

    fixUpstreamUrlAndCreateNewMasterBranch

    commitChangesToNewGitRepository

    popd
}

validateScriptArguments
buildRuntimeEnvironment
validateRuntimeEnvironment

echo "Creating project $PROJECT_CAMEL_CASE in directory $PROJECT_LOWER_CASE using $REMOTE_URL"

cloneToNewProject
changeProjectNameInFilesAndDirectories

echo "Happy coding!"
