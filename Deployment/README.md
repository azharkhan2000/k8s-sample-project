# sherdil-k8s-sample
This is sample project for k8s for practice for students or New Fellows in DevOps.

aws eks create-access-entry --cluster-name Azhar-EKS --principal-arn arn:aws:iam::678878256416:user/K.Electric-User --type STANDARD --username K.Electric-User

Purpose of This Project:
To Deploy 2 different applications on Kubernetes with different SSL practice.
Lets Encrypt or AWS ACM along with AWS Load Balancer.

-------------------------------------------------------------

This Repo include 3 different folders along with several files.

helm folder is use for nlb creation via Helm.

Nignx-Ingress is use for NLB creation via Kubectl but it is using AWS ACM For SSL with RBAC policy.

Kube-promethues is use for Promethues & Grafana helm config.

Certmanager & letsencrypt use for certbot free ssl creation but u need to make some changes on file as well.

other files include cluster autoscale, HPA & 2 Different Sample Projects.

Change AWS ACM ARN & Load balancer type in 1.yml at Nginx-ingress folder.
-----------------------------------------------------------------------------------------------------------

Infra Steps:
1) Create AWS EKS Cluster and Worker Node and check either it is created or not via cli or kubectl.
2) Configure AWS in your CLI or Powershell.
3) Bind with your cluster via this command "aws eks --region <Your Region> update-kubeconfig --name <Your Cluster Name>"
4) Then Run "kubectl get svc" or "kubectl get nodes" to check either you are connected to correct cluster or not.
5) Now you are connected to cluster.

-------------------------------------------------------------------------------
Deployment Steps with Letsencrypt SSL:
1) First Configure Load Balancer. GO to helm folder and run this command 
   "helm install ingress-nginx ingress-nginx/ingress-nginx -f .\ingress-nginx-values.yaml".
2) Then go to route53 and bind domain according to the domain name in the file against NLB DNS & wait until it will get available.
3) Then run this command "kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml"
4) Then come back to root folder and run this "kubectl apply -f .\letsencrypt.yaml".
5) Command 2 & 3 will run letsencrypt for SSL.Dont forget to change email in letsencrypt folder.
6) Now Apply nodejs & sample image file with letsencrypt via this command
   "kubectl apply -f .\nodejs-with-letsencrypt.yaml -f .\sample-image-with-letsencrypt.yaml"
7) This will done deployment with letsencrypt SSL along with NLB.

--------------------------------------------------------------------------------
Deployment Step with AWS ACM SSL:
1) First Delete old NLB via this command "helm uninstall ingress-nginx ingress-nginx/ingress-nginx"
2) Then Deploy new NLB with AWS ACM SSL via this command "kubectl apply -f Nginx-ingress"
3) Now again go to route53 and bind domain according to the domain name in the file against New NLB DNS.
4) Then Deploy this "kubectl apply -f ingress-nginx.yaml" so that NLB Address can bind with ingress
5) If scalability issue occurs then deploy autoscale file via this "kubectl apply -f .\cluster-autosclae.yml"
6) Now Deploy files sample-image & nodejs via this "kubectl apply -f .\nodejs.yaml -f .\sample-image.yaml"
7) If address is missing in ingress which you can check via "kubectl get ingress" then redeploy 2 & 3 file in Nginx-ingress folder.     It will create RBAC for NLB.


-------------------------------------------------------------------------
Some extra commands if u stuck in deploying old NLB again
kubectl delete clusterrole ingress-nginx
kubectl delete clusterrolebinding ingress-nginx
kubectl delete ingressclass nginx

------------------------------------------------------------------------------
Deletion Process:
1) First delete New NLB via this command "kubectl delete svc ingress-nginx-controller -n ingress-nginx"
2) Then delete deployment via "kubectl delete deployment ingress-nginx-controller -n ingress-nginx"
3) Then delete ingress of both apps via "kubectl delete ingress test-ingress test-ingress-v1"
4) Thend delete svc via "kubectl delete svc hello-k8s-app-service node-todo-app-svc"
5) Then delete deployment via "kubectl delete deployment node-todo-app hello-k8s-app"
-------------------------------------------------------------------------------------
FOR Prometheus & Grafana:
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo update

helm install prometheus prometheus-community/kube-prometheus-stack

-----------------------------------------------------------------------------------------
ALL DONE
=======
