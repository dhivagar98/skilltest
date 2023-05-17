provider "google" {
  credentials = file ("<path to SA key file>")
  project = var.gcp_project_id
  region = var.gcp_region
}

# Create GCP storage bucket
resource "google_storage_bucket" "my_bucket" {
  name          = var.bucket_name
}

# Apply read only access to bucket
resource "google_storage_bucket_iam_policy" "dhiva_bucket_policy" {
  bucket =  google_storage_bucket.my_bucket.name
  policy_data = <<EOF
  {
    "bindings":[
      {
        "role": "roles/storage.objectViewer",
        "members":["allUsers"]
      }
      ]
  }
  EOF
}


# creating VPC
resource "google_compute_network" "my_vpc" {
name = var.vpc_name
}

# create internet gateway
resource "google_compute_global_address" "my_gateway" {
  name = var.gateway_name
  purpose = var.gateway_purpose
  address_type = "EXTERNAL"
  prefix_length = var.gateway_length
}

resource "google_compute_router" "my_router" {
  name = "my-router"
  network = google_compute_network.my_vpc.self_link
  nat {
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  }
  
  # create seperate default routes for each subnet
  dynamic "interface" {
    for_each = google_compute_network.my_vpc.subnetworks
    content {
      name = interface.key
      ip_range = cidrsubnet(google_compute_network.my_vpc.ip_cidr_range,8,count.index)
      linked_vpn_tunnel = null
      linked_interconnect = null
      linked_vpc = google_compute_network.my_vpc.self_link
    }
  }
}

# create subnet
resource "google_compute_subnetwork" "my_subnet" {
  count = 3
  name = "dhiva_subnet-${count.index + 1}"
  network = google_compute_network.my_vpc.self_link
  ip_cidr_range = cidrsubnet(google_compute_network.my_vpc.ip_cidr_range,8,count.index)
}

# create a security group for each subnet
resource "google_compute_firewall" "my_security_group" {
  count = 3
  name = "dhiva_security_group-${count.index + 1}"
  network = google_compute_network.my_vpc.self_link
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  # apply security group to the subnet
  target_tags = [google_compute_network.my_subnet[count.index].name]
  
}

# create a web server instance
resource "google_compute_instance" "web_server" {
  count = 2
  name = "web-server-${count.index + 1}"
  machine_type = "n1-standard-1"
  zone = "us-central1-a"
  boot_disk {
    intialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
  network_interface {
    network = google_compute_network.my_vpc.self_link
    access_config {
      #allocate public ip address for each web server instance 
    }
  }
}

# create database server instance
resource "google_compute_instance" "db_server" {
  name = "db-server"
  machine_type = "n1-standard-2"
  zone = "us-central1-a"
   boot_disk {
    intialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
  network_interface {
    network = google_compute_network.my_vpc.self_link
    access_config {
      #allocate public ip address for each web server instance 
    }
  }
}
      
