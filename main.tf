terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "~> 1.39.0"
    }
    local = {
      source = "hashicorp/local"
    }
    template = {
      source = "hashicorp/template"
    }
  }
}

# Target Dallas for now
provider "ibm" {
  region = var.region
}

resource "ibm_resource_instance" "postgresql_cluster" {
  name              = "digital-custody-postgresql"
  service           = "hyperp-dbaas-postgresql"
  plan              = "postgresql-free"
  location          = var.region
  resource_group_id = "f1acae634a1a4d4bba490e91285463ae"

  //User can increase timeouts
  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }

  # HPDBaaS specific params
  parameters = {
    name: "digital-custody-pgsql-cluster",
    admin_name: "admin",
    password: "digitalCustodyPassw0rd"
    confirm_password: "digitalCustodyPassw0rd",
    db_version: "13"
    cpu: "1",
    memory: "2gib",
    service-endpoints: "public-and-private",
    storage: "5gib"
 }
}

/*
# create a HPCS instance in a region
# prior to this, we should have created the admin key
# and admin password using TKE plugin
resource ibm_hpcs hpcs {
  location             = var.region
  name                 = "digital-custody-hpcs"
  plan                 = "hpcs-hourly-uko"
  # Client-Success-Resource-Group ID: f1acae634a1a4d4bba490e91285463ae
  resource_group_id    = "f1acae634a1a4d4bba490e91285463ae"
  units                = 2
  signature_threshold  = 1
  revocation_threshold = 1
  failover_units       = 0
  service_endpoints    = "public-and-private"
  admins {
    name  = "digital-custody-hpcs-admin"
    key   = "1.sigkey"
    token = "passw0rd"
  }
  timeouts {
    create = "55m"
    delete = "55m"
  }
}
*/
