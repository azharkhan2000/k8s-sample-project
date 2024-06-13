Integrating AWS Secrets Manager with Kuberenetes

1st Step:
Create Secrets Manager either via Console or CLI:
aws --region "us-east-1" secretsmanager \
  create-secret --name azhar-secret \
  --secret-string '{"username":"Azhar", "password":"Khan2000"}'

2nd Step:
Install Secrets Store CSI Driver:

helm repo add secrets-store-csi-driver \
  https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts

helm install -n kube-system csi-secrets-store \
  --set syncSecret.enabled=true \
  --set enableSecretRotation=true \
  secrets-store-csi-driver/secrets-store-csi-driver

3rd Step:
Install AWS Provider For AWS Secrets Manager
kubectl apply -f https://raw.githubusercontent.com/aws/secrets-store-csi-driver-provider-aws/main/deployment/aws-provider-installer.yaml


4th Step:
Verify the installation:
kubectl get daemonsets -n kube-system -l app=csi-secrets-store-provider-aws
kubectl get daemonsets -n kube-system -l app.kubernetes.io/instance=csi-secrets-store

5th Step:
Check CRDS
Check CRDS that you recently Installed
kubectl get crd -n kube-system

you will find these two along with other crd
secretproviderclasses.secrets-store.csi.x-k8s.io
secretproviderclasspodstatuses.secrets-store.csi.x-k8s.io

6th Step:
Create an IAM policy
you can create either via console or CLI:

IAM_POLICY_ARN_SECRET=$(aws --region "us-east-1" iam \
	create-policy --query Policy.Arn \
    --output text --policy-name aws-secret-manager-k8 \
    --policy-document '{
    "Version": "2012-10-17",
    "Statement": [ {
        "Effect": "Allow",
        "Action": ["secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret"],
        "Resource": ["'"arn:aws:secretsmanager:us-east-1:678878256416:secret:azhar-secret-IkQlYi"'" ]
    } ]
}')

7th Step:
Create IAM Service Account

eksctl utils associate-iam-oidc-provider \
    --region="us-east-1" --cluster="Azhar-EKS" \
    --approve

eksctl create iamserviceaccount \
    --region="us-east-1" --name "azhar-secrets-sa"  \
    --cluster "Azhar-EKS" \
    --attach-policy-arn "arn:aws:iam::678878256416:policy/aws-secret-manager-k8" --approve \
    --override-existing-serviceaccounts

8th Step:
Check Service Account (S.A)
kubectl get sa

9th Step:
Create Secretprovider.yaml file and apply it
kubectl apply -f secretsmanager/secretprovider.yaml 
kubectl get secretproviderclass

10th Step:
Check secrets
Deploy Sample app and go inside that pod and call secrets from that pod.
kubectl apply -f .\secretsmanager\api-deploy.yaml

kubectl get pod

kubectl exec -it <pod-name> -- sh

cd /mnt/secrets/

cat azhar-secret

11th Step:
AutoUpdate or Rotation of Secrets
So whenever we update our secrets in secret manager it should be update inside pod automatically.
So basically We need to update the helm chart values.I already did it and make a file named as values.yaml.

helm upgrade csi-secrets-store secrets-store-csi-driver/secrets-store-csi-driver --values .\secretsmanager\values.yaml -n kube-system

