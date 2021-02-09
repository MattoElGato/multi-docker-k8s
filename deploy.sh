docker build -t mattoelgato/multi-client:latest -t mattoelgato/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mattoelgato/multi-server:latest -t mattoelgato/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mattoelgato/multi-worker:latest -t mattoelgato/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mattoelgato/multi-client:latest
docker push mattoelgato/multi-server:latest
docker push mattoelgato/multi-worker:latest

docker push mattoelgato/multi-client:$SHA
docker push mattoelgato/multi-server:$SHA
docker push mattoelgato/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=mattoelgato/multi-server:$SHA
kubectl set image deployments/client-deployment client=mattoelgato/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mattoelgato/multi-worker:$SHA
