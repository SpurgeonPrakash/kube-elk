#!/bin/bash
kubectl apply -f mongo.yml
kubectl apply -f spring-boot-simple.yml
kubectl apply -f monitoring.namespace.yml

kubectl apply  -f elk/elasticsearch-master.configmap.yaml \
                 -f elk/elasticsearch-master.service.yaml \
                 -f elk/elasticsearch-master.deployment.yaml

kubectl apply -f elk/elasticsearch-data.configmap.yaml \
                -f elk/elasticsearch-data.service.yaml \
                -f elk/elasticsearch-data.replicaset.yaml

kubectl apply  -f elk/elasticsearch-client.configmap.yaml \
                 -f elk/elasticsearch-client.service.yaml \
                 -f elk/elasticsearch-client.deployment.yaml

# kubectl exec $(kubectl get pods -n monitoring | grep elasticsearch-client | sed -n 1p | awk '{print $1}') \
#     -n monitoring \
#     -- bin/elasticsearch-setup-passwords auto -b

# kubectl create secret generic elasticsearch-pw-elastic \
#     -n monitoring \
#     --from-literal password=3JW4tPdspoUHzQsfQyAI

kubectl apply  -f elk/kibana.configmap.yaml \
                 -f elk/kibana.service.yaml \
                 -f elk/kibana.deployment.yaml

kubectl apply -f https://raw.githubusercontent.com/gjeanmart/kauri-content/master/spring-boot-simple/k8s/kube-state-metrics.yml

kubectl apply  -f elk/metricbeat.settings.configmap.yml \
                 -f elk/metricbeat.indice-lifecycle.configmap.yml \
                 -f elk/metricbeat.daemonset.yml \
                 -f elk/metricbeat.permissions.yml

kubectl apply  -f elk/filebeat.settings.configmap.yml \
                 -f elk/filebeat.indice-lifecycle.configmap.yml \
                 -f elk/filebeat.daemonset.yml \
                 -f elk/filebeat.permissions.yml

kubectl apply  -f elk/apm.deployment.yml \
                 -f elk/apm.service.yml \
                 -f elk/apm.deployment.yml