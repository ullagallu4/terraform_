output "ssh_command" {
  value = "ssh -i \"ansible.pem\" ubuntu@${aws_instance.instane-AL3.public_dns}"
}