storage "raft" {
  path    = "/opt/vault/data"
  node_id = "node-a-eu-west-2.example.com"
  retry_join {
    auto_join = "provider=aws region=eu-west-2 tag_key=vault tag_value=eu-west-2"
  }
}
listener "tcp" {
 address = "0.0.0.0:8200"
 cluster_address = "0.0.0.0:8201"
 tls_disable = 1
}
seal "awskms" {
  region = "eu-west-2"
  kms_key_id = "12345678-abcd-1234-abcd-123456789101",
  endpoint = "example.kms.eu-west-2.vpce.amazonaws.com"
}
api_addr = "https://vault-eu-west-2.example.com:8200"
cluster_addr = " https://node-a-eu-west-2.example.com:8201"
cluster_name = "vault-prod-eu-west-2"
ui = true
log_level = "INFO"
