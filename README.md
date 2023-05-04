DevOps Asssessment for Eurofins
In order to replicate the results, you'll need the AWS_ACCESS_KEY_ID and the AWS_SECRET_ACCESS_KEY

The application.
I used VSCode to create the application. In order to create it, I followed the steps from the official Microsoft page
https://learn.microsoft.com/en-us/dotnet/core/tutorials/with-visual-studio-code?pivots=dotnet-7-0
For the version control system I decided to use GitHub. As it is best practice, I created .gitignore file for the .Net application.
The CI pipeline was made using GitHub Actions. The workflow can be found under ./github/workflows named build_on_commit.yml. It triggers when a commit is made to the main branch in the repository and rebuilds the package and creates releases.

The custom image
The prerequisite layer creates an AMI based on Windows_Server-2012 and installs all the necessary components to run the .Net application. It is called prerequisites.pkr.hcl and it is located in the root directory
The application layer uses the AMI created by the prerequisites layer and it installs the application on top of it. Unfortunately I didn't manage to get it built and for demonstration purposes, I will be using the image created by the prerequisites layer.

The virtual machine
The virtual machine was provisioned using Terraform. It is deployed in the eu-central-1 region and it uses variables for the main components. In the variables.tf file contain the variables, namely: the number of VMs that should be created, the VM flavor and the image used for creating the VM. In our case, I am using the image built by the packer in the prerequisites stage.
In order to push the terraform files to the repository, I had to update the .gitignore file.