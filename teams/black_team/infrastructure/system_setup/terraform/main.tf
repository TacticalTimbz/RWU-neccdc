terraform {
    required_providers {
        proxmox = {
            source  = "bpg/proxmox"
        }
    }
}

provider "proxmox" {
    endpoint = "https://172.16.32.22:8006/api2/json"
    api_token = "terraform@pam!token=6020a97e-aa46-42d6-82f1-13633747578b"
    insecure = true
}

resource "proxmox_virtual_environment_vm" "vm_instance" {
    name = "neccdc-team1-dc-01"
    node_name = "pmhost-02"
    vm_id = 108

    clone {
    vm_id = 1000
    }

    agent {
    enabled = true
    }

    memory {
    dedicated = 4096
    }

    initialization {
        datastore_id = "CyberComp"
        ip_config {
            ipv4 {
                address = "172.16.128.100/19"
                gateway = "172.16.128.1"
            }
        }
    }

    lifecycle {
        ignore_changes = [
            initialization
        ]
    }

}

resource "proxmox_virtual_environment_vm" "vm_instance1" {
    name = "neccdc-team1-file-01"
    node_name = "pmhost-02"
    vm_id = 109

    clone {
    vm_id = 1000
    }

    agent {
    enabled = true
    }

    memory {
    dedicated = 4096
    }

    initialization {
        datastore_id = "CyberComp"
        ip_config {
            ipv4 {
                address = "172.16.128.101/19"
                gateway = "172.16.128.1"
            }
        }
    }
    lifecycle {
        ignore_changes = [
            initialization
        ]
    }
}