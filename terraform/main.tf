provider "google" {
    credentials = file(var.gcp_credentials_path)
    project = var.project_name
    region  = var.region
    zone    = var.zone
}

# prod instance
resource "google_compute_instance" "production"{
    # for scaling if needed
    count= var.instance_num
    name= "prod-${count.index + 1}"
    machine_type= "f1-micro"
    labels = {
        "server"="",
        "prod"="",
        "webapps"=""
    }
    boot_disk {
        initialize_params {
        image = "ubuntu-os-cloud/ubuntu-2004-lts"
        }
    }
    # metadata = {
    #     ssh-key= "${var.ssh_username}:${file(var.ssh_pub_key_path)}"
    # }
    network_interface {
    # A default network is created for all GCP projects
        network = "default"
        # assign static ip
        access_config {
            nat_ip= google_compute_address.static.address
        }
    }
    # user default http and https firewall
    tags = ["http-server", "https-server", "production"]
}

# stag instance
resource "google_compute_instance" "staging"{
    # for scaling if needed
    count= var.instance_num_stag
    name= "stag-${count.index + 1}"
    machine_type= "f1-micro"
    labels = {
        "server"="",
        "stag"="",
        "webapps"=""
    }
    boot_disk {
        initialize_params {
        image = "ubuntu-os-cloud/ubuntu-2004-lts"
        }
    }
    # metadata = {
    #     ssh-key= "${var.ssh_username}:${file(var.ssh_pub_key_path)}"
    # }
    network_interface {
    # A default network is created for all GCP projects
        network = "default"
        # assign static ip
        access_config {
        }
    }
    # user default http and https firewall
    tags = ["http-server", "https-server"]
}

resource "google_compute_firewall" "http-server"{
    name    = "http-server"
    network = "default"
    # for open http port
    allow {
        protocol = "tcp"
        ports    = ["80"]
    }
    # open connection from all trafic
    source_ranges = ["0.0.0.0/0"]
    
    target_tags = ["http-server"]
}

resource "google_compute_firewall" "https-server"{
    name    = "https-server"
    network = "default"
    # for open https port
    allow {
        protocol = "tcp"
        ports    = ["443"]
    }
    # open connection from all trafic
    source_ranges = ["0.0.0.0/0"]
    
    target_tags = ["https-server"]
}

# set static IPv4 addr for prod vm
resource "google_compute_address" "static" {
    name = "ipv4-address"
}