package main

import (
	"github.com/hashicorp/terraform/plugin"
	"github.com/jgensler8/terraform-provider-minikube/minikube"
)

func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: minikube.Provider})
}
