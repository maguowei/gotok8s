workflow "k8s image sync" {
  resolves = ["sync"]
  on = "schedule(0 */6 * * *)"
}

action "docker login" {
  uses = "actions/docker/login@master"
  secrets = [
    "DOCKER_USERNAME",
    "DOCKER_PASSWORD",
  ]
}

action "sync" {
  uses = "maguowei/actions/k8s-image-sync@master"
  env = {
    REGISTRY = "gotok8s"
  }
  needs = ["docker login"]
}
