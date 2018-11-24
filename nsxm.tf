#
# The first step is to configure the VMware NSX provider to connect to the NSX
# REST API running on the NSX manager.
#

provider "nsxt" {
  host                     = "192.168.3.224"
  username                 = "admin"
  password                 = "Pa$$w0rd"
  allow_unverified_ssl     = true
  max_retries              = 3
  retry_min_delay          = 500
  retry_max_delay          = 5000
  retry_on_status_codes    = [429]
}


#
# Here we show that you define a NSX tag which can be used later to easily to
# search for the created objects in NSX.
#
variable "nsx_tag_scope" {
  default = "project"
}

variable "nsx_tag" {
  default = "terraform-demo"
}

#
# This part of the example shows some data sources we will need to refer to
# later in the .tf file. They include the transport zone, tier 0 router and
# edge cluster.
#
data "nsxt_transport_zone" "overlay_tz" {
  display_name = "tz1"
}

#
# The tier 0 router (T0) is considered a "provider" router that is pre-created
# by the NSX admin. A T0 router is used for north/south connectivity between
# the logical networking space and the physical networking space. Many tier 1
# routers will be connected to a tier 0 router.
#
data "nsxt_logical_tier0_router" "tier0_router" {
  display_name = "DefaultT0Router"
}

data "nsxt_edge_cluster" "edge_cluster1" {
  display_name = "EdgeCluster1"
}

#
# This shows the settings required to create a NSX logical switch to which you
# can attach virtual machines.
#
resource "nsxt_logical_switch" "switch1" {
  admin_state       = "UP"
  description       = "LS created by Terraform"
  display_name      = "TfLogicalSwitch"
  transport_zone_id = "${data.nsxt_transport_zone.overlay_tz.id}"
  replication_mode  = "MTEP"


  tag {
    scope = "tenant"
    tag   = "second_example_tag"
  }
}
