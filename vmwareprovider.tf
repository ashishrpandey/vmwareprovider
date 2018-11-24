provider "vsphere" {
  user           = "administrator"
  password       = "Pa$$w0rd"
  vsphere_server = "192.168.3.39"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "dc1"
}
