# applying multiple tags to images to ensure they are tagged as latest and also to establish the unique version number
docker build -t stan56/multi-client:latest -t stan56/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t stan56/multi-server:latest -t stan56/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t stan56/multi-worker:latest -t stan56/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push stan56/multi-client:latest
docker push stan56/multi-server:latest
docker push stan56/multi-worker:latest
docker push stan56/multi-client:$GIT_SHA
docker push stan56/multi-server:$GIT_SHA
docker push stan56/multi-worker:$GIT_SHA

kubectl apply -f k8s
# specify the image version the deployment should use 
# this way when the image is updated it will automaticlaly be deployed
kubectl set image deployments/client-deploy client=stan56/multi-client:$GIT_SHA
kubectl set image deployments/server-deploy server=stan56/multi-server:$GIT_SHA
kubectl set image deployments/worker-deploy worker=stan56/multi-worker:$GIT_SHA