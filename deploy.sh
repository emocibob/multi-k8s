docker build -t emocibob/multi-client:latest -t emocibob/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t emocibob/multi-server:latest -t emocibob/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t emocibob/multi-worker:latest -t emocibob/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push emocibob/multi-client:latest
docker push emocibob/multi-server:latest
docker push emocibob/multi-worker:latest

docker push emocibob/multi-client:$SHA
docker push emocibob/multi-server:$SHA
docker push emocibob/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=emocibob/multi-server:$SHA
kubectl set image deployments/client-deployment client=emocibob/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=emocibob/multi-worker:$SHA
