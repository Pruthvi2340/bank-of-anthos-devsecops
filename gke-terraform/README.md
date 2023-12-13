# Kubernetes Engine Example

## Install Terraform

1. Install Terraform if it is not already installed (visit [terraform.io](https://terraform.io) for other distributions):

```
../terraform-install.sh
```

## Set up the environment

1. Set the project, replace `YOUR_PROJECT` with your project ID:

```
PROJECT=YOUR_PROJECT
```

```
gcloud config set project ${PROJECT}
```

2. Configure the environment for Terraform:

```
[[ $CLOUD_SHELL ]] || gcloud auth application-default login
export GOOGLE_PROJECT=$(gcloud config get-value project)
```

## Run Terraform

```
terraform init
terraform apply
```

## Testing

1. Wait for the load balancer to be provisioned:

```
./test.sh
```

2. Verify response from load balancer:

```
curl http://$(terraform output load-balancer-ip)
```

## Connecting with kubectl

1. Get the cluster credentials and configure kubectl:

```
gcloud container clusters get-credentials $(terraform output cluster_name) --zone $(terraform output cluster_zone)
```

2. Verify kubectl connectivity:

```
kubectl get pods -n staging
```

# Argocd install usign helm
** Check if terraform script fails or stuck in any state**
```
helm status argocd -n argocd   # if it takes longer to install from terraform
helm list --pending -A           # check failed helm repo list
```

**To get intial password for argocd to login**
```
kubectl get secrets -n argocd
kubectl get secrets argocd-intial-admin-secret -o yaml -n argocd

kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath='{.data.password}' | base64 --decode  # To get intial password
```

# Change Argocd server service from cluster IP to Loadbalancer IP

```
kubectl edit svc argocd-server -n argocd
```
```
change type:ClusterIp to LoadBalancer
```

## Cleanup

1. Delete resources created by terraform:

```
terraform destroy
```
