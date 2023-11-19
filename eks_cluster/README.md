- aws eks --region ap-south-1 describe-cluster --name (cluster-name) --query cluster.status
- aws eks --region ap-south-1 update-kubeconfig --name (cluster-name)

# Error
E0707 10:53:48.769751    1822 memcache.go:265] couldn't get current server API group list: the server has asked for the client to provide credentials

- This error was occured because of while provisioning terraform eks cluster using profile siva credentials but in querying using 
  kubectl that was installed in instance and attached different credentils this problem occured when ever querying using kubectl

# Resolution 
- Using same credentials