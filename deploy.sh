docker build -t g1git/multi-client:latest -t g1git/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t g1git/multi-worker:latest -t g1git/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
docker build -t g1git/multi-server:latest -t g1git/multi-server:$SHA  -f ./server/Dockerfile ./server

docker push g1git/multi-client:latest
docker push g1git/multi-worker:latest
docker push g1git/multi-server:latest

docker push g1git/multi-client:$SHA
docker push g1git/multi-worker:$SHA
docker push g1git/multi-server:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=g1git/multi-server:$SHA
kubectl set image deployments/client-deployment client=g1git/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=g1git/multi-worker:$SHA