# UAA k8s release

Exploring what this might look like.

## Random things I learned yesterday while hacking around

### Getting startetd with minikube

https://medium.com/@yzhong.cs/developing-microservices-with-minikube-81b31e5366ac
eval $(minikube docker-env)

https://github.com/kubernetes/minikube/issues/1568
minikube ssh
sudo ip link set docker0 promisc on

### Building the image

pack build --builder cloudfoundry/cnb:cflinuxfs3 uaa

We'll definitely have to fork the tomcat buildpack and we modify
server.xml

Also we can use init containers and take a cue from openshift for cert
management:

https://developers.redhat.com/blog/2017/11/22/dynamically-creating-java-keystores-openshift/
https://kubernetes.io/docs/concepts/workloads/pods/init-containers/

### Chart stuff
helm template --values values.yaml --output-dir ./manifests .

### Have k8s run it
kubectl apply --recursive --filename ./manifests/uaa-k8srelease/

### Testing stuff
can I hit my service from within the cluster?
kubectl exec -it <pod id> curl <cluster ip>:<service port>
