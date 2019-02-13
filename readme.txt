#starting minikube
minikube start --vm-driver="hyperv" --hyperv-virtual-scitch="Primary Virtual Switch"

# nodePort btw 30000-32767. not used in production
#port is for other pods in kube cluster to connect to other pod
#target port is port on pod you want to expose

#loading into kube cluster
kubectl apply -f filename

#get status of objects created - ex. pods for object of type pods
#for services change pods to services
kubectl get pods

kubectl get service client-node-port --output='jsonpath="{.spec.ports[0].nodePort}"'


#get detail info about an object
                 {object} {object name}
kubectl describe pod client-pod

#delete or remove existing object
				  {config file name}
kubectl delete -f client.pod.yaml
or 				pod   client-pod
kubectl delete {type} {object name}

#manually updating image of a pod [Imperative command]
kubectl set image {object type}/{object name} {container name}={new image name- full image name}

#configure docker-cli client on host to point to docker server on virtual pc
eval $(minikube docker-env)


#clusterip service does not equire and need nodePort

#applying multiple config files to kubectl
kubectl apply -f {directory name containing config files}

#putting mutiple config in one kube config file
#seperate config with 3 dashes ---


#kubernetes volume not the same as docker volume. Volume cannot persist data outside a pod in kubernetes
#we want to use is a persistent volume for data to persist outside the pod.
#persistent volume claim vs persisten volume
#Access Modes - 3types
1.	ReadWriteOnce	Can be used by a single node
2. 	ReadOnlyMany	Multiple nodes can read from this
3.	ReadWriteMany	Can be read and wrriten to by many nodes

#Secrets - another kubernetes object type
securely stores a piece of information in the cluster
cannot used a config file (defeats the purpose of securing info) but rather we will issue an imperative command (manulally create).
					   type of secret
kubectl create secrete {generic} <secret_name> --from-literal key=value

#other types of secrete: docker-registry and tls


#ingress controller
**Recommended ingress-nginx 	https://github.com/kubernetes/ingress-nginx
Setup of ingress-nginx changes depending on environment (local,GC,AWS,Azure)
#madatory command
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/mandatory.yaml
then
#for minikube  standard usage
minikube addons enable ingress

#install travis cli in ruby
docker image - ruby:2.3
#command
gem install travis

#login to travis using github username and password
travis login

#encrypt file usingtravis cli
								  {repository name}
travis encrypt-file {filename} -r fcarbah/multi-k8s

#** delete original file (service-account-json)

#diable prompts from google cloud sdk. add this environment variable to travis yaml
 CLOUDSDK_CORE_DISABLE_PROMPTS=1

 #intasll helm and tiller server
 #create service account for tiller
 #all of these commands should be run on google cloud shel
 													   {service account name}
 kubectl create serviceaccount --namespace kube-system tiller

 #assign cluster role binding
 kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

 #then run
 							 {service account name}
 helm init --service-account tiller --upgrade

 https://kubernetes.github.io/ingress-nginx/deploy/#using-helm
 https://docs.helm.sh/using_helm/#quickstart-guide

 #travis config file should always be named .travis.yml

 #https setup on kubernetes
 #cert manager
 https://github.com/jetstack/cert-manager

 #install cert manager
 helm install --name cert-manager --namespace kube-system --version v0.4.1 stable/cert-manager

 #if error certificates.certmanager.k8s.io already exists then run
 helm del --purge cert-manager

 #create 2 objects
 1. Issuer - contacts certificate authority  to get certificate
 2. Certificate - object describing details about the certificate that should be obtained. Also defines a kube secret

 helm install \
  --name cert-manager \
  --namespace kube-system \
  --version v0.6.1 \
  stable/cert-manager



