output "ssh_command" {
  value = "ssh -i \"ansible.pem\" ubuntu@${aws_instance.instane-ubuntu.public_dns}"
}