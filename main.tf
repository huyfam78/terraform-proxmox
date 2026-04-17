terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.66.1"
    }
  }
}

provider "proxmox" {
  endpoint  = "https://10.10.84.57:8006/"
  api_token = "root@pam!terraform=4c60eb75-3fbf-4c0c-af13-2b9ccfba8557"
  insecure  = true

  ssh {
    agent    = false
    username = "root"
    password = "Gnet@123a"
  }
}

resource "proxmox_virtual_environment_vm" "huy_ubuntu_auto" {
  count     = 4 
  name      = "huy-ubuntu-auto-${count.index}" 
  node_name = "pve07"
  vm_id     = 980 + count.index 

  cpu    { cores = 4 }
  memory { dedicated = 4096 }

  disk {
    datastore_id = "local"
    interface    = "scsi0"
    size         = 20
    file_format  = "raw"
    file_id      = "local:iso/jammy-server-cloudimg-amd64.img"
  }

  network_device {
    bridge  = "vmbr3"
    vlan_id = 84
  }

  initialization {
    datastore_id = "local"
    interface    = "ide0"
    
    user_account {
      username = "huypn"
      password = "huyfam0410"
    }
    
    user_data_file_id = "local:snippets/user-config.yaml"

    ip_config {
      ipv4 {
        address = "10.10.84.${151 + count.index}/24"
        gateway = "10.10.84.254"
      }
    }
  }
}
