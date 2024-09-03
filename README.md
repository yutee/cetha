## instructions on how to run and test your setup locally

- explain the project... goals, deliverables
- include architecture diagram, network architecture (security) and project folder (explain folder)
- explain steps taken (approach) and tools used
- explain the api
- explain the terraform configuration
- explain ci/cd
- explain steps to run the project locally.

-include-
Terraform excels at setting up and managing the infrastructure that Kubernetes runs on, especially with services such as AWS EKS. 
Kubernetes provides the orchestration and management layer for your containerized applications, ensuring they run as intended. 
Helm handles the application deployment on kubernetes, with helm it easy to package, deploy, update and manage applications in Kubernetes.

Terraform can deploy applications directly into Kubernetes clusters using its Helm provider, so technically speaking, you can manage both your infrastructure and applications through Terraform scripts. 
For the purpose of this task, this is a core requirement.
-include-

using helm as oposed to using in line kubernetes and using kubectl to apply on my cluster.