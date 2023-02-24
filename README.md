
# ECS & ECS Deployment with Terraform

Deployed Backend URL to ECS
backend-alb-1161922540.us-east-1.elb.amazonaws.com

Deployed Frontend URL to ECS
181298345900.dkr.ecr.us-east-1.amazonaws.com/frontend-repo


BLOCKER IN THIS PRODUCTION


"First of all there are CORS allowed in the backend and when frontend try top hit the backend it fails due to CORS error because it hit on secure connection panel and HTTP isnt secure and we dont have a domain for redirection ,if we redirect the domain over HTTPS that issue would be resolved automatially in a blink of eye"

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
Create .github folder and in that folder create workflows file and then write config.yml file in it

_______________________________________________________________________
In file just add their names

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

## Yay!

"JUST PUSH TO MAIN BRANCH AND IT WILL DEPLOYED AUTOMATICALLY AND DEPLOYED TO ECS WITH GITHUB ACTIONS"
