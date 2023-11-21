# output "ssh_command" {
#   value = "ssh -i \"ansible.pem\" ec2-user@${aws_instance.instane-AL3[*].public_dns}"
# }

output "ssh_command" {
  value = [for instance in aws_instance.instane-AL3 : "ssh -i \"ansible.pem\" ec2-user@${instance.public_dns}"]
}