provider "vsphere" {
  user           = "administrator@vsphere.local"
  password       = "Pa$$$$w0rd"
  vsphere_server = "192.168.3.39"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
}

output "dcname"{
value = "${data.vsphere_datacenter.dc.id}"

}
