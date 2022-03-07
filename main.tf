# Configure the VMware vSphere Provider
provider "vsphere" {
  user           = "administrator@vsphere.local"
  password       = "XXX"
  vsphere_server = "192.168.20.251"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}

# Deploy 2 linux VMs
module "centos-server-linuxvm" {
  source    = "Terraform-VMWare-Modules/vm/vsphere"
  version   = "3.4.1"
  vmtemp    = "CentOS8"
  instances = 2
  vmname    = "centos-server-linux"
  vmrp      = "Felix-Cluster/Resources/terraform"
  network = {
    "VM Network" = ["192.168.22.68", "192.168.22.69"] # To use DHCP create Empty list ["",""]; You can also use a CIDR annotation;
  }
  vmgateway = "192.168.0.250"
  dc        = "Felix-DC"
  datastore = "Data"
  ipv4submask  = ["16", "16"]
  network_type = ["vmxnet3", "vmxnet3"]
  dns_server_list  = ["192.168.22.1", "192.168.22.1"]
  is_windows_image = false
}

output "vmnames" {
  value = module.centos-server-linuxvm.VM
}

output "vmnameswip" {
  value = module.centos-server-linuxvm.ip
}