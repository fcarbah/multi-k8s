#build docker image
docker build -t fcarbah/multi-client:latest -t fcarbah/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fcarbah/multi-server:latest -t fcarbah/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fcarbah/multi-worker:latest -t fcarbah/multi-worker:$SHA -f ./worker/Dockerfile ./worker

#push images to docker hub
docker push fcarbah/multi-client:latest
docker push fcarbah/multi-client:$SHA
docker push fcarbah/multi-server:latest
docker push fcarbah/multi-server:$SHA
docker push fcarbah/multi-worker:latest
docker push fcarbah/multi-worker:$SHA

#apply kubernetes config
kubectl apply -f k8s

#set latest image on each kubernetes deployment
kubectl set image deployment/server-deployment server=fcarbah/multi-server:$SHA
kubectl set image deployment/client-deployment client=fcarbah/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=fcarbah/multi-worker:$SHA
