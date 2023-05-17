provider "google" {
  credentials = file ("path to SA key")
  project = "<project id>"
  region = "<select_region>"
}

# Create GCP storage bucket
resource "google_storage_bucket" "my_bucket" {
  name          = "dhiva_bucket"
  location      = "EU"
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
name = "dhiva_vpc"
}

# create internet gateway
resource "google_compute_global_address" "my_gateway" {
  name = "dhiva_gateway"
  purpose = "vpc_peering"
  address_type = "EXTERNAL"
  prefix_length = 24
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

