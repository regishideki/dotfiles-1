!#sbin/sh

clone_from_projects() {
  workspace=$1
  shift
  github_user=$1
  shift
  projects=($@)

  cd $workspace

  echo "workspace: $workspace"
  echo "projects: $projects"
  echo "github_user: $github_user"

  for project in "${projects[@]}"
  do
    if [ -d "$workspace/$project" ]; then
      echo "Project $project already exists."
    else
      echo "cloning project $project."
      git clone "git@github.com:$github_user/$project.git"
    fi
  done
}

workspace=~/workspace
personal_workspace="$workspace/regis"
bankfacil_workspace="$workspace/bankfacil"

mkdir -p $personal_workspace
mkdir -p $bankfacil_workspace

config_projects=(dotfiles prelude)
personal_projects=(programming-challenges presentations project_euler programming-languages)
bankfacil_projects=(core provisioning front middle-office ember-cli-bkf-core provisioning-dev qa-functional-specs docker-dev)

personal_github="regishideki"
bankfacil_github="BankFacil"

clone_from_projects $personal_workspace $personal_github $personal_projects
clone_from_projects $bankfacil_workspace $bankfacil_github $bankfacil_projects
clone_from_projects ~/ $personal_github $config_projects

ln ~/dotfiles/core/projections.json $bankfacil_workspace/core/.projections.json

cd ~/dotfiles/
