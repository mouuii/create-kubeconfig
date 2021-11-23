# your server name goes here
server=https://cls-dtj9193z.ccs.tencent-cloud.com
# the name of the secret containing the service account token goes here
name=nga-test1-token-wr628

ca=$(kubectl get secret/$name -n nga -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret/$name -n nga -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret/$name -n nga -o jsonpath='{.data.namespace}' | base64 --decode)

echo "
apiVersion: v1
kind: Config
clusters:
- name: default-cluster
  cluster:
    certificate-authority-data: ${ca}
    server: ${server}
contexts:
- name: default-context
  context:
    cluster: default-cluster
    namespace: default
    user: default-user
current-context: default-context
users:
- name: default-user
  user:
    token: ${token}
" > sa.kubeconfig