variable subnet_cidr { default = " 192.168.10.0/24" }
variable public_key { default = "/home/matt/.ssh/id_rsa.pub" }
variable ssh_user { default = "cloud" }

variable name { default = "mantl-metapod" }        # resources will start with "mantl-metapod"
variable control_count { default = "1"}    # mesos masters, zk leaders, consul servers
variable worker_count { default = "1"}     # worker nodes
variable kubeworker_count { default = "1"} # kubeworker nodes
variable edge_count { default = "1"}       # load balancer nodes

# Run 'nova network-list' to get these names and values
# Floating ips are optional
variable external_network_uuid { default = "af0404a5-caff-4204-9205-0be5dab6c4f3" }
variable floating_ip_pool { default = "Trial 10 Public Network" }

# Run 'nova image-list' to get your image name
variable image_name  { default = "CentOS-7-x86_64-GenericCloud-1508-mc" }

# DNS servers passed to Openstack subnet
variable dns_nameservers { default = "209.244.0.3,209.244.0.4" } # comma separated list of ips, e.g. "8.8.8.8,8.8.4.4"

#  Openstack flavors control the size of the instance, i.e. m1.xlarge.
#  Run 'nova flavor-list' to list the flavors in your environment
#  Below are typical settings for mantl
variable control_flavor_name { default = "m1.xlarge" }
variable worker_flavor_name { default = "m1.large" }
variable kubeworker_flavor_name { default = "m1.large" }
variable edge_flavor_name { default = "m1.small" }

# Size of the volumes
variable control_volume_size { default = "50" }
variable worker_volume_size { default = "100" }
variable edge_volume_size { default = "20" }

module "ssh-key" {
  source = "./terraform/openstack/keypair_v2"
  public_key = "${var.public_key}"
  keypair_name = "mantl-key"
}

#Create a network with an externally attached router
module "network" {
  source = "./terraform/openstack/network"
  external_net_uuid = "${var.external_network_uuid}"
  subnet_cidr = "${var.subnet_cidr}"
  name = "${var.name}"
  dns_nameservers = "${var.dns_nameservers}"
}

# Create floating IPs for each of the roles
# These are not required if your network is exposed to the internet
# or you don't want floating ips for the instances.
module "floating-ips-control" {
  source = "./terraform/openstack/floating-ip"
  count = "${var.control_count}"
  floating_pool = "${var.floating_ip_pool}"
}

module "floating-ips-worker" {
  source = "./terraform/openstack/floating-ip"
  count = "${var.worker_count}"
  floating_pool = "${var.floating_ip_pool}"
}

module "floating-ips-kubeworker" {
  source = "./terraform/openstack/floating-ip"
  count = "${var.kubeworker_count}"
  floating_pool = "${var.floating_ip_pool}"
}

module "floating-ips-edge" {
  source = "./terraform/openstack/floating-ip"
  count = "${var.edge_count}"
  floating_pool = "${var.floating_ip_pool}"
}

# Create instances for each of the roles
module "instances-control" {
  source = "./terraform/openstack/instance"
  name = "${var.name}"
  count = "${var.control_count}"
  role = "control"
  volume_size = "${var.control_volume_size}"
  network_uuid = "${module.network.network_uuid}"
  floating_ips = "${module.floating-ips-control.ip_list}"
  keypair_name = "${module.ssh-key.keypair_name}"
  flavor_name = "${var.control_flavor_name}"
  image_name = "${var.image_name}"
  ssh_user = "${var.ssh_user}"
}

module "instances-worker" {
  source = "./terraform/openstack/instance"
  name = "${var.name}"
  count = "${var.worker_count}"
  volume_size = "${var.worker_volume_size}"
  count_format = "%03d"
  role = "worker"
  network_uuid = "${module.network.network_uuid}"
  floating_ips = "${module.floating-ips-worker.ip_list}"
  keypair_name = "${module.ssh-key.keypair_name}"
  flavor_name = "${var.worker_flavor_name}"
  image_name = "${var.image_name}"
  ssh_user = "${var.ssh_user}"
}

module "instances-kubeworker" {
  source = "./terraform/openstack/instance"
  name = "${var.name}"
  count = "${var.kubeworker_count}"
  volume_size = "100"
  count_format = "%03d"
  role = "kubeworker"
  network_uuid = "${module.network.network_uuid}"
  floating_ips = "${module.floating-ips-kubeworker.ip_list}"
  keypair_name = "${module.ssh-key.keypair_name}"
  flavor_name = "${var.kubeworker_flavor_name}"
  image_name = "${var.image_name}"
  ssh_user = "${var.ssh_user}"
}

module "instances-edge" {
  source = "./terraform/openstack/instance"
  name = "${var.name}"
  count = "${var.edge_count}"
  volume_size = "${var.edge_volume_size}"
  count_format = "%02d"
  role = "edge"
  network_uuid = "${module.network.network_uuid}"
  floating_ips = "${module.floating-ips-edge.ip_list}"
  keypair_name = "${module.ssh-key.keypair_name}"
  flavor_name = "${var.edge_flavor_name}"
  image_name = "${var.image_name}"
  ssh_user = "${var.ssh_user}"
}

module "dns" {
  # Change this!
  domain = "mrsmiggins.net"
  subdomain = ".metapod"

  source = "./terraform/cloudflare"
  control_count = "${var.control_count}"
  control_ips = "${module.floating-ips-control.ip_list}"
  edge_count = "${var.edge_count}"
  edge_ips = "${module.floating-ips-edge.ip_list}"
  short_name = "${var.name}"
  worker_count = "${var.worker_count}"
  worker_ips = "${module.floating-ips-worker.ip_list}"
  kubeworker_count = "${var.kubeworker_count}"
  kubeworker_ips = "${module.floating-ips-kubeworker.ip_list}"
}

provider "cloudflare" {
  email = "YOUR-EMAIL"
  token = "YOUR-TOKEN"
}
