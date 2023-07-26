#!/bin/bash

K3D_CLUSTER_NAME="${1:-elk}"
cluster_file=".created_cluster"

check_package() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "\033[31mERROR:\033[0m $1 is not installed. Please install it before continuing."
        exit 1
    fi
}

cleanup_cluster() {
    if [[ -f "$cluster_file" ]]; then
        cluster_name=$(cat "$cluster_file")
        echo -e "\033[32mDeleting Cluster $cluster_name... \033[0m\n"
        if k3d cluster delete "$cluster_name"; then
            echo -e "\033[32mCluster $cluster_name deleted successfully.\033[0m\n"
            rm "$cluster_file"
            exit 0
        else
            echo -e "\033[31mError deleting cluster $cluster_name.\033[0m\n"
            exit 1
        fi
    else
        echo -e "\033[31mNo cluster found for cleanup.\033[0m\n"
        exit 1
    fi
}

if [[ $1 == "cleanup" ]]; then
  cleanup_cluster "$1"
else 
#    printf "\033c"
   echo "$K3D_CLUSTER_NAME" > "$cluster_file"
   echo -e "\033[32mUsage: ./deploy.sh <clustername>\n"
   echo -e "Current values clustername=$K3D_CLUSTER_NAME;\n"
   
   echo -e "\033[32mTo Clean-up run ./deploy.sh cleanup\n"
   
   echo -e "\033[32mChecking Prereqs...\033[0m\n"
   
   check_package "docker"
   check_package "k3d"
   check_package "kubectl"
   
   echo -e "\033[32mAll required packages are installed.\033[0m\n"
   
   if [[ $(k3d cluster list | grep $K3D_CLUSTER_NAME ) != *$K3D_CLUSTER_NAME* ]] ;
   then
       echo
       echo -e "\033[32mCreating Cluster with the name $K3D_CLUSTER_NAME... \033[0m\n"
       for i in K3D_CLUSTER_NAME; do export "$i=${!i}"; done
       k3d cluster create $K3D_CLUSTER_NAME -s 1 -a 3 -p 443:443@loadbalancer -p 80:80@loadbalancer --k3s-arg  "--disable=traefik@server:0"
       sleep 10
       kubectl wait --for=condition=Ready pods --all -A > /dev/null
       echo -e "\033[32m$K3D_CLUSTER_NAME cluster is ready... \033[0m\n"
   
   else
       echo
       echo -e "\033[31mCluster already exists, delete it with kind delete clusters $1 and try recreating again...\n"
   fi
fi