
# ECS & ECS Dployment with Terraform



## Step 1 
Create Alb with terraform


Create Target group with terraform

Create Security-group

Create Ecr Repo with  terraform

Create Variable.tf to modify your infra

Create Cluster with terraform

Create Task-Defination with terraform and attach it to Cluster

Create Ecs Service with terraform and add variable constant you want to add at runtime



## Step 2
Create .github folder and in that folder create workflows file and then wriet config.yml file in it

_______________________________________________________________________
In file just add thier names

1.Ecr Repo

2.Ecs-Service

3.Ecs Cluster 

4.Ecs Container

## Step 3
Add these secrets to Github Actions Secrets

1.AWS REGION

2.AWS ACCESS KEY

3.AWS SECRET ACCESS KEY

4.AWS ECR REPO

## Horrah we have done it

"JUST PUSH TO MAIN BRANCH AND IT WILL DEPLOYED AUTOMATICALLY AND DEPLOYED TO ECS WITH GITHUB ACTIONS"
