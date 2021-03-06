package ocp.bestpractices.pod_hostnetwork

import data.lib.konstraint
import data.lib.openshift

# violation: Check workload kinds has 'spec.hostNetwork' set
# @Kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  pod := openshift.pods[_]
  pod.spec.hostNetwork
  obj := konstraint.object

  msg := konstraint.format(sprintf("%s/%s: hostNetwork is present which gives the pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other pods on the same node.", [obj.kind, obj.metadata.name]))
}