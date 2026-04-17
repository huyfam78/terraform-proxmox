terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.66.1"
    }
  }
}

provider "proxmox" {
  endpoint  = "https://10.10.84.57:8006/api2/json"
  api_token = "root@pam!terraform=YOUR_TOKEN"
  insecure  = true
}

resource "proxmox_virtual_environment_vm" "test" {
  name      = "test-vm-ci"
  node_name = "pve07"
  vm_id     = 999

  cpu {
    cores = 1
  }

  memory {
    dedicated = 1024
  }

  disk {
    datastore_id = "local"
    interface    = "scsi0"
    size         = 10
    file_format  = "raw"
    file_id      = "local:iso/jammy-server-cloudimg-amd64.img"
  }

  network_device {
    bridge = "vmbr3"
  }
}
