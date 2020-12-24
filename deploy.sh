docker build -t g1hubdoc/multi-client:latest -t g1hubdoc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t g1hubdoc/multi-worker:latest -t g1hubdoc/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
docker build -t g1hubdoc/multi-server:latest -t g1hubdoc/multi-server:$SHA  -f ./server/Dockerfile ./server

docker push g1hubdoc/multi-client:latest
docker push g1hubdoc/multi-worker:latest
docker push g1hubdoc/multi-server:latest

docker push g1hubdoc/multi-client:$SHA
docker push g1hubdoc/multi-worker:$SHA
docker push g1hubdoc/multi-server:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=g1hubdoc/multi-server:$SHA
kubectl set image deployments/client-deployment client=g1hubdoc/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=g1hubdoc/multi-worker:$SHA