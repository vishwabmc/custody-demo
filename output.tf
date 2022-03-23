output "postregsql_crn" {
    value = ibm_resource_instance.postgresql_cluster.crn
}

/*
output "hpcs_id" {
  value       = ibm_hpcs.hpcs.id
  description = "ID of the provisioned HPCS instance"
}
*/
