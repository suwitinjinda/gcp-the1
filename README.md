# gcp-the1
# the1
gcloud auth login
gcloud auth application-default login



# adding service project to host porject. service project need to enable compute service and IAM network user role
gcloud services enable compute.googleapis.com --project=service-project-id
gcloud projects add-iam-policy-binding service-project-id --member="user:terraform-user" --role="roles/compute.networkUser"

