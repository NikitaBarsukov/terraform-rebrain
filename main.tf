terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
     }
  }
}

provider "digitalocean" {
  token = var.DO_TOKEN
# export TF_VAR_DO_TOKEN=
}


resource "digitalocean_ssh_key" "default" {
  name       = "Terraform Example"
  public_key = file("~/.ssh/id_rsa.pub")
}

variable DO_TOKEN {
}

resource "digitalocean_tag" "email" {
  name = "nikbars1997_at_gmail_com"
}

resource "digitalocean_tag" "course" {
  name = "highload"
}

resource "digitalocean_droplet" "hl-1" {
  image      = "ubuntu-18-04-x64"
  name       = "highload"
  region     = "fra1"
  size       = "s-1vcpu-1gb"
  ssh_keys   = [digitalocean_ssh_key.default.fingerprint]
  monitoring = true
  tags       = [digitalocean_tag.email.name, digitalocean_tag.course.name] 
}

output "droplet_ip_address" {
  value = digitalocean_droplet.hl-1.ipv4_address
}

