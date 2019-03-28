docker build -t kadishay/multi-client:latest -t kadishay/multi-client:$SHA -f ./client/DockerFile ./client
docker build -t kadishay/multi-server:latest -t kadishay/multi-server:$SHA -f ./server/DockerFile ./server
docker build -t kadishay/multi-worker:latest -t kadishay/multi-worker:$SHA -f ./worker/DockerFile ./worker

docker push kadishay/multi-client:latest
docker push kadishay/multi-server:latest
docker push kadishay/multi-worker:latest

docker push kadishay/multi-client:$SHA
docker push kadishay/multi-server:$SHA
docker push kadishay/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kadishay/multi-server:$SHA
kubectl set image deployments/client-deployment client=kadishay/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kadishay/multi-worker:$SHA